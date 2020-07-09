
#include "hf_in_spawn"
#include "hf_in_plot"
#include "hf_in_util"


// Tag of the possible random transitions in the area
const string ZHTRUIN_TAG_EXIT_TRANSITION = "ZhentilKeep_ToRuins";

// Number of random areas to choose from
const int ZHTRUIN_RANDOM_AREA_COUNT = 3;
// Tag of the areas to choose from, tags need to have consecutive numbering
const string ZHTRUIN_TAG_RANDOM_AREA = "zhentruin";

// Tag of the possible random transitions in the area
const string ZHTRUIN_TAG_RANDOM_TRANSITION = "WP_ZKRU_DST";
// Tag of the random encounters in the area
const string ZHTRUIN_TAG_RANDOM_ENCOUNTER = "ENCOUNTER_RandomRuins"; // = ENC_zhentruin

// Triggering object (one per area to be able to clean up old encounters)
const string ZHTRUIN_TAG_RANDOM_ENCOUNTER_TRIGGER = "WP_ZHENTRN_ENC_TRIGGER";

// Cache the number of transitions in an area for performance reasons
const string ZHTRUIN_LVAR_TRANSITION_COUNT_CACHE = "zhentruin-trans_cnt";
// Prevent transitioning to the same door twice in a row
const string ZHTRUIN_LVAR_TRANSITION_OBJECT_CACHE = "zhentruin-trans_obj";

// Encounters should be "ENC_" + PREFIX + sub area ID
const string ZHTRUIN_ENCOUNTER_NAME_PREFIX = "ZHENTRN_";

// Chance of executing a random special encounter
const int ZHTRUIN_ENCOUNTER_SPECIAL_CHANCE = 25;


// Get a random random encounter in the area
string ZHTRUIN_GetEncounterTag(object oTransitionArea);

// Get a random transition target within an area
object ZHTRUIN_GetRandomTransitionTarget(object oArea);

// Get a random area to transition to
object ZHTRUIN_GetRandomTransitionArea(object oCurrentArea, object oPC);

// Cleanup all random encounters assocuated with this sub area
void ZHTRUIN_CleanupRandomEncounter(object oTransitionTarget, object oPC);

// Execute a random encounter.
void ZHTRUIN_ExecuteRandomEncounter(object oTransitionTarget, object oPC);

// Choose a special encounter for quests, should the conditions be fulfilled
int ZHTRUIN_ExecuteSpecialEncounter(object oTransitionTarget, object oPC);

// Will first try to execute a special (quest) encounter or failing that
// execute a random encounter
void ZHTRUIN_ExecuteEncounter(object oTransitionTarget, object oPC);



object ZHTRUIN_GetRandomTransitionTarget(object oArea)
{
    object oTransition = OBJECT_INVALID;
    int nTransitionCount = GetLocalInt(oArea, ZHTRUIN_LVAR_TRANSITION_COUNT_CACHE);
    int nNth = 0;

    // Cache the total number of transition object for this map
    nNth = 0;
    if (nTransitionCount <= 0)
    {
        nTransitionCount = 0;
        oTransition = GetObjectByTag(ZHTRUIN_TAG_RANDOM_TRANSITION, nNth);
        while (GetIsObjectValid(oTransition))
        {
            if (GetArea(oTransition) == oArea)
                nTransitionCount++;

            oTransition = GetObjectByTag(ZHTRUIN_TAG_RANDOM_TRANSITION, ++nNth);
        }
        SetLocalInt(oArea, ZHTRUIN_LVAR_TRANSITION_COUNT_CACHE, nTransitionCount);
    }

    // This shouldn't happen
    if (nTransitionCount <= 0)
    {
        SendMessageToPC(GetFirstPC(), "ERROR: No transition found in area " + GetTag(oArea));
        return OBJECT_INVALID;
    }

    // Select a random one
    int nRandom = Random(nTransitionCount)+1; // GetNearestObject uses [1,N] not [0,N]
    object oRandomObject = GetFirstObjectInArea(oArea);
    oTransition = GetNearestObjectByTag(ZHTRUIN_TAG_RANDOM_TRANSITION, oRandomObject, nRandom);
    // We don't want to travel to the same transition twice in a row
    if (GetLocalObject(oArea, ZHTRUIN_LVAR_TRANSITION_OBJECT_CACHE) == oTransition)
    {
        // If we selected the same one, simply select the next
        if ((nRandom+1) <= nTransitionCount)
            nRandom = 0;
        oTransition = GetNearestObjectByTag(ZHTRUIN_TAG_RANDOM_TRANSITION, oRandomObject, nRandom);
    }
    SetLocalObject(oArea,ZHTRUIN_LVAR_TRANSITION_OBJECT_CACHE, oTransition);

    return oTransition;
}


object ZHTRUIN_GetRandomTransitionArea(object oCurrentArea, object oPC)
{
    object oNextArea = oCurrentArea;
    int nNextAreaID = 0;
    string sNextAreaTag = "";

    // Stay in current area if there is nothing to choose from
    if (ZHTRUIN_RANDOM_AREA_COUNT > 1)
    {
       // Select the next area at random
       nNextAreaID = Random(ZHTRUIN_RANDOM_AREA_COUNT);
       sNextAreaTag = ZHTRUIN_TAG_RANDOM_AREA + IntToString(nNextAreaID);
       if (GetTag(oCurrentArea) == sNextAreaTag)
       {
           // Current area was selected again, skip to next one
           nNextAreaID++;
           if (nNextAreaID >= ZHTRUIN_RANDOM_AREA_COUNT)
               nNextAreaID = 0;
           sNextAreaTag = ZHTRUIN_TAG_RANDOM_AREA + IntToString(nNextAreaID);
       }
       oNextArea = GetObjectByTag(sNextAreaTag);
    }
    return oNextArea;
}


string ZHTRUIN_GetEncounterName(object oTransitionTarget)
{
    object oIDWaypoint = GetNearestObject(OBJECT_TYPE_WAYPOINT, oTransitionTarget);
    if (GetIsObjectValid(oIDWaypoint))
        return (ZHTRUIN_ENCOUNTER_NAME_PREFIX+GetTag(oIDWaypoint));

    return "ERROR";
}


void ZHTRUIN_CleanupRandomEncounter(object oTransitionTarget, object oPC)
{
    string sEncounterName = ZHTRUIN_GetEncounterName(oTransitionTarget);
    string sEncounterTag = "ENC_"+sEncounterName;
    int nNth = 1;
    object oEncounter = GetObjectInArea(sEncounterTag, oTransitionTarget, nNth);
    while (GetIsObjectValid(oEncounter))
    {
        SpawnRemoveCreatures(oEncounter, oPC);
        SpawnRemovePlaceables(oEncounter, oPC);

        oEncounter = GetObjectInArea(sEncounterTag, oTransitionTarget, ++nNth);
    }
    SetLocalString(oTransitionTarget, "HF_SP_NAME", sEncounterName);
}


void ZHTRUIN_ExecuteRandomEncounter(object oTransitionTarget, object oPC)
{
    string sEncounterName = ZHTRUIN_GetEncounterName(oTransitionTarget);
    string sEncounterTag = "ENC_"+sEncounterName;
    int nNth = 1;
    object oEncounter = GetObjectInArea(sEncounterTag, oTransitionTarget, nNth);
    while (GetIsObjectValid(oEncounter))
    {
        SetLocalString(oEncounter, "HF_SP_WAYPOINT_NAME", "SP_"+sEncounterName);
        SetLocalString(oEncounter, "HF_SP_PLACE_NAME", "PL_"+sEncounterName);

        SpawnEncounter(oEncounter, oPC);

        oEncounter = GetObjectInArea(sEncounterTag, oTransitionTarget, ++nNth);
    }
    SetLocalString(oEncounter, "HF_SP_NAME", sEncounterName);

    // SpawnEnter(oPC, oTransitionTarget);
}


int ZHTRUIN_ExecuteSpecialEncounter(object oTransitionTarget, object oPC)
{
    // Use encounter waypoints as spawn locations
    string sEncounterTag = "ENC_"+ZHTRUIN_GetEncounterName(oTransitionTarget);
    object oSpawnWP = GetNearestObjectByTag(sEncounterTag, oTransitionTarget);
    object oCreature = OBJECT_INVALID;

    // Clean up old special encounters (in case the PC has fled)
    oCreature = GetObjectByTag("TheRender");
    if (GetIsObjectValid(oCreature))
        DestroyObject(oCreature);
    oCreature = GetObjectByTag("tm_cr_zrn_rdrag0");
    if (GetIsObjectValid(oCreature))
        DestroyObject(oCreature);
    oCreature = GetObjectByTag("tm_cr_zrn_wdrag0");
    if (GetIsObjectValid(oCreature))
        DestroyObject(oCreature);

    // No suitable WP to spawn creatures at
    if (!GetIsObjectValid(oSpawnWP))
    {
        SendMessageToPC(GetFirstPC(), "This area is deserted.");
        return FALSE;
    }

    if (Random(100) > ZHTRUIN_ENCOUNTER_SPECIAL_CHANCE)
    {
        return FALSE;
    }

    // Quest: Big Game Hunt
    // The Render may spawns if the quest is active and the PC carries a vial of elven blood
    if ( (PlotLevelGet("biggamehunt_status_main") == 1) && // Quest active
         (PlotLevelGet("biggamehunt_status_rend") <= 1) && // Render not yet killed
         (GetIsObjectValid(GetItemPossessedBy(oPC, "VialofElvenBlood"))) )
    {
        // Remove the old Render if it still exists
        oCreature = GetObjectByTag("TheRender");
        if (GetIsObjectValid(oCreature))
            DestroyObject(oCreature);
        // 25% chance to spawn a new one
        oCreature = CreateObject(OBJECT_TYPE_CREATURE, "therender", GetLocation(oSpawnWP));
        return TRUE;
    }
    // Unique Red dragon encounter
    else if (PlotLevelGet("zhentrn_enc_rdrag_done") < 1)
    {
        oCreature = CreateObject(OBJECT_TYPE_CREATURE, "tm_cr_zrn_rdrag0", GetLocation(oSpawnWP));
        return TRUE;
    }
    // Unique White dragon encounter
    else if (PlotLevelGet("zhentrn_enc_wdrag_done") < 1)
    {
        oCreature = CreateObject(OBJECT_TYPE_CREATURE, "tm_cr_zrn_wdrag0", GetLocation(oSpawnWP));
        return TRUE;
    }

    return FALSE;
}


void ZHTRUIN_ExecuteEncounter(object oTransitionTarget, object oPC)
{
    ZHTRUIN_CleanupRandomEncounter(oTransitionTarget, oPC);

    // Check if we are to spawn a special encounter for quests, etc.
    if (!ZHTRUIN_ExecuteSpecialEncounter(oTransitionTarget, oPC))
        ZHTRUIN_ExecuteRandomEncounter(oTransitionTarget, oPC);
}
