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
#include "x0_i0_talent"


// DEBUG
// void main(){}


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

// Name: Create Masterius
//
// Defined in: inc_id1_masteriu
//
// Creates Masterius, the boss creature.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreateMasterius();

// Name: Create Minions
//
// Defined in: inc_id1_masterius
//
// Creates masterius' spectre minons.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreateMinions();

// Name: Prepare For Battle
//
// Defined in: inc_id1_masteriu
//
// Prepares Masterius for a battle. Buffs him up and ensures that he has full
// health and spell allotment. This function should be ran by Masterius as an
// action.
//
// Parameters:
// NONE
//
// Return:
// NONE
void PrepForBattle();



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

    int bQuestCompleted = GetLocalInt(GetModule(), "bMasteriusQuestCompleted");
    int bHostile = GetLocalInt(GetModule(), "bMasteriusHostile");
    int bQuestActive = GetLocalInt(GetModule(), "bMasteriusQuestActive");
    int bSurrender = GetLocalInt(GetModule(), "bMasteriusSurrender");
    int bSurrender2 = GetLocalInt(GetModule(), "bMasteriusSurrender2");

    DebugMessage("  Masterius Completed = " + IntToString(bQuestCompleted) + ", Hostile = " + IntToString(bHostile) + ", Active = " + IntToString(bQuestActive) + ", Surrender = " + IntToString(bSurrender) + ", Surrender2 = " + IntToString(bSurrender2));

    int bDead = GetLocalInt(oDungeon, "bBossDead");
    DebugMessage("bDead is " + IntToString(bDead));
    if (bDead == TRUE)
    {
        return;
    }

    // If Masterius' quest has not been completed he should appear.
    if (!bQuestCompleted && !bDead)
    {
        CreateMasterius();
    }

    object oMasterius = DB_GetObjectByTag(MASTERIUS_TAG);
    if (bHostile == TRUE)
    {
        SetImmortal(oMasterius, FALSE);
    }

    // If Masterius has previous surrednered he should not be hostile.
    if ((bSurrender || bSurrender2) && !bHostile)
    {
        // Change to the nuetral faction stored on the dungeon angel.
        if (GetIsObjectValid(oMasterius))
        {
            ChangeFaction(oMasterius, GetObjectByTag("DungeonAngel"));
        }

        // If the quest is completed or still active.
        if (bQuestCompleted || bQuestActive)
        {
            // Enable map pin and spawn the boss lair teleporter.
            object oTeleporter = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER", GetFirstObjectInArea(OBJECT_SELF));

            SetMapPinEnabled(oTeleporter, TRUE);

            DB_CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oTeleporter));

            DebugMessage("Teleporter is in area " + GetTag(GetArea(oTeleporter)));
        }
    }
    else // Set up the fight.
    {
        CreateMinions();
        AssignCommand(oMasterius, PrepForBattle());
//        LockArea();
    }

    // Generate some loot for the boss should the player choose to kill them.
    BossGenerateLoot(oMasterius);
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateMasterius
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 08, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreateMasterius()
{
    // Create the creature at the waypoint.
    object oWaypoint = DB_GetWaypointByTag(MASTERIUS_WP_TAG);
    object oDungeon = GetCurrentDungeon();
    location lLocation = GetLocation(oWaypoint);

    int nEnc = GetLocalInt(oDungeon, "nBossLevel");

    object oMasterius = DB_CreateObject(OBJECT_TYPE_CREATURE, MASTERIUS_TAG, lLocation);

    // Level up information.
    SetLocalInt(oMasterius, "nCreatureType", 3);
    SetLocalInt(oMasterius, "nCR", nEnc + 5);
    SetLocalInt(oMasterius, "nBaseHD", 1);
    SetLocalInt(oMasterius, "nClassStartHD", 5);
    SetLocalInt(oMasterius, "nClass", 10);
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateMinions
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 08, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreateMinions()
{
    // Use masterius as a starting point.
    int nNth = 1;
    object oMasterius = DB_GetObjectByTag(MASTERIUS_TAG);

    // If masterius cannot be retrieved jump out.
    if (!GetIsObjectValid(oMasterius)) return;

    // Determine target level.
    object oDungeon = GetCurrentDungeon();
    int nCR = GetLocalInt(oDungeon, "nBossLevel") - 4;

    object oWaypoint = DB_GetNearestObjectByTag(MINION_WP_TAG, oMasterius, nNth);
    object oMinion;
    location lLoc;

    // Iterate all the nearby waypoints creating minions.
    while (GetIsObjectValid(oWaypoint))
    {
        lLoc = GetLocation(oWaypoint);
        oMinion = DB_CreateObject(OBJECT_TYPE_CREATURE, "id_spectre", lLoc, FALSE, MINION_TAG);

        // Level up information.
        SetLocalInt(oMinion, "nCreatureType", 3);
        SetLocalInt(oMinion, "nCR", nCR);
        SetLocalInt(oMinion, "nBaseHD", 1);
        SetLocalInt(oMinion, "nClass", -1);

        nNth++;

        oWaypoint = DB_GetNearestObjectByTag(MINION_WP_TAG, oMasterius, nNth);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: PrepForBattle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 08, 2006
//::////////////////////////////////////////////////////////////////////////////
void PrepForBattle()
{
    object oThis = OBJECT_SELF;
    int nLevel = GetHitDice(oThis);

    DebugMessage("inc_id1_masteriu::PrepForBattle() - nLevel = " + IntToString(nLevel));

    // Free up the action queue.
    ClearAllActions();

    // Buff Armor class.
    if (nLevel > 24)
    {
        ActionCastSpellAtObject(SPELL_EPIC_MAGE_ARMOR, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
    else
    {
        ActionCastSpellAtObject(SPELL_MAGE_ARMOR, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }

    // Buff Damage reduction.
    if (nLevel > 15)
    {
        ActionCastSpellAtObject(SPELL_PREMONITION, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
    else if (nLevel > 11)
    {
        ActionCastSpellAtObject(SPELL_GREATER_STONESKIN, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
    else if (nLevel > 10)
    {
        ActionCastSpellAtObject(SPELL_ETHEREAL_VISAGE, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
    else if (nLevel > 7)
    {
        ActionCastSpellAtObject(SPELL_STONESKIN, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
    else if (nLevel > 3)
    {
        ActionCastSpellAtObject(SPELL_GHOSTLY_VISAGE, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }

    // Create a Damage Causing shield.
    if (nLevel > 6)
    {
        ActionCastSpellAtObject(SPELL_ELEMENTAL_SHIELD, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
    else if (nLevel > 4)
    {
        ActionCastSpellAtObject(SPELL_MESTILS_ACID_SHEATH, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
    else if (nLevel > 2)
    {
        ActionCastSpellAtObject(SPELL_DEATH_ARMOR, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }

    // Buff Spell absorbing.
    if (nLevel > 16)
    {
        ActionCastSpellAtObject(SPELL_GREATER_SPELL_MANTLE, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
    else if (nLevel > 14)
    {
        ActionCastSpellAtObject(SPELL_SPELL_MANTLE, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
    else if (nLevel > 12)
    {
        ActionCastSpellAtObject(SPELL_PROTECTION_FROM_SPELLS, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
    else if (nLevel > 10)
    {
        ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
    else if (nLevel > 8)
    {
        ActionCastSpellAtObject(SPELL_LESSER_SPELL_MANTLE, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
    else if (nLevel > 6)
    {
        ActionCastSpellAtObject(SPELL_MINOR_GLOBE_OF_INVULNERABILITY, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
    else
    {
        ActionCastSpellAtObject(SPELL_SHIELD, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }

    // Mind protection spells
    if (nLevel > 14)
    {
        ActionCastSpellAtObject(SPELL_MIND_BLANK, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }
    else if (nLevel > 8)
    {
        ActionCastSpellAtObject(SPELL_LESSER_MIND_BLANK, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }

    // Other buffs
    if (nLevel > 12)
    {
        ActionCastSpellAtObject(SPELL_SHADOW_SHIELD, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }

    if (nLevel > 6)
    {
        ActionCastSpellAtObject(SPELL_HASTE, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }

    if (nLevel > 4)
    {
        ActionCastSpellAtObject(SPELL_DISPLACEMENT, oThis, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    }

    // Restore all hitpoints and spells after buff.
    //ForceRest(oThis);
}

// void main(){}

