//::////////////////////////////////////////////////////////////////////////////
//:: inc_id1_hagatha
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Main include file for the battle with Hagatha, contains constants and
    functions used throughout the fight.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 27, 2005
//::////////////////////////////////////////////////////////////////////////////



#include "inc_id1_boss"
#include "inc_id1_creature"



// DEBUG
// void main () {}



/*------------------------------------------------------------------------------
    CONSTANTS
------------------------------------------------------------------------------*/



// Placeable object resref constants.
const string TOTEM_RESREF = "id1_skullpole";

// Waypoint tag constants.
const string HAGATHA_WP = "ID1_STATIC_WP_HAGATHA";
const string TOTEM_WP_PRFX = "ID1_STATIC_WP_TOTEM_";
const string MINION_WP_PRFX = "ID1_STATIC_WP_MINION_";

// Variable name constants.
const string TOTEM_POWER = "nPower";
const string TOTEM_COUNTER_TOTAL = "nCountTotal";
const string TOTEM_COUNTER_CURRENT = "nCountCurrent";
const string TOTEM_WP_NUM = "nTotemWP";
const string TOTEM_DESTROYED = "bTotemDestroyed";

// Totem power constants.
const int TOTEM_POWER_FIREBALL = 1;
const int TOTEM_POWER_LIGHTNING = 2;
const int TOTEM_POWER_WIND = 3;
const int TOTEM_POWER_DAMAGE_REDUCTION = 4;
const int TOTEM_POWER_DAMAGE_INCREASE = 5;
const int TOTEM_POWER_HEAL = 6;

const int TOTEM_POWER_TYPES = 6; // The number of different possible powers.

// Totem target constants.
// Single enemey target; requires a beam from the totem to the target.
const int TARGET_SINGLE = 1;
// Multiple enemy area of effect; requries damage applied to all in a sphere.
const int TARGET_AOE = 2;
// Boss/Owner target; requires a beam to the owner of the totem (Hagatha).
const int TARGET_BOSS = 3;


/*------------------------------------------------------------------------------
    FUNCTION PROTOTYPES
------------------------------------------------------------------------------*/



// Name: Setup
//
// Defined in: inc_id1_haratha
//
// This function set's up the battle and establishes the initial state.
// Placeables are spawned in etc.
//
// Parameters:
// NONE
//
// Return:
// NONE
void Setup();

// Name: Create Hagatha
//
// Defined in: inc_id1_hagatha
//
// Creates Hagatha at her pre-determined waypoint and set some level up
// variables on her.
//
// Parameters:
// NONE
//
// Return:
// An object reference to Hagatha as created by the method.
object CreateHagatha();

// Name: Create Totems
//
// Defined in: inc_id1_hagatha
//
// Creates the initial set of totems in Hagatha's area.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreateTotems();

// Name: Create Minions
//
// Defined in: inc_id1_hagatha
//
// Creates some giant minions for hagatha.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreateMinions();

// Name: Action Create Crystal
//
// Defined in: ahb_id1_hagatha
//
// Has the action subject cast a fake spell at one of the totem waypoints after
// which the totem is restored (re-created) and begins to produce and effect
// once again.
//
// Parameters:
// nWaypoint - The number of the waypoint at which the totem will be summoned.
// nTotemType - The type of totem to be created. If this argument is zero a
//              random type will be chosen.
//
// Return:
// NONE
void ActionCreateTotem(int nWaypoint, int nTotemType = 0);

// Name: Summon Totem
//
// Defined in: ahb_id1_hagatha
//
// Summons a totem to assist Hagatha in the battle.
//
// Parameters:
// lTarget - The location at which the totem should be summoned.
// nPower - The power the totem that is summoned should have; one of the
//          constants: TOTEM_POWER_*. If this parameter is 0 a power will be
//          determined randomly.
// nWaypoint - The number of the waypoint the totem is being created on. This
//             is used to determine if a totem has been destroyed.
//
// Return:
// NONE
void SummonTotem(location lTarget, int nPower = 0, int nWaypoint = 0);



/*------------------------------------------------------------------------------
    FUNCTION IMPLEMENTATIONS
------------------------------------------------------------------------------*/



//::////////////////////////////////////////////////////////////////////////////
//:: Setup
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 27, 2005
//::////////////////////////////////////////////////////////////////////////////
void Setup()
{
    int nLevel;

    // get dungeon
    object oDungeon = GetCurrentDungeon();

    // Set the boss level as having been activated.
    SetLocalInt(oDungeon, BOSS_ACTIVATED, TRUE);

    // check to see if boss area has been setup already
    if (GetLocalInt(oDungeon, BOSS_GENERATED) == FALSE)
    {
        DebugMessage("  Area has never been activated before.");

        // boss level stats have been determined
        SetLocalInt(oDungeon, BOSS_GENERATED, TRUE);

        int nPartyLevel;
        nPartyLevel = GetPartyLevel(GetFirstPC(), TRUE);
        nPartyLevel += 2;
        DebugMessage("  Party level is " + IntToString(nPartyLevel));

        int nPartySize = GetPartySize(GetFirstPC(), TRUE);
        DebugMessage("  Party size is " + IntToString(nPartySize));

        nPartyLevel = GetPartyLevelSize(nPartyLevel, nPartySize);

        int nDifficulty = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_DIFFICULTY);
        DebugMessage("  Encounter difficulty adjustment is " + IntToString(nDifficulty));
        nPartyLevel += nDifficulty;
        DebugMessage("    Party level adjusted for difficulty is " + IntToString(nPartyLevel));

        // level of all PCs in the dungeon has been determined
        nLevel = nPartyLevel;

        // record the boss level
        SetLocalInt(oDungeon, "nBossLevel", nLevel);
    }
    else
    {
        DebugMessage("  Area has been activated before.");

        nLevel = GetLocalInt(oDungeon, "nBossLevel");
    }

    DebugMessage("  Boss level is " + IntToString(nLevel));

    int bQuestCompleted = GetLocalInt(GetModule(), "bHagathaQuestCompleted");
    int bHostile = GetLocalInt(GetModule(), "bHagathaHostile");
    int bQuestActive = GetLocalInt(GetModule(), "bHagathaQuestActive");
    int bSurrender = GetLocalInt(GetModule(), "bHagathaSurrender");
    int bSurrender2 = GetLocalInt(GetModule(), "bHagathaSurrender2");

    DebugMessage("  Hagatha Completed = " + IntToString(bQuestCompleted) + ", Hostile = " + IntToString(bHostile) + ", Active = " + IntToString(bQuestActive) + ", Surrender = " + IntToString(bSurrender) + ", Surrender2 = " + IntToString(bSurrender2));

    object oHagatha;

    int bDead = GetLocalInt(oDungeon, "bBossDead");
    DebugMessage("bDead is " + IntToString(bDead));
    if (bDead == TRUE)
    {
        return;
    }

    // If Hagatha's quest has not yet been completed she should appear.
    if (!bQuestCompleted && !bDead)
    {
        oHagatha = CreateHagatha();
        if (bHostile == TRUE)
        {
            SetImmortal(oHagatha, FALSE);
        }
    }

    // If Hagatha has previosly surrendered she should not be hostile.
    if ((bSurrender || bSurrender2) && !bHostile)
    {
        ChangeFaction(oHagatha, GetObjectByTag("DungeonAngel"));

        // If the quest is completed or currently active make a teleporter.
        if (bQuestCompleted || bQuestActive)
        {
            object oTeleporter = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER", GetFirstObjectInArea(OBJECT_SELF));

            SetMapPinEnabled(oTeleporter, TRUE);

            CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oTeleporter));

            DebugMessage("Teleporter is in area " + GetTag(GetArea(oTeleporter)));
        }
    }
    else // Set up the fight.
    {
        CreateTotems();
        CreateMinions();
        //LockArea();
    }

    // Generate some loot for the boss should the player choose to kill them.
    BossGenerateLoot(oHagatha);
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateHagatha
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 08, 2006
//::////////////////////////////////////////////////////////////////////////////
object CreateHagatha()
{
    // Summon Hagatha at her standard waypoint.
    object oWaypoint = DB_GetWaypointByTag(HAGATHA_WP);
    object oDungeon = GetCurrentDungeon();

    location lLocation = GetLocation(oWaypoint);

    int nEncounter = GetLocalInt(oDungeon, "nBossLevel");

    object oHagatha = DB_CreateObject(OBJECT_TYPE_CREATURE, HAGATHA_TAG, lLocation);

    SetLocalInt(oHagatha, "nCreatureType", 3);
    SetLocalInt(oHagatha, "nCR", nEncounter + 4);
    SetLocalInt(oHagatha, "nBaseHD", 1);
    SetLocalInt(oHagatha, "nClassStart", 5);
    SetLocalInt(oHagatha, "nClass", 10);

    return oHagatha;
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateTotems
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 09, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreateTotems()
{
    object oWaypoint;
    location lLoc;
    object oTotem;

    int i, nPower;

    // Create 10 totems to start in the area of hagatha.
    for (i = 1; i <= 10; ++i)
    {
        oWaypoint = DB_GetWaypointByTag(TOTEM_WP_PRFX + IntToString(i));
        lLoc = GetLocation(oWaypoint);

        // The first four totems are close to hagatha and can be of any type.
        if (i < 5)
        {
            nPower = Random(6) + 1;
        }
        else // Other totems can only be of the attacking type.
        {
            nPower = Random(3) + 1;
        }

        SummonTotem(lLoc, nPower, i);

        // Redundant logic for completeness.
        SetLocalInt(oWaypoint, TOTEM_DESTROYED, FALSE);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateMinions
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On:Feb 09, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreateMinions()
{
    // First establish the desired CR.
    object oDungeon = GetCurrentDungeon();
    int nCR = GetLocalInt(oDungeon, "nBossLevel");

    // variables
    object oWaypoint;
    object oMinion;
    string sResref;
    location lLoc;
    int i, nRand;

    // Iterate the 6 minion waypoints creating giants.
    for (i = 1; i < 7; ++i)
    {
        oWaypoint = DB_GetObjectByTag(MINION_WP_PRFX + IntToString(i));

        lLoc = GetLocation(oWaypoint);

        nRand = Random(100);

        if (nRand > 70) sResref = "id_ettin";
        else sResref = "id_gnthill";

        oMinion = DB_CreateObject(OBJECT_TYPE_CREATURE, sResref, lLoc, FALSE, MINION_TAG);

        //Record level up information.
        SetLocalInt(oMinion, "nCreatureType", 3);
        SetLocalInt(oMinion, "nCR", nCR);
        SetLocalInt(oMinion, "nBaseHD", 1);
        SetLocalInt(oMinion, "nClass", -1);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: ActionCreateTotem
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 09, 2006
//::////////////////////////////////////////////////////////////////////////////
void ActionCreateTotem(int nWaypoint, int nTotemType = 0)
{
    object oWaypoint = DB_GetWaypointByTag(TOTEM_WP_PRFX + IntToString(nWaypoint));

    SetLocalInt(oWaypoint, TOTEM_DESTROYED, FALSE);

    location lSource = GetLocation(OBJECT_SELF);
    location lTarget = GetLocation(oWaypoint);

    ActionForceMoveToObject(oWaypoint, TRUE, 2.0);

    // Have the action subject appear to cast a spell.
    ActionCastFakeSpellAtLocation(SPELL_HORRID_WILTING, lTarget);

    float fDistance = GetDistanceBetweenLocations(lSource, lTarget);

    DelayCommand((fDistance / 3.0) + 1.0, AssignCommand(GetModule(), SummonTotem(lTarget, 0)));
    DelayCommand(fDistance / 3.0, SetCommandable(TRUE));
}

//::////////////////////////////////////////////////////////////////////////////
//:: SummonTotem
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 09, 2006
//::////////////////////////////////////////////////////////////////////////////
void SummonTotem(location lTarget, int nPower = 0, int nWaypoint = 0)
{
    // First check to make sure Hagatha hasn't surrendered while summoning.
    object oHagatha = DB_GetObjectByTag(HAGATHA_TAG);

    if (GetPlotFlag(oHagatha)) return;

    object oTotem = DB_CreateObject(OBJECT_TYPE_PLACEABLE, TOTEM_RESREF, lTarget, FALSE, MINION_TAG);
    effect eVFX_1 = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    effect eVFX_2 = EffectVisualEffect(VFX_IMP_DESTRUCTION);

    // Some flashy visual display where the totem is summoned.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX_1, lTarget);
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX_2, oTotem));

    if (nPower == 0)
    {
        nPower = Random(6) + 1;
    }

    SetLocalInt(oTotem, TOTEM_POWER, nPower);

    // The totem will only fire every 0 - 4 + (8 - level) heartbeats.
    // 7-11 heartbeats for a level 1 character.
    // 0-4 for level 8 and above.
    object oDungeon = GetCurrentDungeon();
    int nLevel = 8 - GetLocalInt(oDungeon, "nBossLevel");

    if (nLevel < 1) nLevel = 1;

    int nCounter = Random(5) + nLevel;

    SetLocalInt(oTotem, TOTEM_COUNTER_TOTAL, nCounter);
    SetLocalInt(oTotem, TOTEM_WP_NUM, nWaypoint);
}
