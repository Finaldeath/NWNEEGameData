//::////////////////////////////////////////////////////////////////////////////
//:: inc_id1_halaster
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Include file for the battle with Halaster. Contains functions and constants
    used in the fight.
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
const string HALASTER_WP = "ID1_STATIC_WP_HALASTER";
const string PORTAL_WP_PRFX = "ID1_STATIC_WP_PORTAL_";

// Placeable blueprint constants.
const string PORTAL_RESREF = "id1_halasterport";

// Placeable tag constants.
const string PORTAL_PRFX = "ID1_PORTAL_";

// Variable name constants.
const string PORTAL_TYPE = "nPortalType";
const string SUMMON_COUNTER = "nSummonCounter";
const string SHIELD_OBJECT = "oShield";

// Variable value constants.
const int PORTAL_TYPE_PENGUIN   = 99;
const int PORTAL_TYPE_COW       = 98;
const int PORTAL_TYPE_GOBLIN    = 1;  // level 1
const int PORTAL_TYPE_ORC       = 2;  // level 3
const int PORTAL_TYPE_BUG       = 3;  // level 5
const int PORTAL_TYPE_SPRITE    = 4;  // level 6
const int PORTAL_TYPE_WEREBEAST = 5;  // level 8
const int PORTAL_TYPE_ELEMENTAL = 6;  // level 9
const int PORTAL_TYPE_GOLEM     = 7;  // level 11
const int PORTAL_TYPE_SLAAD     = 8;  // level 12
const int PORTAL_TYPE_DEMON     = 9;  // level 14
const int PORTAL_TYPE_DRAGON    = 10; // level 15

const int PORTAL_TYPES = 12;



/*------------------------------------------------------------------------------
    FUNCTION PROTOTYPES
------------------------------------------------------------------------------*/



// Name: Setup
//
// Defined in: inc_id1_halaster
//
// Setup function for the area in which the fight with Halaster takes place.
// Spawns in important creatures, placeables etc.
//
// Parameters:
// NONE
//
// Return:
// NONE
void Setup();

// Name: Create Halaster
//
// Defined in: inc_id1_halaster
//
// Creates Halaster.
//
// Parameters:
// NONE
//
// Return:
// An object reference to Halaster.
object CreateHalaster();

// Name: Action Instant Buff
//
// Defined in: inc_id1_halaster
//
// Instantly buffs up the caster with numerous protection spells based on level.
// This does not effect the action subject's spells per day and does not require
// them to actually know any spells.
//
// Parameters:
// NONE
//
// Return:
// NONE
void ActionInstantBuff();

// Name: Create Portals
//
// Defined in: inc_id1_halaster
//
// Iterates through all the portal waypoints in the area creating portals on
// them using the CreatePortal function.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreatePortals();

// Name: Create Portal
//
// Defined in: inc_id1_halaster
//
// Creates a single portal, applies a shield and visual effect and generates
// a summon type for the portal.
//
// Parameters:
// nLevel - The level of the players determined using GetEncounterLevel. Used
//          in generating the creature that the portal will summon.
// nPortal - The portal number. Used in creating the portal's tag so that each
//           portal can be easily tracked.
// lLoc - The location at which the portal will be created.
//
// Return:
// NONE
void CreatePortal(int nLevel, int nPortal, location lLoc);

// Name: Shield Portal
//
// Defined in: inc_id1_halaster
//
// Sets a plot flag and applies a shield visual effect, linked to a spell
// resistance effect for easy removal, to oPortal.
//
// Parameters:
// oPortal - The portal to be shielded.
//
// Return:
// NONE
void ShieldPortal(object oPortal);

// Name: RemoveShield
//
// Defined in: inc_id1_halaster
//
// Removes the plot flag and shield visual effect from oPortal.
//
// Parameters:
// oPortal - The portal having its shield removed.
//
// Return:
// NONE
void RemoveShield(object oPortal);

// Name: Summon Monster
//
// Defined in: inc_id1_halaster
//
// Intended to be assigned to a portal in halaster's area. This function will
// have the portal summon a monster based on local variables and drop it's
// shield for a limited amount of time.
//
// Parameters:
// NONE
//
// Return:
// NONE
void SummonMonster();

// Name: Get Monster Level
//
// Defined in: inc_id1_halaster
//
// Establishes a the level a summoned monster should be based on Halaster's
// Hit Dics.
//
// Parameters:
// NONE
//
// Return:
// The level summoned monsters should be.
int GetMonsterLevel();

// Name: Get Goblin Resref
//
// Defined in: inc_id1_halaster
//
// Establishes a resref for a goblin creature based on the nLevel parameter.
//
// Parameters:
// nLevel - The level of monster sought.
//
// Return:
// A blueprint resref indicating the target creature.
string GetGoblinResref(int nLevel);

// Name: Get Orc Resref
//
// Defined in: inc_id1_halaster
//
// Establishes a resref for a Orc creature based on the nLevel parameter.
//
// Parameters:
// nLevel - The level of monster sought.
//
// Return:
// A blueprint resref indicating the target creature.
string GetOrcResref(int nLevel);

// Name: Get Bug Resref
//
// Defined in: inc_id1_halaster
//
// Establishes a resref for a Bug creature based on the nLevel parameter.
//
// Parameters:
// nLevel - The level of monster sought.
//
// Return:
// A blueprint resref indicating the target creature.
string GetBugResref(int nLevel);

// Name: Get Sprite Resref
//
// Defined in: inc_id1_halaster
//
// Establishes a resref for a sprite creature based on the nLevel parameter.
//
// Parameters:
// nLevel - The level of monster sought.
//
// Return:
// A blueprint resref indicating the target creature.
string GetSpriteResref(int nLevel);

// Name: Get Werebeast Resref
//
// Defined in: inc_id1_halaster
//
// Establishes a resref for a werebeast creature based on the nLevel parameter.
//
// Parameters:
// nLevel - The level of monster sought.
//
// Return:
// A blueprint resref indicating the target creature.
string GetWerebeastResref(int nLevel);

// Name: Get Elemental Resref
//
// Defined in: inc_id1_halaster
//
// Establishes a resref for a elemental creature based on the nLevel parameter.
//
// Parameters:
// nLevel - The level of monster sought.
//
// Return:
// A blueprint resref indicating the target creature.
string GetElementalResref(int nLevel);

// Name: Get Golem Resref
//
// Defined in: inc_id1_halaster
//
// Establishes a resref for a golem creature based on the nLevel parameter.
//
// Parameters:
// nLevel - The level of monster sought.
//
// Return:
// A blueprint resref indicating the target creature.
string GetGolemResref(int nLevel);

// Name: Get Slaad Resref
//
// Defined in: inc_id1_halaster
//
// Establishes a resref for a slaad creature based on the nLevel parameter.
//
// Parameters:
// nLevel - The level of monster sought.
//
// Return:
// A blueprint resref indicating the target creature.
string GetSlaadResref(int nLevel);

// Name: Get Demon Resref
//
// Defined in: inc_id1_halaster
//
// Establishes a resref for a Demon creature based on the nLevel parameter.
//
// Parameters:
// nLevel - The level of monster sought.
//
// Return:
// A blueprint resref indicating the target creature.
string GetDemonResref(int nLevel);

// Name: Get Dragon Resref
//
// Defined in: inc_id1_halaster
//
// Establishes a resref for a dragon creature based on the nLevel parameter.
//
// Parameters:
// nLevel - The level of monster sought.
//
// Return:
// A blueprint resref indicating the target creature.
string GetDragonResref(int nLevel);

// Name: Get Cow Resref
//
// Defined in: inc_id1_halaster
//
// Establishes a resref for a cow creature based on the nLevel parameter.
//
// Parameters:
// nLevel - The level of monster sought.
//
// Return:
// A blueprint resref indicating the target creature.
string GetCowResref(int nLevel);

// Name: Get Penguin Resref
//
// Defined in: inc_id1_halaster
//
// Establishes a resref for a penguin creature based on the nLevel parameter.
//
// Parameters:
// nLevel - The level of monster sought.
//
// Return:
// A blueprint resref indicating the target creature.
string GetPenguinResref(int nLevel);

// Name: Get Direction
//
// Defined in: inc_id1_cutscene
//
// Gets the direction oTarget is in regards to oSource represented as a float
// where 0.0 = East, 90.0 = North, 180.0 = West and 270.0 = South.
//
// Parameters:
// oSource - The source object, from which the direction is being established.
// oTarget - The target object, to which the direction is being establised.
//
// Return:
// The direction from oSource to oTarget.
float GetDirection(object oSource, object oTarget);



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

    int bQuestCompleted = GetLocalInt(GetModule(), "bHalasterQuestCompleted");
    int bHostile = GetLocalInt(GetModule(), "bHalasterHostile");
    int bQuestActive = GetLocalInt(GetModule(), "bHalasterQuestActive");
    int bSurrender = GetLocalInt(GetModule(), "bHalasterSurrender");
    int bSurrender2 = GetLocalInt(GetModule(), "bHalasterSurrender2");

    DebugMessage("  Halaster Completed = " + IntToString(bQuestCompleted) + ", Hostile = " + IntToString(bHostile) + ", Active = " + IntToString(bQuestActive) + ", Surrender = " + IntToString(bSurrender) + ", Surrender2 = " + IntToString(bSurrender2));

    object oHalaster;

    int bDead = GetLocalInt(oDungeon, "bBossDead");
    DebugMessage("bDead is " + IntToString(bDead));
    if (bDead == TRUE)
    {
        return;
    }

    // If Halaster's quest has not been completed he should spawn.
    if (!bQuestCompleted && !bDead)
    {
        oHalaster = CreateHalaster();
        CreatePortals();
        //LockArea();

        if (bHostile == TRUE)
        {
            SetImmortal(oHalaster, FALSE);
        }

        AssignCommand(oHalaster, ActionInstantBuff());
        SetLocalInt(oHalaster, SUMMON_COUNTER, 3);
    }
    else
    {
        // enable and spawn the boss lair teleporter
        object oTeleporter = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER", GetFirstObjectInArea(OBJECT_SELF));
        SetMapPinEnabled(oTeleporter, TRUE);
        CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oTeleporter));
        DebugMessage("Teleporter is in area " + GetTag(GetArea(oTeleporter)));
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateHalaster
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On:Feb 14, 2006
//::////////////////////////////////////////////////////////////////////////////
object CreateHalaster()
{
    object oWaypoint = DB_GetWaypointByTag(HALASTER_WP);
    location lLocation = GetLocation(oWaypoint);

    object oDungeon = GetCurrentDungeon();
    int nEncounter = GetLocalInt(oDungeon, "nBossLevel");
    object oHalaster = DB_CreateObject(OBJECT_TYPE_CREATURE, HALASTER_TAG, lLocation);

    SetLocalInt(oHalaster, "nCreatureType", 3);
    SetLocalInt(oHalaster, "nCR", nEncounter + 4);
    SetLocalInt(oHalaster, "nBaseHD", 1);
    SetLocalInt(oHalaster, "nClass", -1);

    return oHalaster;
}

//::////////////////////////////////////////////////////////////////////////////
//:: ActionInstantBuff
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 14, 2006
//::////////////////////////////////////////////////////////////////////////////
void ActionInstantBuff()
{
    object oThis = OBJECT_SELF;
    int nLevel = GetHitDice(oThis);

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
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreatePortals
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 14, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreatePortals()
{
    object oDungeon = GetCurrentDungeon();
    int nLevel = GetLocalInt(oDungeon, "nBossLevel");
    object oHalaster = DB_GetObjectByTag(HALASTER_TAG);

    object oWP;
    location lLoc;
    int i;

    // Cycle all the 8 waypoints and create portals on them.
    for (i = 1; i < 9; ++i)
    {
        oWP = DB_GetObjectByTag(PORTAL_WP_PRFX + IntToString(i));
        lLoc = GetLocation(oWP);

        CreatePortal(nLevel, i, lLoc);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreatePortal
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 14, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreatePortal(int nLevel, int nPortal, location lLoc)
{
    // Create the portal object.
    object oPortal = DB_CreateObject(OBJECT_TYPE_PLACEABLE, PORTAL_RESREF, lLoc, FALSE, PORTAL_PRFX + IntToString(nPortal));

    // Establish and apply shield and associated visual effects.
    DelayCommand(2.0, ShieldPortal(oPortal));

    // Generate a summon type and set local variables to indicate.

    // Small chance of a cow or penguin portal.
    if (Random(100) < 10) // DEBUG EDIT
    {
        SetLocalInt(oPortal, PORTAL_TYPE, PORTAL_TYPE_PENGUIN);
    }
    else if (Random(100) < 10)
    {
        SetLocalInt(oPortal, PORTAL_TYPE, PORTAL_TYPE_COW);
    }
    else // Generate a monster type based on level.
    {
        int nType;

        if (nLevel < 7) nType = Random(2) + 1; // 1,2
        else if (nLevel < 9) nType = Random(3) + 2; // 2,3,4
        else if (nLevel < 12) nType = Random(4) + 3; // 3,4,5,6
        else if (nLevel < 16) nType = Random(5) + 4; // 4,5,6,7,8
        else if (nLevel < 19) nType = Random(6) + 4; // 4,5,6,7,8,9
        else nType = Random(7) + 4; // 4,5,6,7,8,9,10

        SetLocalInt(oPortal, PORTAL_TYPE, nType);

        // DEBUG
        DebugMessage("inc_id1_halaster::CreatePortal()");
        DebugMessage("^nLevel = " + IntToString(nLevel));
        DebugMessage("^nType = " + IntToString(nType));
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: ShieldPortal
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 14, 2006
//::////////////////////////////////////////////////////////////////////////////
void ShieldPortal(object oPortal)
{
    // Establish and apply shield and associated visual effects.
    effect eVFX = EffectVisualEffect(VFX_DUR_GLOBE_INVULNERABILITY);

    // Create a shield object to hold the visual effects.
    location lLoc = GetLocation(oPortal);
    object oShield = DB_CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLoc);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, oShield);
    SetLocalObject(oPortal, SHIELD_OBJECT, oShield);

    // Make the portal invulnerable.
    SetPlotFlag(oPortal, TRUE);
}

//::////////////////////////////////////////////////////////////////////////////
//:: RemoveShield
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 14, 2006
//::////////////////////////////////////////////////////////////////////////////
void RemoveShield(object oPortal)
{
    object oShield = GetLocalObject(oPortal, SHIELD_OBJECT);

    DestroyObject(oShield);

    SetPlotFlag(oPortal, FALSE);
}

//::////////////////////////////////////////////////////////////////////////////
//:: SummonMonster
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 15, 2006
//::////////////////////////////////////////////////////////////////////////////
void SummonMonster()
{
    // Don't summon if Halaster has surrendered.
    if (GetLocalInt(GetModule(), "bHalasterSurrender")) return;

    object oThis = OBJECT_SELF;

    // Based on the portal type and level establish a resref and number to summon.
    int nLevel = GetMonsterLevel();
    int nPortalType = GetLocalInt(oThis, PORTAL_TYPE);

    string sResref;
    int nSummon;

    switch (nPortalType)
    {
        case PORTAL_TYPE_GOBLIN:
        {
            sResref = GetGoblinResref(nLevel);
            nSummon = Random(5) + 1;
            break;
        }
        case PORTAL_TYPE_ORC:
        {
            sResref = GetOrcResref(nLevel);
            nSummon = Random(3) + 1;
            break;
        }
        case PORTAL_TYPE_BUG:
        {
            sResref = GetBugResref(nLevel);
            nSummon = Random(3) + 1;
            break;
        }
        case PORTAL_TYPE_SPRITE:
        {
            sResref = GetSpriteResref(nLevel);
            nSummon = Random(2) + 1;
            break;
        }
        case PORTAL_TYPE_WEREBEAST:
        {
            sResref = GetWerebeastResref(nLevel);
            nSummon = Random(2) + 1;
            break;
        }
        case PORTAL_TYPE_ELEMENTAL:
        {
            sResref = GetElementalResref(nLevel);
            nSummon = Random(2) + 1;
            break;
        }
        case PORTAL_TYPE_GOLEM:
        {
            sResref = GetGolemResref(nLevel);
            nSummon = 1;
            break;
        }
        case PORTAL_TYPE_SLAAD:
        {
            sResref = GetSlaadResref(nLevel);
            nSummon = 1;
            break;
        }
        case PORTAL_TYPE_DEMON:
        {
            sResref = GetDemonResref(nLevel);
            nSummon = 1;
            break;
        }
        case PORTAL_TYPE_DRAGON:
        {
            sResref = GetDragonResref(nLevel);
            nSummon = 1;
            break;
        }
        case PORTAL_TYPE_COW:
        {
            sResref = GetCowResref(nLevel);
            nSummon = Random(3) + 1;
            break;
        }
        case PORTAL_TYPE_PENGUIN:
        {
            sResref = GetPenguinResref(nLevel);
            nSummon = 1;
            break;
        }
        default:
        {
            DebugMessage("inc_id1_halaster::SummonMonster() - Unrecognized portal type.");
        }
    }

    // Create the creature(s) along with a summon visual and set level up stats.
    effect eVFX = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    location lLoc = GetLocation(oThis);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lLoc);

    object oMoveTo = DB_GetObjectByTag(HALASTER_TAG);
    object oSummon;
    int i;

    for (i = 1; i <= nSummon; ++i)
    {
        oSummon = DB_CreateObject(OBJECT_TYPE_CREATURE, sResref, lLoc, FALSE, MINION_TAG);
        AssignCommand(oSummon, ActionMoveToObject(oMoveTo, TRUE));

        SetLocalInt(oSummon, "nCreatureType", 3);
        SetLocalInt(oSummon, "nCR", nLevel);
        SetLocalInt(oSummon, "nBaseHD", 1);
        SetLocalInt(oSummon, "nClass", -1);
    }

    // In order to avoid shields popping up right after a summon clear out
    // delayed SheildPortal commands.
    ClearAllActions(TRUE);

    // Remove the portal's shield.
    DelayCommand(0.5, RemoveShield(oThis));

    // A short time later restore the shield.
    DelayCommand(40.0, ShieldPortal(oThis));
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetMonsterLevel
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 15, 2006
//::////////////////////////////////////////////////////////////////////////////
int GetMonsterLevel()
{
    object oHalaster = DB_GetObjectByTag(HALASTER_TAG);

    int nLevel;

    if (!GetIsObjectValid(oHalaster)) // in case of an error default to level 5.
    {
        nLevel = 5;
    }
    else
    {
        nLevel = FloatToInt(GetChallengeRating(oHalaster));

        nLevel -= 6;

        if (nLevel < 0) nLevel = 1;
    }

    return nLevel;
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetGoblinResref
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On:Feb 15, 2006
//::////////////////////////////////////////////////////////////////////////////
string GetGoblinResref(int nLevel)
{
    int nRand = Random(100) + nLevel;

    string sResref;

    if (nRand > 70) sResref = "id_bugbear012";
    else if (nRand > 40) sResref = "id_hobgoblin004";
    else sResref = "id_goblin008";

    return sResref;
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetOrcResref
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 15, 2006
//::////////////////////////////////////////////////////////////////////////////
string GetOrcResref(int nLevel)
{
    int nRand = Random(100) + nLevel;

    string sResref;

    if (nRand > 80) sResref = "id_ogremage";
    else if (nRand > 60) sResref = "id_ogre";
    else sResref = "id_orc000";

    return sResref;
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetBugResref
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 15, 2006
//::////////////////////////////////////////////////////////////////////////////
string GetBugResref(int nLevel)
{
    int nRand = Random(100) + nLevel;

    string sResref;

    if (nRand > 86) sResref = "id_spidswrd";
    else if (nRand > 71) sResref = "id_spidgiant";
    else if (nRand > 57) sResref = "id_spiddire";
    else if (nRand > 43) sResref = "id_btlstink";
    else if (nRand > 29) sResref = "id_btlstag";
    else if (nRand > 15) sResref = "id_btlfire";
    else sResref = "id_btlbomb";

    return sResref;
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetSpriteResref
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 15, 2006
//::////////////////////////////////////////////////////////////////////////////
string GetSpriteResref(int nLevel)
{
    int nRand = Random(100);

    string sResref;

    if (nRand > 50) sResref = "id1_hlstrsprt1";
    else sResref = "id1_hlstrsprt2";

    return sResref;
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetWerebeastResref
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 15, 2006
//::////////////////////////////////////////////////////////////////////////////
string GetWerebeastResref(int nLevel)
{
    int nRand = Random(100);

    string sResref;

    if (nRand > 60) sResref = "id_werewolf";
    else if (nRand > 30) sResref = "id_wererat";
    else sResref = "id_werecat";

    return sResref;
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetElementalResref
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 15, 2006
//::////////////////////////////////////////////////////////////////////////////
string GetElementalResref(int nLevel)
{
    int nRand = Random(100);

    string sResref;

    if (nRand > 80) sResref = "id_fire";
    else if (nRand > 60) sResref = "id_earth";
    else if (nRand > 40) sResref = "id_air";
    else sResref = "id_water";

    return sResref;
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetGolemResref
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: feb 15, 2006
//::////////////////////////////////////////////////////////////////////////////
string GetGolemResref(int nLevel)
{
    int nRand = Random(100) + nLevel;

    string sResref;

    if (nRand > 95) sResref = "id_goladam";
    else if (nRand > 85) sResref = "id_golmith";
    else if (nRand > 70) sResref = "id_goliron";
    else if (nRand > 60) sResref = "id_golbone";
    else if (nRand > 30) sResref = "id_golstones";
    else if (nRand > 20) sResref = "id_golflesh";
    else sResref = "id_golclay";

    return sResref;
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetSlaadResref
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On:Feb 15, 2006
//::////////////////////////////////////////////////////////////////////////////
string GetSlaadResref(int nLevel)
{
    int nRand = Random(100) + nLevel;

    string sResref;

    if (nRand > 90) sResref = "id_slaaddeath";
    else if (nRand > 80) sResref = "id_slaadblack";
    else if (nRand > 70) sResref = "id_slaadbl";
    else if (nRand > 60) sResref = "id_slaadgray";
    else if (nRand > 50) sResref = "id_slaadgrn";
    else if (nRand > 40) sResref = "id_slaadgrn";
    else sResref = "id_slaadwhite";

    return sResref;
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetDemonResref
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 15, 2006
//::////////////////////////////////////////////////////////////////////////////
string GetDemonResref(int nLevel)
{
    int nRand = Random(100) + nLevel;

    string sResref;

    if (nRand > 80) sResref = "id_demon";
    else if (nRand > 70) sResref = "id1_cltavngr";
    else sResref = "id_succubus";

    return sResref;
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetDragonResref
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 15, 2006
//::////////////////////////////////////////////////////////////////////////////
string GetDragonResref(int nLevel)
{
    int nRand = Random(100) + nLevel;

    string sResref;

    if (nRand > 80) sResref = "id_adtdrgred";
    else if (nRand > 60) sResref = "id_adtdrgblue";
    else if (nRand > 40) sResref = "id_adtdrggreen";
    else if (nRand > 20) sResref = "id_adtdrgblack";
    else sResref = "id_adtdrgwhite";

    return sResref;
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetCowResref
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 15, 2006
//::////////////////////////////////////////////////////////////////////////////
string GetCowResref(int nLevel)
{
    int nRand = Random(100);

    string sResref;

    if (nRand > 50) sResref = "id1_hlstrcow2";
    else sResref = "id1_hlstrcow1";

    return sResref;
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetPenguinResref
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 15, 2006
//::////////////////////////////////////////////////////////////////////////////
string GetPenguinResref(int nLevel)
{
    int nRand = Random(100);

    string sResref;

    if (nRand > 50) sResref = "id1_hlstrpngn";
    else if (nRand > 40) sResref = "id1_hlstrpngn3";
    else sResref = "id1_hlstrpngn2";

    return sResref;
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetDirection
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Jan 26, 2005
//::////////////////////////////////////////////////////////////////////////////
float GetDirection(object oSource, object oTarget)
{
    // v2- v1 angled from the origin should give the direction from v1 to v2.
    vector vSource = GetPosition(oSource);
    vector vTarget = GetPosition(oTarget);
    vector vDirection = vTarget - vSource; // The vector between v1 and v2.

    return VectorToAngle(vDirection); // establish an angle from (0,0,0).
}

//void main(){}

