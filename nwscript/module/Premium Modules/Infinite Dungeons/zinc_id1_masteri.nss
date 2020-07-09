//::////////////////////////////////////////////////////////////////////////////
//:: inc_id1_masterius
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Main include file for the fight with Masterius. Contians relevant constants
    and functions.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 30, 2005
//::////////////////////////////////////////////////////////////////////////////



#include "inc_id1_boss"
#include "inc_id1_creature"



/*------------------------------------------------------------------------------
    CONSTANTS
------------------------------------------------------------------------------*/



// Waypoint tag constants.
const string MASTERIUS_WP_TAG = "ID1_STATIC_WP_MASTERIUS";
const string MINION_WP_TAG = "ID1_STATIC_WP_MINION";
const string TORCH_WP_TAG = "ID1_STATIC_WP_TORCH";

// Placeable object resref and tag constants.
const string CORPSE_PILE_RESREF = "id1_corpse_plc";
const string CORPSE_PILE_TAG = "id1_corpse_plc";

// Item resref constants.
const string TORCH_RESREF = "nw_it_torch001";

// Creature resref constants.
const string GHOUL_RESREF = "id1_reaper";



/*------------------------------------------------------------------------------
    FUNCTION PROTOTYPES
------------------------------------------------------------------------------*/



// Name: Setup
//
// Defined in: inc_id1_masteriu
//
// Setup function. Spawns in temporary placeables and creatures.
//
// Parameters:
// NONE
//
// Return:
// NONE
void Setup();

// Name: Burn Pyre
//
// Defined in: inc_id1_masterius
//
// Causes a pile of corpses to be set on fire and subsequently burn away.
//
// Parameters:
// oPyre - The pile of corpses to be destroyed.
//
// Return:
// NONE.
void BurnPyre(object oPyre);

void CreateMasterius();
void CreateCorpsePiles();
void CreateTorches();

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

    // check to see if boss area has been setup already
    if (GetLocalInt(oDungeon, "bBossActivated") == FALSE)
    {
        DebugMessage("  Area has never been activated before.");

        // boss level stats have been determined
        SetLocalInt(oDungeon, "bBossActivated", TRUE);

        // level of all PCs in the dungeon has been determined
        nLevel = GetEncounterLevel(GetFirstPC(), TRUE);

        // adjust for final boss
        nLevel += 4;

        // record the boss level
        SetLocalInt(oDungeon, "nBossLevel", nLevel);
    } else
    {
        DebugMessage("  Area has been activated before.");

        nLevel = GetLocalInt(oDungeon, "nBossLevel");
    }
    DebugMessage("  Boss level is " + IntToString(nLevel));

    int bQuestCompleted = GetLocalInt(GetModule(), "bMasteriusQuestCompleted");
    int bHostile = GetLocalInt(GetModule(), "bMasteriusHostile");
    int bQuestActive = GetLocalInt(GetModule(), "bMasteriusQuestActive");
    int bSurrender = GetLocalInt(GetModule(), "bMasteriusSurrender");
    int bSurrender2 = GetLocalInt(GetModule(), "bMasteriusSurrender2");
    int bDead = GetLocalInt(GetModule(), "bMasteriusDead");
    DebugMessage("  Masterius Completed = " + IntToString(bQuestCompleted) + ", Hostile = " + IntToString(bHostile) + ", Active = " + IntToString(bQuestActive) + ", Surrender = " + IntToString(bSurrender) + ", Surrender2 = " + IntToString(bSurrender2) + ", Dead = " + IntToString(bDead));

    // if quest completed
    if ((bQuestCompleted == TRUE) || (bDead == TRUE))
    {
        // spawn scenery only

        // enable and spawn the boss lair teleporter
        object oTeleporter = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER", GetFirstObjectInArea(OBJECT_SELF));
        SetMapPinEnabled(oTeleporter, TRUE);
        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oTeleporter));
        DebugMessage("Teleporter is in area " + GetTag(GetArea(oTeleporter)));
    } else if (bHostile == TRUE) // if boss hostile
    {
        // spawn full boss battle

        // create masterius
        CreateMasterius();

        // create corpse piles
        CreateCorpsePiles();

        // create torches
        CreateTorches();
    } else if (bQuestActive == TRUE) // if quest active
    {
        // spawn scenery and passive boss

        // create masterius
        CreateMasterius();

        // change to neutral faction
        ChangeFaction(GetObjectByTag(MASTERIUS_TAG), GetObjectByTag("DungeonAngel"));

        // enable and spawn the boss lair teleporter
        object oTeleporter = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER", GetFirstObjectInArea(OBJECT_SELF));
        SetMapPinEnabled(oTeleporter, TRUE);
        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oTeleporter));
        DebugMessage("Teleporter is in area " + GetTag(GetArea(oTeleporter)));
    } else if ((bSurrender == TRUE) || (bSurrender2 == TRUE)) // if boss has surrendered
    {
        // spawn scenery and passive boss

        // create masterius
        CreateMasterius();

        // change to neutral faction
        ChangeFaction(GetObjectByTag(MASTERIUS_TAG), GetObjectByTag("DungeonAngel"));
    } else // if boss has not been met
    {
        // spawn full boss battle

        // create masterius
        CreateMasterius();

        // create corpse piles
        CreateCorpsePiles();

        // create torches
        CreateTorches();
    }
}

void CreateMasterius()
{
    object oWaypoint = DB_GetWaypointByTag(MASTERIUS_WP_TAG);
    location lLocation = GetLocation(oWaypoint);

    int nEnc = GetEncounterLevel(GetFirstPC(), TRUE);

    object oMasterius = DB_CreateObject(OBJECT_TYPE_CREATURE, MASTERIUS_TAG, lLocation);

    SetLocalInt(oMasterius, "nCreatureType", 3);
    SetLocalInt(oMasterius, "nCR", nEnc + 4);
    SetLocalInt(oMasterius, "nBaseHD", 1);
    SetLocalInt(oMasterius, "nClassStartHD", 5);
    SetLocalInt(oMasterius, "nClass", 10);
}

void CreateCorpsePiles()
{
    object oMasterius = DB_GetWaypointByTag(MASTERIUS_WP_TAG);

    int nCorpsePile = 1;
    object oWaypoint = DB_GetNearestObjectByTag(MINION_WP_TAG, oMasterius, nCorpsePile);
    location lLocation;
    while (GetIsObjectValid(oWaypoint) == TRUE)
    {
        lLocation = GetLocation(oWaypoint);
        DB_CreateObject(OBJECT_TYPE_PLACEABLE, CORPSE_PILE_RESREF, lLocation);

        nCorpsePile++;

        oWaypoint = DB_GetNearestObjectByTag(MINION_WP_TAG, oMasterius, nCorpsePile);
    }
}

void CreateTorches()
{
    object oMasterius = DB_GetWaypointByTag(MASTERIUS_WP_TAG);

    int nTorch = 1;
    object oWaypoint = DB_GetNearestObjectByTag(TORCH_WP_TAG, oMasterius, nTorch);
    location lLocation;
    while (GetIsObjectValid(oWaypoint) == TRUE)
    {
        lLocation = GetLocation(oWaypoint);
        DB_CreateObject(OBJECT_TYPE_ITEM, TORCH_RESREF, lLocation);

        nTorch++;

        oWaypoint = DB_GetNearestObjectByTag(TORCH_WP_TAG, oMasterius, nTorch);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: BurnPyre
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 18, 2005
//::////////////////////////////////////////////////////////////////////////////
void BurnPyre(object oPyre)
{
    location lLoc = GetLocation(oPyre);
    effect eFlame = EffectVisualEffect(VFX_IMP_FLAME_M);
    object oFlame = DB_CreateObject(OBJECT_TYPE_PLACEABLE, "PLC_FLAMELARGE", lLoc);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFlame, lLoc);

    AssignCommand(oFlame, DestroyObject(oFlame, 4.0));

    DestroyObject(oPyre, 3.0);
}

//void main(){}

