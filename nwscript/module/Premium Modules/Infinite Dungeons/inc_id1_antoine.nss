//::////////////////////////////////////////////////////////////////////////////
//:: inc_id1_antoine
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Include file for the battle with Antoine. Contains functions and constants
    used universally throughout the fight.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep. 26, 2005
//::////////////////////////////////////////////////////////////////////////////



#include "inc_id1_boss"
#include "inc_id1_creature"
#include "x2_inc_itemprop"



// DEBUG
// void main() {}



/*------------------------------------------------------------------------------
    CONSTANTS
------------------------------------------------------------------------------*/



// Creature ResRef constants.
const string HUMAN_RESREF_01 = "id1_wereboar_01";
const string HUMAN_RESREF_02 = "id1_wereboar_02";
const string HUMAN_RESREF_03 = "id1_wereboar_03";
const string HUMAN_RESREF_04 = "id1_wereboar_04";
const string HUMAN_RESREF_05 = "id1_wereboar_05";
const string BOAR_RESREF = "id1_camoboar";

// Form tracking information.
const string CURRENT_FORM = "nForm";
const string SHAPESHIFT_COOLDOWN = "bSSCooldown";

const int N_FORM_HUMAN = 1;
const int N_FORM_ANIMAL = 2;
const int N_FORM_HYBRID = 3;

const string HUMAN_APPEARANCE_TYPE = "nHumanAppearanceType";
const string ANIMAL_APPEARANCE_TYPE = "nAnimalAppearanceType";
const string HYBRID_APPEARANCE_TYPE = "nHybridAppearanceType";

const string SKIN_RESREF = "id1_it_wereskin";

// Waypoint constants.
const string ANTOINE_WAYPOINT = "ID1_STATIC_WP_ANTOINE";
const string SHIFT_WAYPOINT = "ID1_STATIC_WP_SHIFT";
const string RETREAT_WAYPOINT = "ID1_STATIC_WP_RETREAT_";
const string MINION_WAYPOINT = "ID1_STATIC_WP_MINION_";
const string MINION_RESPAWN = "ID1_STATIC_WP_MINION_RESPAWN";

// State constants.
const string FLEEING_STATE = "ID1_STATE_FLEEING";
const string MINIONS_KILLED = "nMinionsKilled";



/*------------------------------------------------------------------------------
    FUNCTION PROTOTYPES
------------------------------------------------------------------------------*/



// Name: Setup
//
// Defined in: inc_id1_antoine
//
// Setup function for the fight scenario with Antoine. Establishes the initial
// state of the area and spawns in any placeable objects or creatures as
// required.
//
// Parameters:
// NONE
//
// Return:
// NONE
void Setup();

// Name: Evaluate On Damage
//
// Defined in: inc_id1_antoine
//
// Evaluates and reacts to an On Damage event for any of the were-boars when
// they are in hybrid or human form.
//
// Parameters:
// oCreature - The creature who will be changing shape.
//
// Return:
// NONE
void EvaluateOnDamage(object oCreature = OBJECT_SELF);

// Name: Change Form
//
// Defined in: inc_id1_antoine
//
// This function changes any of the were-boar creatures forms.
//
// Parameters:
// oCreature - The creature who is going to change forms.
// nFormToChangeTo - The form to which the creature will be changing.
//
// Return:
// NONE
void ChangeForm(object oCreature, int nFormToChangeTo);

// Name: Create Were-Boar
//
// Defined in: inc_id1_antoine
//
// Creates a were-boar by creating a creature for each of the were-boars' shapes
// and associating the shapes with each other.
//
// Parameters:
// oWaypoint - The waypoint at which the were-boar should be created.
//
// Return:
// NONE
void CreateWereBoar(object oWaypoint);

// Name: Create Boar
//
// Defined in: inc_id1_antoine
//
// Creates a boar in the area of the fight to obfuscate Antoine and the other
// wereboars while they're in boar form regenerating.
//
// Parameters:
// oWaypoint - The waypoint at which the boar should be created.
//
// Return:
// NONE
void CreateBoar(object oWaypoint);

// Name: Create Antoine
//
// Defined in: inc_id1_antoine
//
// Creates Lord Antoine Baccha, the boss.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreateAntoine();

// Name: Create Minions
//
// Defined in: inc_id1_antoine
//
// Creates Antoine's coterie of were-minions.
//
// Parameters:
// nLevel -
//
// Return:
// NONE
void CreateMinions(int nLevel);

// Name: Create Boar Minions
//
// Defined in: inc_id1_antoine
//
// Creates the dire boar minions throughout the level.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreateBoarMinions();



/*------------------------------------------------------------------------------
    FUNCTION IMPLEMENTATIONS
------------------------------------------------------------------------------*/



//::////////////////////////////////////////////////////////////////////////////
//:: Setup
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 26, 2005
//::////////////////////////////////////////////////////////////////////////////
void Setup()
{
    int nLevel;
    object oWaypoint;

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
    else // Boss level already recorded.
    {
        DebugMessage("  Area has been activated before.");

        nLevel = GetLocalInt(oDungeon, "nBossLevel");
    }

    DebugMessage("  Boss level is " + IntToString(nLevel));

    int bQuestCompleted = GetLocalInt(GetModule(), "bBacchaQuestCompleted");
    int bHostile = GetLocalInt(GetModule(), "bBacchaHostile");
    int bQuestActive = GetLocalInt(GetModule(), "bBacchaQuestActive");
    int bSurrender = GetLocalInt(GetModule(), "bBacchaSurrender");
    int bSurrender2 = GetLocalInt(GetModule(), "bBacchaSurrender2");

    DebugMessage("  Baccha Completed = " + IntToString(bQuestCompleted) + ", Hostile = " + IntToString(bHostile) + ", Active = " + IntToString(bQuestActive) + ", Surrender = " + IntToString(bSurrender) + ", Surrender2 = " + IntToString(bSurrender2));

    // April 7, non-plot dungeons can have dead bosses.
    int bDead = GetLocalInt(oDungeon, "bBossDead");
    DebugMessage("bDead is " + IntToString(bDead));
    if (bDead == TRUE)
    {
/*        if (GetLocalInt(GetModule(), "bBossTeleporter") == TRUE)
        {
            // Enable map pin and spawn the boss lair teleporter.
            object oTeleporter = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER", GetFirstObjectInArea(OBJECT_SELF));

            SetMapPinEnabled(oTeleporter, TRUE);

            DB_CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oTeleporter));

            DebugMessage("Teleporter is in area " + GetTag(GetArea(oTeleporter)));
        }*/

        return;
    }

    // If Antoine's quest has not been completed he should appear.
    if (!bQuestCompleted && !bDead)
    {
        CreateAntoine();
    }

    object oAntoine = GetObjectByTag(ANTOINE_TAG);
    if (bHostile == TRUE)
    {
        SetImmortal(oAntoine, FALSE);
    }

    // If Antoine has previously surrendered he should not be hostile.
    if ((bSurrender || bSurrender2) && !bHostile)
    {
        // Change to neutral faction stored on Dungeon Angel.
        if (GetIsObjectValid(oAntoine))
        {
            ChangeFaction(oAntoine, GetObjectByTag("DungeonAngel"));
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
        // were creature minions
        CreateMinions(nLevel);

        // boar minions
        CreateBoarMinions();

        //LockArea();
    }

    // Generate some loot for the boss should the player choose to kill them.
    BossGenerateLoot(oAntoine);
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateAntoine
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 06, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreateAntoine()
{
    object oWaypoint = DB_GetWaypointByTag(ANTOINE_WAYPOINT);
    CreateWereBoar(oWaypoint);
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateWereBoarMinions
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 06, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreateMinions(int nLevel)
{
    object oWaypoint;
    object oAntoine = DB_GetObjectByTag(ANTOINE_TAG);
    int i;
    int nNum = nLevel / 3;


    // Cycle the minion waypoints creating minions on them.
    for (i = 1; i < nNum; ++i)
    {
        oWaypoint = DB_GetNearestObjectByTag(MINION_WAYPOINT + IntToString(i), oAntoine);

        if (!GetIsObjectValid(oWaypoint)) return;

        CreateWereBoar(oWaypoint);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateBoarMinions
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 06, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreateBoarMinions()
{
    object oWaypoint;
    int i;

    // Cycle the dire boar waypoints creating dire boars.
    for(i = 1; i < 8; ++i)
    {
        oWaypoint = DB_GetWaypointByTag(RETREAT_WAYPOINT + IntToString(i));

        CreateBoar(oWaypoint);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: EvaluateOnDamage
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 27, 2005
//::////////////////////////////////////////////////////////////////////////////
void EvaluateOnDamage(object oCreature = OBJECT_SELF)
{
    int nCurrentHitPoints = GetCurrentHitPoints();
    int nMaxHitPoints = GetMaxHitPoints();
    float fHealthRatio = IntToFloat(nCurrentHitPoints) / IntToFloat(nMaxHitPoints);
    string sTag = GetTag(oCreature);

    // Have the area implement any shape-shifts to avoid action queues.
    object oArea = GetArea(oCreature);
    object oSkin;

    // As the creature approaches death they should revert to human form.
    if (nCurrentHitPoints < 5)
    {
        // Remove the were creature skin.
        oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oCreature);

        if (GetIsObjectValid(oSkin))
        {
            DestroyObject(oSkin);
        }

        AssignCommand(oArea, ChangeForm(oCreature, N_FORM_HUMAN));
    }
    else if (fHealthRatio <= 0.75)
    {
        // At lower health turn into a boar and retreat.
        if (fHealthRatio <= 0.25)
        {
            // Remove the were creature skin.
            oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oCreature);

            if (GetIsObjectValid(oSkin))
            {
                DestroyObject(oSkin);
            }

            AssignCommand(oArea, ChangeForm(oCreature, N_FORM_ANIMAL));
        }
        // Mid range health catalyzes the change to were-boar form.
        else
        {
            // Create the were creature skin and equip it.
            oSkin = CreateItemOnObject(SKIN_RESREF, oCreature);

            ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR);

            AssignCommand(oArea, ChangeForm(oCreature, N_FORM_HYBRID));
        }

   }

    // DEBUG
    DebugMessage("inc_id1_antoine::EvaluateOnDamage(" + sTag + ")");
    DebugMessage("^nMaxHitPoints = " + IntToString(nMaxHitPoints));
    DebugMessage("^fHealthRatio = " + FloatToString(fHealthRatio));
}

//::////////////////////////////////////////////////////////////////////////////
//:: ChangeForm
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 26, 2005
//::////////////////////////////////////////////////////////////////////////////
void ChangeForm(object oCreature, int nFormToChangeTo)
{
    // DEBUG
    DebugMessage("inc_id1_antoine::ChangeForm(" + GetTag(oCreature) + ","
        + IntToString(nFormToChangeTo) + ")");

    // If the creature is still on a shape-shift cooldown return.
    if (GetLocalInt(oCreature, SHAPESHIFT_COOLDOWN))
    {
        DebugMessage("^ Creature still on cooldown.");
        return;
    }

    if (!GetCommandable(oCreature)) return;

    int nCurrentForm = GetLocalInt(oCreature, CURRENT_FORM);

    // Make sure the creature isn't attempting to shapeshift into the current form.
    if (nCurrentForm == nFormToChangeTo)
    {
        DebugMessage("^ Shapeshifting to current form.");
        return;
    }

    effect eVFX = EffectVisualEffect(VFX_IMP_POLYMORPH);
    effect eRegen, eSpeed;

    int nAppearanceType;

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oCreature);

    // Reset the creature's name.
    SetName(oCreature);

    // Based on the form to be changed to, switch the creatures appearance type.
    switch (nFormToChangeTo)
    {
        case N_FORM_HUMAN: // Human form.
        {
            nAppearanceType = GetLocalInt(oCreature, HUMAN_APPEARANCE_TYPE);

            SetCreatureAppearanceType(oCreature, nAppearanceType);
            SetLocalInt(oCreature, CURRENT_FORM, N_FORM_HUMAN);

            // Apply a shape-shifting cooldown in order to prevent numerous
            // simultaneous transformations.
            SetLocalInt(oCreature, SHAPESHIFT_COOLDOWN, TRUE);
            DelayCommand(10.0, SetLocalInt(oCreature, SHAPESHIFT_COOLDOWN, FALSE));

            break;
        }
        case N_FORM_ANIMAL: // Animal form.
        {
            // Set the fleeing state
            //SetLocalInt(oCreature, FLEEING_STATE, TRUE);
            //DelayCommand(10.0, SetLocalInt(oCreature, FLEEING_STATE, FALSE));

            // Implement the shapeshift.
            nAppearanceType = GetLocalInt(oCreature, ANIMAL_APPEARANCE_TYPE);

            SetCreatureAppearanceType(oCreature, nAppearanceType);
            SetLocalInt(oCreature, CURRENT_FORM, N_FORM_ANIMAL);

            // Based on the appearance type set the creature's name.
            if (nAppearanceType == APPEARANCE_TYPE_RAT_DIRE)
            {
                SetName(oCreature, "Dire Rat");
            }
            else if (nAppearanceType == APPEARANCE_TYPE_CAT_PANTHER)
            {
                SetName(oCreature, "Panther");
            }
            else if (nAppearanceType == APPEARANCE_TYPE_DOG_WOLF)
            {
                SetName(oCreature, "Wolf");
            }
            else
            {
                SetName(oCreature, "Dire Boar");
            }

            // Apply regen and speed increase effects.
            eRegen = EffectRegenerate(2, 1.0);
            eSpeed = EffectMovementSpeedIncrease(90);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, oCreature, 30.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSpeed, oCreature, 30.0);

            // Retreat to a nearby haven and blend in with the other boars.
            object oRetreat = DB_GetObjectByTag(RETREAT_WAYPOINT + IntToString(Random(7) + 1));
            float fDistance = GetDistanceBetween(oCreature, oRetreat);

            // Implement the flight from danger.
            AssignCommand(oCreature, ClearAllActions(TRUE));
            AssignCommand(oCreature, ActionForceMoveToObject(oRetreat, TRUE));
            AssignCommand(oCreature, SetCommandable(FALSE));

            DelayCommand(fDistance / 3.0, AssignCommand(oCreature, SetCommandable(TRUE)));
            DelayCommand(30.0, ChangeForm(oCreature, N_FORM_HUMAN));

            break;
        }
        case N_FORM_HYBRID: // Half-man Half-beast form.
        {
            nAppearanceType = GetLocalInt(oCreature, HYBRID_APPEARANCE_TYPE);

            SetCreatureAppearanceType(oCreature, nAppearanceType);
            SetLocalInt(oCreature, CURRENT_FORM, N_FORM_HYBRID);

            // The hybrid form only lasts a few seconds.
            DelayCommand(20.0, ChangeForm(oCreature, N_FORM_HUMAN));

            eRegen = EffectRegenerate(1, 2.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, oCreature, 20.0);

            break;
        }
        default:
        {
            DebugMessage("^ Unrecognized form type.");
        }
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateWereBoar
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 26, 2005
//::////////////////////////////////////////////////////////////////////////////
void CreateWereBoar(object oWaypoint)
{
    // First make some checks to ensure we aren't spawning a hostile minion
    // after Antoine has already surrendered.
    object oAntoine = DB_GetObjectByTag(ANTOINE_TAG);

    // If Antoine doesn't exist yet no check needed.
    if (GetIsObjectValid(oAntoine))
    {
        object oDungeon = GetCurrentDungeon();

        int nMinions = GetLocalInt(oAntoine, MINIONS_KILLED);
        int bSurrender = GetLocalInt(GetModule(), "bBacchaSurrender");
        int nLevel = GetLocalInt(oDungeon, "nBossLevel");

        if (nMinions > nLevel) return; // Too many minions.
        if (bSurrender) return; // Already surrendered; this check SHOULD be redundant.
    }

    object oHuman, oWP;
    string sResRef, sTag;
    location lLoc;
    int nResRef;

    // If the waypoint is Antoine's waypoint he should be created otherwise a
    // random were-creature.
    if (GetTag(oWaypoint) == ANTOINE_WAYPOINT)
    {
        nResRef = 0;
    }
    else
    {
        nResRef = Random(5) + 1;
    }

    // Establish the human form ResRef.
    switch (nResRef)
    {
        case 0:
        {
            sResRef = ANTOINE_TAG;
            break;
        }
        case 1:
        {
            sResRef = HUMAN_RESREF_01;
            break;
        }
        case 2:
        {
            sResRef = HUMAN_RESREF_02;
            break;
        }
        case 3:
        {
            sResRef = HUMAN_RESREF_03;
            break;
        }
        case 4:
        {
            sResRef = HUMAN_RESREF_04;
            break;
        }
        case 5:
        {
            sResRef = HUMAN_RESREF_05;
            break;
        }
    }

    // Debug Information.
    DebugMessage("inc_id1_antoine::CreateWereBoar()");
    DebugMessage("^ sResRef = " + sResRef);

    // Create the human form.
    lLoc = GetLocation(oWaypoint);

    object oDungeon = GetCurrentDungeon();
    int nEncounter = GetLocalInt(oDungeon, "nBossLevel");

    oHuman = DB_CreateObject(OBJECT_TYPE_CREATURE, sResRef, lLoc);

    // Jan  30, 2006: Set level up information.
    SetLocalInt(oHuman, "nCreatureType", 3);

    if (nResRef == 0) // Antoine
    {
        SetLocalInt(oHuman, "nCR", nEncounter + 4);
        SetLocalInt(oHuman, "nBaseHD", 1);
        SetLocalInt(oHuman, "nClassStartHD", 5);
        SetLocalInt(oHuman, "nClass", 4);

        // Appearance Type variables.
        SetLocalInt(oHuman, HYBRID_APPEARANCE_TYPE, 996);
        SetLocalInt(oHuman, ANIMAL_APPEARANCE_TYPE, APPEARANCE_TYPE_BOAR_DIRE);

        // baccha adjustments for multiplayer
/*        if (GetLocalInt(GetModule(), "bMultiplayer") == TRUE)
//        if (TRUE) // EDIT: testing
        {
            int nPlayer = 0;
            object oPlayer = GetFirstPC();
            while (oPlayer != OBJECT_INVALID)
            {
                nPlayer++;
                oPlayer = GetNextPC();
            }
//            nPlayer = 4; // EDIT: testing
            DebugMessage("There are " + IntToString(nPlayer) + " players in multiplayer.");

            if (nPlayer > 1)
            {
                object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oHuman);
                DebugMessage("Object in skin slot is " + GetTag(oSkin));
                if (oSkin != OBJECT_INVALID)
                {
                    int nDamageImmunity;
                    if (nPlayer == 2)
                    {
                        nDamageImmunity = IP_CONST_DAMAGEIMMUNITY_10_PERCENT;
                    } else if (nPlayer == 3)
                    {
                        nDamageImmunity = IP_CONST_DAMAGEIMMUNITY_25_PERCENT;
                    } else if (nPlayer == 4)
                    {
                        nDamageImmunity = IP_CONST_DAMAGEIMMUNITY_50_PERCENT;
                    } else if (nPlayer == 5)
                    {
                        nDamageImmunity = IP_CONST_DAMAGEIMMUNITY_75_PERCENT;
                    } else
                    {
                        nDamageImmunity = IP_CONST_DAMAGEIMMUNITY_90_PERCENT;
                    }
                    IPSafeAddItemProperty(oSkin, ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_BLUDGEONING, nDamageImmunity));
                    IPSafeAddItemProperty(oSkin, ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_PIERCING, nDamageImmunity));
                    IPSafeAddItemProperty(oSkin, ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_SLASHING, nDamageImmunity));
                    IPSafeAddItemProperty(oSkin, ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_ACID, nDamageImmunity));
                    IPSafeAddItemProperty(oSkin, ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_COLD, nDamageImmunity));
                    IPSafeAddItemProperty(oSkin, ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_ELECTRICAL, nDamageImmunity));
                    IPSafeAddItemProperty(oSkin, ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_FIRE, nDamageImmunity));
                    IPSafeAddItemProperty(oSkin, ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_SONIC, nDamageImmunity));
                    DebugMessage("Damage immunity added is " + IntToString(nDamageImmunity));
                }
            }
        }
*/
    }
    else // Minions
    {
        nEncounter -= 2;

        if (nEncounter <= 0) nEncounter = 1;

        SetLocalInt(oHuman, "nCR", nEncounter);
        SetLocalInt(oHuman, "nBaseHD", 1);
        SetLocalInt(oHuman, "nClass", -1);
    }

    SetLocalInt(oHuman, "bEquipWeapon", TRUE);
    SetLocalInt(oHuman, HUMAN_APPEARANCE_TYPE, GetAppearanceType(oHuman));

    // Force the model for human form to be loaded. This shouldn't be needed
    // but creatures are spawning in completely invisible/unselectable for
    // no aparant reason.
    object oArea = GetArea(oHuman);

    AssignCommand(oArea, ChangeForm(oHuman, N_FORM_HYBRID));
    DelayCommand(1.0, AssignCommand(oArea, ChangeForm(oHuman, N_FORM_HUMAN)));

    // The rest does not apply to Antoine.
    if (nResRef == 0)
    {
        return;
    }

    // Establish and set the Hybrid and animal form appearance types.
    switch(Random(3))
    {
        case 0: // Creature is a were-rat.
        {
            SetLocalInt(oHuman, HYBRID_APPEARANCE_TYPE, APPEARANCE_TYPE_WERERAT);
            SetLocalInt(oHuman, ANIMAL_APPEARANCE_TYPE, APPEARANCE_TYPE_RAT_DIRE);
            break;
        }
        case 1: // Creature is a were-cat.
        {
            SetLocalInt(oHuman, HYBRID_APPEARANCE_TYPE, APPEARANCE_TYPE_WERECAT);
            SetLocalInt(oHuman, ANIMAL_APPEARANCE_TYPE, APPEARANCE_TYPE_CAT_PANTHER);
            break;
        }
        default: // Creature is a were-wolf.
        {
            SetLocalInt(oHuman, HYBRID_APPEARANCE_TYPE, APPEARANCE_TYPE_WEREWOLF);
            SetLocalInt(oHuman, ANIMAL_APPEARANCE_TYPE, APPEARANCE_TYPE_DOG_WOLF);
            break;
        }
    }

    // Have the minion move to Antoine if they are further than 20 meters away.
    if (GetDistanceBetween(oHuman, oAntoine) > 20.0)
    {
        AssignCommand(oHuman, ActionMoveToObject(oAntoine, TRUE, 4.0));
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateBoar
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 26, 2005
//::////////////////////////////////////////////////////////////////////////////
void CreateBoar(object oWaypoint)
{
    object oAntoine = DB_GetObjectByTag(ANTOINE_TAG);
    object oDungeon = GetCurrentDungeon();

    if (GetLocalInt(oAntoine, MINIONS_KILLED) > 70) return;

    int nEncounter = GetLocalInt(oDungeon, "nBossLevel");

    location lLoc = GetLocation(oWaypoint);
    object oBoar = DB_CreateObject(OBJECT_TYPE_CREATURE, BOAR_RESREF, lLoc, FALSE, MINION_TAG);

    SetLocalInt(oBoar, HUMAN_APPEARANCE_TYPE, -1);
    SetLocalInt(oBoar, "nCR", nEncounter);
    SetLocalInt(oBoar, "nBaseHD", 1);
    SetLocalInt(oBoar, "nClass", -1);

    effect eDamage = EffectDamage(d10(nEncounter / 2));

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oBoar);
}
