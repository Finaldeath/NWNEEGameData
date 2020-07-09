//::////////////////////////////////////////////////////////////////////////////
//:: inc_id1_harat
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Main include file for the battle with Harat. Contains constants and
    functions used throughout the battle.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 28, 2005
//::////////////////////////////////////////////////////////////////////////////



#include "inc_id1_boss"
#include "inc_id1_creature"



/*------------------------------------------------------------------------------
    CONSTANTS
------------------------------------------------------------------------------*/



// Creature resref constants.
const string MINION_RESREF = "id_haratminion";

// Waypoint tag constants.
const string RETREAT_WP_TAG = "ID1_STATIC_WP_RETREAT";
const string HARAT_WP_TAG = "ID1_STATIC_WP_HARAT";
const string MINION_WP_TAG = "ID1_STATIC_WP_MINION";

// Trigger tag constants.
const string CHAIN_TRIGGER_PRFX = "ID1_STATIC_CHAIN_TRIGGER_";

// Placeable tag constants.
const string CHAIN_SOURCE_PRFX = "ID1_STATIC_CHAIN_SOURCE_";
const string CHAIN_LEVER_TAG = "ID1_STATIC_CHAIN_LEVER";

// Variable name constants.
const string CHAIN_TRIGGER_OBJECT_NUM = "nObjects"; // Number of stored objects.
const string CHAIN_TRIGGER_OBJECT_PRFX = "oObject_"; // Objects stored.
const string HARAT_TELEPORT_PROHIBITED = "bTeleportProhibited";
const string LEVER_COOLDOWN = "bCooldown";

const string N_CHAIN_SOURCE_1 = "nSource1";
const string N_CHAIN_SOURCE_2 = "nSource2";
const string N_CHAIN_SOURCE_3 = "nSource3";
const string N_CHAIN_SOURCE_4 = "nSource4";
const string N_CHAIN_TRIGGER = "nTrigger";

const string GAURDED_LEVER = "oGarded";
const string GAURDIAN_CREATURE = "oGaurd";

// Duration of entrapment via the chains.
const float CHAIN_DURATION = 10.0;


// DEBUG
//void main(){}



/*------------------------------------------------------------------------------
    FUNCTION PROTOTYPES
------------------------------------------------------------------------------*/



// Name: Setup
//
// Defined in: inc_id1_harat
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

// Name: Action Activate Chain Trap
//
// Defined in: inc_id1_harat
//
// This function has one of Harat's minions, if any are available, activate
// the chain trap by pulling the activation lever. The function is designed to
// be an action assigned to the lever itself.
//
// Parameters:
// NONE
//
// Return:
// NONE
void ActionActivateChainTrap();

// Name: Action Teleport to Lever.
//
// Defined in: inc_id1_harat
//
// Teleports a minion back to their assigned lever. This function is an action
// designed to by executed by the minion.
//
// Parameters:
// NONE
//
// Return:
// NONE
void ActionTeleportToLever();

// Name: Create Harat
//
// Defined in: inc_id1_harat
//
// Creates Harat, God of Darkness.
//
// Parameters:
// NONE
//
// Return:
// An object reference to Harat.
object CreateHarat();

// Name: Create Minions
//
// Defined in: inc_id1_harat
//
// Creates Harat's minions along all the various minions waypoints.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreateMinions();

// Name: Create Minion
//
// Defined in: inc_id1_harat
//
// Creates a single Erinyes minion of Harat's. This function should be executed
// by the lever object which the minion will be gaurding/pulling.
//
// Parameters:
// lLoc - The location at which the minion whould be created.
// nLevel - The level the minion should be flagged as.
//
// Return:
// NONE
void CreateErinyesMinion(location lLoc, int nLevel);

// Name: Create Random minion.
//
// Defined in: inc_id1_harat
//
// Createa a single random minion, either a Red Slaad or an Imp.
//
// Parameters:
// lLoc - The location at which the minion whould be created.
// nLevel - The level the minion should be flagged as.
//
// Return:
// NONE
void CreateRandomMinion(location lLoc, int nLevel);

// Name: Apply Demon Shield
//
// Defined in: inc_id1_harat
//
// Applys a shield to Harat, making him invincible, along with an associated
// visual effect.
//
// Parameters:
// oHarat - An object reference to Harat, the creature the shield will be
//          applied to.
//
// Return:
// NONE
void ApplyDemonShield(object oHarat);

// Name: Remove Demon Shield
//
// Defined in: inc_id1_harat
//
// Removes the shield, as created in ApplyDemonShield, from Harat.
//
// Parameters:
// oHarat - An object reference to Harat, the creature the shield was
//          applied to.
//
// Return:
//
void RemoveDemonShield(object oHarat);

/*------------------------------------------------------------------------------
    FUNCTION IMPLEMENTATIONS
------------------------------------------------------------------------------*/



//::////////////////////////////////////////////////////////////////////////////
//:: Setup
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 28, 2005
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
    {        DebugMessage("  Area has never been activated before.");

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

    int bQuestCompleted = GetLocalInt(GetModule(), "bHaratQuestCompleted");
    int bHostile = GetLocalInt(GetModule(), "bHaratHostile");
    int bQuestActive = GetLocalInt(GetModule(), "bHaratQuestActive");
    int bSurrender = GetLocalInt(GetModule(), "bHaratSurrender");
    int bSurrender2 = GetLocalInt(GetModule(), "bHaratSurrender2");

    DebugMessage("  Harat Completed = " + IntToString(bQuestCompleted) + ", Hostile = " + IntToString(bHostile) + ", Active = " + IntToString(bQuestActive) + ", Surrender = " + IntToString(bSurrender) + ", Surrender2 = " + IntToString(bSurrender2));

    object oHarat;

    int bDead = GetLocalInt(oDungeon, "bBossDead");
    DebugMessage("bDead is " + IntToString(bDead));
    if (bDead == TRUE)
    {
        return;
    }

    // If the quest is not completed Harat should appear.
    if (!bQuestCompleted && !bDead)
    {
        oHarat = CreateHarat();
        if (bHostile == TRUE)
        {
            SetImmortal(oHarat, FALSE);
        }
    }

    // If Harat has surrendered ensure he is no longer hostile.
    if ((bSurrender || bSurrender2) && !bHostile)
    {
        // Change to the neutral faction stored on the Dungeon angel.
        ChangeFaction(GetObjectByTag(HARAT_TAG), GetObjectByTag("DungeonAngel"));

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
        CreateMinions();
        //LockArea();
    }

    // Generate some loot for the boss should the player choose to kill them.
    BossGenerateLoot(oHarat);
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateHarat
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 10, 2006
//::////////////////////////////////////////////////////////////////////////////
object CreateHarat()
{
    object oWaypoint = DB_GetWaypointByTag(HARAT_WP_TAG);
    object oDungeon = GetCurrentDungeon();
    location lLocation = GetLocation(oWaypoint);
    int nEncounter = GetLocalInt(oDungeon, "nBossLevel");
    object oHarat = DB_CreateObject(OBJECT_TYPE_CREATURE, HARAT_TAG, lLocation);

    SetLocalInt(oHarat, "nCreatureType", 3);
    SetLocalInt(oHarat, "nCR", nEncounter + 4);
    SetLocalInt(oHarat, "nBaseHD", 1);
    SetLocalInt(oHarat, "nClassStartHD", 15);
    SetLocalInt(oHarat, "nClass", 0);

    // Shield Harat.
    ApplyDemonShield(oHarat);

    return oHarat;
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateMinions
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On:Feb 09, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreateMinions()
{
    object oHarat = DB_GetWaypointByTag(HARAT_WP_TAG);
    object oDungeon = GetCurrentDungeon();

    // start at the first waypoint
    int nWaypoint = 1;
    int nEnc = GetLocalInt(oDungeon, "nBossLevel");
    object oWaypoint = DB_GetNearestObjectByTag(CHAIN_LEVER_TAG, oHarat, nWaypoint);
    location lLocation;

    nEnc -= 4;

    if (nEnc <= 0) nEnc = 1;

    // Loop through all the waypoints creating the erinyes minion creatures.
    while (GetIsObjectValid(oWaypoint))
    {
        lLocation = GetLocation(oWaypoint);

        // Assign the waypoint (currently a lever) to create the minion in order
        // to have the two associated for later.
        AssignCommand(oWaypoint, CreateErinyesMinion(lLocation, nEnc));

        nWaypoint++;
        oWaypoint = DB_GetNearestObjectByTag(CHAIN_LEVER_TAG, oHarat, nWaypoint);
    }

    // Loop through all the other waypoint creating random minions.
    nWaypoint = 1;
    oWaypoint = DB_GetNearestObjectByTag(MINION_WP_TAG, oHarat, nWaypoint);

    while (GetIsObjectValid(oWaypoint))
    {
        lLocation = GetLocation(oWaypoint);

        CreateRandomMinion(lLocation, nEnc);

        nWaypoint++;
        oWaypoint = DB_GetNearestObjectByTag(MINION_WP_TAG, oHarat, nWaypoint);
    }
}


//::////////////////////////////////////////////////////////////////////////////
//:: ActionActivateChainTrap
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 5, 2005
//::////////////////////////////////////////////////////////////////////////////
void ActionActivateChainTrap()
{
    // Possibly check to see if Harat is in the trap first.

    object oLever = OBJECT_SELF;
    object oMinion = GetLocalObject(oLever, GAURDIAN_CREATURE);

    // Check to make sure the lever has a valid minion available.
    if (!GetIsObjectValid(oMinion)) return;
    // Check to make sure the minion isn't dead.
    if (GetIsDead(oMinion)) return;

    // If the minion isn't close enough to pull the lever have them port in.
    if (GetDistanceBetween(oLever, oMinion) > 1.0)
    {
        AssignCommand(oMinion, ActionTeleportToLever());
    }

    // Have the minion pull the lever after giving it time to jump.
    DelayCommand(0.5, AssignCommand(oMinion,
        DoPlaceableObjectAction(oLever, PLACEABLE_ACTION_USE)));
}

//::////////////////////////////////////////////////////////////////////////////
//:: ActionTeleportToLever
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 16, 2006
//::////////////////////////////////////////////////////////////////////////////
void ActionTeleportToLever()
{
    // Gather the objects involved.
    object oThis = OBJECT_SELF;
    object oLever = GetLocalObject(oThis, GAURDED_LEVER);

    // Establish locations.
    location lLoc1 = GetLocation(oThis);
    location lLoc2 = GetLocation(oLever);

    // Establish a visual to represent the teleport.
    effect eVFX = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);

    // Clear the action queue to avoid interruption.
    ClearAllActions(TRUE);

    // Apply the teleportation visual.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lLoc1);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lLoc2);

    // Jump to the lever.
    ActionJumpToObject(oLever);
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateErinyesMinion
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 10, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreateErinyesMinion(location lLoc, int nLevel)
{
    // Double check to stop the erinyes from spawning after harat has surrendered.
    if (GetLocalInt(GetModule(), "bHaratSurrender")) return;

    object oMinion = DB_CreateObject(OBJECT_TYPE_CREATURE, MINION_RESREF, lLoc, FALSE, MINION_TAG);

    // Set Level up information.
    SetLocalInt(oMinion, "nCreatureType", 3);
    SetLocalInt(oMinion, "nCR", nLevel);
    SetLocalInt(oMinion, "nBaseHD", 1);
    SetLocalInt(oMinion, "nClassStartHD", 5);
    SetLocalInt(oMinion, "nClass", 10);
    SetLocalInt(oMinion, "bEquipArmor", TRUE);

    // Associate the minion with the lever that has been assigned to create it.
    SetLocalObject(OBJECT_SELF, GAURDIAN_CREATURE, oMinion);
    SetLocalObject(oMinion, GAURDED_LEVER, OBJECT_SELF);
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateRandomMinion
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 15, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreateRandomMinion(location lLoc, int nLevel)
{
    int nRand = Random(100);

    string sResref;

    // Randomly establish a resref.
    if (nRand > 30) sResref = "id_imp";
    else sResref = "id_slaadred";

    object oMinion = DB_CreateObject(OBJECT_TYPE_CREATURE, sResref, lLoc, FALSE, MINION_TAG);

    // Set level up information.
    SetLocalInt(oMinion, "nCreatureType", 3);
    SetLocalInt(oMinion, "nCR", nLevel);
    SetLocalInt(oMinion, "nBaseHD", 1);
    SetLocalInt(oMinion, "nClass", -1);
}

//::////////////////////////////////////////////////////////////////////////////
//:: ApplyDemonShield
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 16, 2006
//::////////////////////////////////////////////////////////////////////////////
void ApplyDemonShield(object oHarat)
{
    // Establish a linked effect for easy removal of the visual effect.
    effect eVFX = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eRes = EffectSpellResistanceIncrease(100);
    effect eLink = EffectLinkEffects(eVFX, eRes);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oHarat);

    // The actual shield is the plot flag.
    SetPlotFlag(oHarat, TRUE);
}

//::////////////////////////////////////////////////////////////////////////////
//:: RemoveDemonShield
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 16, 2006
//::////////////////////////////////////////////////////////////////////////////
void RemoveDemonShield(object oHarat)
{
    // Remove the shield visual.
    RemoveAllEffects(oHarat);

    // Apply a brief visual to Harat to indicate the barrier receding.
    effect eVFX = EffectVisualEffect(VFX_FNF_PWSTUN);

    // Remove the actual barrier.
    SetPlotFlag(oHarat, FALSE);
}
