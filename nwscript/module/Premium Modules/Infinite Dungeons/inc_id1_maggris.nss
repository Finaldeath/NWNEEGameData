//::////////////////////////////////////////////////////////////////////////////
//:: inc_id1_maggris
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Main include file for the fight with Maggris. Contians relevant constants
    and functions.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 30, 2005
//::////////////////////////////////////////////////////////////////////////////



#include "inc_id1_boss"
#include "inc_id1_creature"


// void main () {}


/*------------------------------------------------------------------------------
    CONSTANTS
------------------------------------------------------------------------------*/



// Placeable object resrefs.
const string COCOON_RESREF = "id1_cocoon";

// Creature resrefs.
const string INSECT_RESREF_1 = "id_spiddire_m";
const string INSECT_RESREF_2 = "id_spidgiant_m";
const string INSECT_RESREF_3 = "id_spiderqueen_m";
const string INSECT_RESREF_4 = "id_spidswrd_m";
const string INSECT_RESREF_5 = "id_btlbomb_m";
const string INSECT_RESREF_6 = "id_btlstag_m";
const string INSECT_RESREF_7 = "id_btlstink_m";

// Placeable object tags.
const string COCOON_TAG = "ID1_COCOON";

// Waypoint tag constants.
const string MAGGRIS_WP_TAG = "ID1_STATIC_WP_MAGGRIS";
const string MINION_WP_TAG = "ID1_STATIC_WP_MINION";

// Variables name constants.
const string HATCH_TIMER = "nHatchTimer";
const string SUMMON_COUNTER = "nSummon";
const string MINION_COUNTER = "nMinions";

const int MAX_MINIONS = 4;


/*------------------------------------------------------------------------------
    FUNCTION PROTOTYPES
------------------------------------------------------------------------------*/



// Name: Setup
//
// Defined in: inc_id1_maggris
//
// Setup function. Spawns in temporary placeables and creatures.
//
// Parameters:
// NONE
//
// Return:
// NONE
void Setup();

// Name: Hatch Cocoon
//
// Defined in: inc_id1_maggris
//
// Call back function that catalyzes a cocoon to hatch and unleash some spiders.
//
// Parameters:
// NONE
//
// Return:
// NONE
void HatchCocoon();

// Name: Get Random Insect ResRef
//
// Defined in: inc_id1_maggris
//
// This function establishes and returns a random creature blueprint resref. The
// resref will be to an insect blueprint, either a giant spider of beetle of
// some sort.
//
// Parameters:
// NONE
//
// Return:
// A sting resref that can be used to creature the creature.
string GetRandomInsectResRef();

// Name: Create Maggris
//
// Defined in: inc_id1_maggris
//
// Creates Maggris.
//
// Parameters:
// NONE
//
// Return:
// An object reference to Maggris.
object CreateMaggris();

// Name: Create Cocoons
//
// Defined in: inc_id1_maggris
//
// Createst he cocoons in maggris' area.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreateCocoons();

// Name: Action Create Cocoon
//
// Defined in: inc_id1_maggris
//
// Has the actions subject (Maggris) spit a web that spawns in a new cocoon
// placeable.
//
// Parameters:
// NONE
//
// Return:
// NONE
void ActionCreateCocoon();

// Name: Create Cocoon
//
// Defined in: inc_id1_maggris
//
// Wrapper function for CreateObject to allow for a delay.
//
// Parameters:
// lLocation - The location at which the cocoon should be created.
//
// Return:
// NONE
void CreateCocoon(location lLocation);

// Name: Activate Nearby Cocoons
//
// Defined in: inc_id1_maggris
//
// Activates any cocoons within 20.0 of the object executing the function.
//
// Parameters:
// NONE
//
// Return:
// NONE
void ActivateNearbyCocoons();



/*------------------------------------------------------------------------------
    FUNCTION IMPLEMENTATIONS
------------------------------------------------------------------------------*/



//::////////////////////////////////////////////////////////////////////////////
//:: Setup
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 30, 2005
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

    int bQuestCompleted = GetLocalInt(GetModule(), "bMaggrisQuestCompleted");
    int bHostile = GetLocalInt(GetModule(), "bMaggrisHostile");
    int bQuestActive = GetLocalInt(GetModule(), "bMaggrisQuestActive");
    int bSurrender = GetLocalInt(GetModule(), "bMaggrisSurrender");
    int bSurrender2 = GetLocalInt(GetModule(), "bMaggrisSurrender2");

    DebugMessage("  Maggris Completed = " + IntToString(bQuestCompleted) + ", Hostile = " + IntToString(bHostile) + ", Active = " + IntToString(bQuestActive) + ", Surrender = " + IntToString(bSurrender) + ", Surrender2 = " + IntToString(bSurrender2));

    object oMaggris;

    int bDead = GetLocalInt(oDungeon, "bBossDead");
    DebugMessage("bDead is " + IntToString(bDead));
    if (bDead == TRUE)
    {
        return;
    }

    if (!bQuestCompleted && !bDead)
    {
        oMaggris = CreateMaggris();
        if (bHostile == TRUE)
        {
            SetImmortal(oMaggris, FALSE);
        }
    }

    if ((bSurrender || bSurrender2) && !bHostile)
    {
        // Change to the neutral faction stored on the Dungeon angel.
        ChangeFaction(GetObjectByTag(MAGGRIS_TAG), GetObjectByTag("DungeonAngel"));

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
        CreateCocoons();

        //LockArea();
    }

    // Generate some loot for the boss should the player choose to kill them.
    BossGenerateLoot(oMaggris);
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateMaggris
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 12, 2006
//::////////////////////////////////////////////////////////////////////////////
object CreateMaggris()
{
    object oWaypoint = DB_GetWaypointByTag(MAGGRIS_WP_TAG);
    object oDungeon = GetCurrentDungeon();
    location lLocation = GetLocation(oWaypoint);

    // Encounter level.
    int nEnc = GetLocalInt(oDungeon, "nBossLevel");

    object oMaggris = DB_CreateObject(OBJECT_TYPE_CREATURE, MAGGRIS_TAG, lLocation);

    // Level up information.
    SetLocalInt(oMaggris, "nCreatureType", 3);
    SetLocalInt(oMaggris, "nCR", nEnc + 4);
    SetLocalInt(oMaggris, "nBaseHD", 1);
    SetLocalInt(oMaggris, "nClass", -1);

    // Special attack information.
    SetLocalInt(oMaggris, SUMMON_COUNTER, 3);

    return oMaggris;
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateCocoons
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On:Feb 12, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreateCocoons()
{
    object oMaggris = DB_GetWaypointByTag(MAGGRIS_WP_TAG);
    location lLocation;
    int nCocoon = 1;

    object oWaypoint = DB_GetNearestObjectByTag(MINION_WP_TAG, oMaggris, nCocoon);

    // Cycle all the cocoon waypoints in the area creating cocoons.
    while (GetIsObjectValid(oWaypoint))
    {
        lLocation = GetLocation(oWaypoint);
        DB_CreateObject(OBJECT_TYPE_PLACEABLE, COCOON_RESREF, lLocation);

        nCocoon++;

        oWaypoint = DB_GetNearestObjectByTag(MINION_WP_TAG, oMaggris, nCocoon);
    }

}

//::////////////////////////////////////////////////////////////////////////////
//:: HatchCocoon
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 5, 2005
//::////////////////////////////////////////////////////////////////////////////
void HatchCocoon()
{
    // If Maggris has surrendered, stop hatching.
    object oMaggris = DB_GetObjectByTag(MAGGRIS_TAG);

    if (GetLocalInt(GetModule(), "bMaggrisSurrender") == TRUE)
    {
        return;
    }

    object oCocoon = OBJECT_SELF;
    effect eVFX = EffectVisualEffect(VFX_COM_CHUNK_GREEN_MEDIUM);
    int nHatch = GetLocalInt(oCocoon, HATCH_TIMER);

    // The cocoon should only hatch when it's timer is up.
    if (GetLocalInt(oCocoon, HATCH_TIMER) >= Random(6) + 3)
    {
        // Update Maggris' minon counter.
        int nCount = GetLocalInt(oMaggris, MINION_COUNTER);

        nCount++;

        SetLocalInt(oMaggris, MINION_COUNTER, nCount);

        // Determine the target challenge rating of the bug being created.
        object oDungeon = GetCurrentDungeon();
        int nCR = GetLocalInt(oDungeon, "nBossLevel") - 4;

        if (nCR > 1) nCR = 1;

        // Destroy the cocoon underneath a gross visual effect.
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oCocoon);

        // On the location of the cocoon create and insect.
        location lLoc = GetLocation(oCocoon);

        // Use a random blueprint for the insect to be created.
        string sSpiderResRef = GetRandomInsectResRef();

        object oBug = DB_CreateObject(OBJECT_TYPE_CREATURE, sSpiderResRef, lLoc, FALSE, MINION_TAG);

        // Set level up information on the bug.
        SetLocalInt(oBug, "nCreatureType", 3);
        SetLocalInt(oBug, "nCR", nCR);
        SetLocalInt(oBug, "nBaseHD", 1);
        SetLocalInt(oBug, "nClass", -1);

        DestroyObject(oCocoon);
    }
    else
    {
        nHatch++;

        SetLocalInt(oCocoon, HATCH_TIMER, nHatch);

        float fDelay = 1.0;

        DelayCommand(fDelay, HatchCocoon());
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetRandomInsectResRef
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 13, 2005
//::////////////////////////////////////////////////////////////////////////////
string GetRandomInsectResRef()
{
    int nRand = Random(7);
    string sResRef;

    // Based on a random number determine a resref from the list of constants.
    switch(nRand)
    {
        case 0:
        {
            sResRef = INSECT_RESREF_1;
            break;
        }
        case 1:
        {
            sResRef = INSECT_RESREF_2;
            break;
        }
        case 2:
        {
            sResRef = INSECT_RESREF_3;
            break;
        }
        case 3:
        {
            sResRef = INSECT_RESREF_4;
            break;
        }
        case 4:
        {
            sResRef = INSECT_RESREF_5;
            break;
        }
        case 5:
        {
            sResRef = INSECT_RESREF_6;
            break;
        }
        case 6:
        {
            sResRef = INSECT_RESREF_6;
            break;
        }
    } // end switch

    return sResRef;
}

//::////////////////////////////////////////////////////////////////////////////
//:: ActionCreateCocoon
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 28, 2006
//::////////////////////////////////////////////////////////////////////////////
void ActionCreateCocoon()
{
    // Establish a random location near the action subject within 10.0 meters.
    object oThis = OBJECT_SELF;
    object oArea = GetArea(oThis);
    vector vPos = GetPosition(oThis);
    location lLoc = GetLocation(oThis);
    float fFacing = GetFacingFromLocation(lLoc);

    float fX = vPos.x;
    float fY = vPos.y;
    float fZ = vPos.z;

    // The new position should be generally in front of the action subject.
    if (fFacing < 90.0)
    {
        fX -= IntToFloat(Random(5) + 2);
        fY += IntToFloat(Random(5) + 2);
    }
    else if (fFacing < 180.0)
    {
        fX -= IntToFloat(Random(5) + 2);
        fY -= IntToFloat(Random(5) + 2);
    }
    else if (fFacing < 270.0)
    {
        fX += IntToFloat(Random(5) + 2);
        fY -= IntToFloat(Random(5) + 2);
    }
    else
    {
        fX += IntToFloat(Random(5) + 2);
        fY -= IntToFloat(Random(5) + 2);
    }

    vPos = Vector(fX, fY, fZ);
    lLoc = Location(oArea, vPos, 0.0);

    // Have the action subject fire a fake web spell at the location.
    ActionCastSpellAtLocation(SPELL_WEB, lLoc, METAMAGIC_ANY, TRUE);

    // A short time later create a new cocoon placeable at the location.
    AssignCommand(GetModule(), DelayCommand(2.0, CreateCocoon(lLoc)));
}

//::////////////////////////////////////////////////////////////////////////////
//::void CreateCocoon(location lLocation)
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 28, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreateCocoon(location lLocation)
{
    DB_CreateObject(OBJECT_TYPE_PLACEABLE, COCOON_RESREF, lLocation);
}

//::////////////////////////////////////////////////////////////////////////////
//:: ActivateNearbyCocoons
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: March 24, 2006
//::////////////////////////////////////////////////////////////////////////////
void ActivateNearbyCocoons()
{
    // Cycle the nearest cocoons.
    int nNth = 1;

    object oThis = OBJECT_SELF;
    object oCocoon = DB_GetNearestObjectByTag(COCOON_TAG);

    float fDistance = GetDistanceBetween(oThis, oCocoon);

    // While the cocoons are valid and within 20 of the object hatch them.
    while (GetIsObjectValid(oCocoon) && fDistance < 20.0)
    {
        AssignCommand(oCocoon, HatchCocoon());

        nNth++;

        oCocoon = DB_GetNearestObjectByTag(COCOON_TAG, oThis, nNth);
        fDistance = GetDistanceBetween(oThis, oCocoon);
    }
}
