//::///////////////////////////////////////////////
//:: inc_safehench
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Include file for functions relating to the
    Custom Henchmen Death system.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////

// Edited by Jason Lowry August 23, 2005.
// Removed PotSC undead henchman rules.

// Edited by Jason Lowry August 25, 2005
// Added some henchman respawn conditionals

#include "x0_i0_henchman"
#include "inc_id1_flags"
#include "inc_id1_debug"


// Tracking variable for dead henchmen's masters.
const string MASTER = "oMaster";


//remove negative effects
void SSRemoveEffects(object oTarget);

// Return a Henchman to life with properties
// based on game Difficulty.
void ReviveNPC(object oTarget);

// Create a Marker on the Minimap outlining the location
// at which a henchmen object died.
void DeadMarker(object oDead);

// Clear any death markers for the Target.
void ClearDeadMarker(object oDead);

// Check the state of the Henchmen's leader
// If the leader is not in combat and a safe distance from
// hostiles return the Henchman to the leader.
void CheckTargetSafeState(object oLeader, object oTarget);

// Return the NPC henchmen to his leader.
void MoveNPCToSafeLocation(object oLeader, object oTarget);

// Handle the death system for the calling object.
void HandleDeath(object oDead = OBJECT_SELF);

// Handle the death system for the calling object.
void HandleDeath(object oDead)
{
    object oLeader = OBJECT_INVALID;
    object oMapNote = OBJECT_INVALID;

    oLeader = GetMaster(oDead);
    DeadMarker(oDead);

    if (GetIsObjectValid(oLeader) == FALSE)
    {
        oLeader = OBJECT_SELF;
    }

    // Upate Nov. 1, 2005 - Grant
    // Henchmen will track there master but no longer remain as henchmen after
    // death in order to avoid the area jumping of dead henchmen. Tracking the
    // henchman's master may be unecesarry.
    SetLocalObject(oDead, MASTER, oLeader);
    //DelayCommand(0.2, AddHenchman(oLeader, oDead)); <- area jumping bug.
    DelayCommand(5.0f, CheckTargetSafeState(oLeader, oDead));
}

// Return a Henchman to life with properties
// based on game Difficulty.
void ReviveNPC(object oTarget)
{
    // Update Oct. 27, 2005 - Grant
    // Henchmen will revive with a hitpoint total based on module flags.
    // Undead references from PotSC removed.
    // NPCs will no longer be immortal when they revive.
    int nMaxHitpoints = GetMaxHitPoints(oTarget);

    effect eRez = EffectResurrection();

    // Resurrect the henchman.
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eRez, oTarget);

    // Remove any negative effects.
    SSRemoveEffects(oTarget);

    // Clear the dead marker from the mini-map.
    ClearDeadMarker(oTarget);
/*
    // Determine a number of hitpoints to restore based on the module flags.
    int nFlag = GetModuleFlag(ID1_FLAG_HENCHMAN_RESPAWN_HEALTH);
    effect eRestore;

    switch (nFlag)
    {
        case ID1_HENCHMAN_RESPAWN_HEALTH_MAX:
        {
            // Henchmen respawn with full health.
            eRestore = EffectHeal(nMaxHitpoints);

            break;
        }
        case ID1_HENCHMAN_RESPAWN_HEATLH_PRECENTILE:
        {
            // Henchmen respawn with a fraction of their total health.
            int nPercent = GetModuleFlagValue(ID1_FLAG_HENCHMAN_RESPAWN_HEALTH);

            eRestore = EffectHeal(nMaxHitpoints * (nPercent / 100));

            break;
        }
        default:
        {
            // Henchmen respawn with 1 Hitpoint.
            eRestore = EffectHeal(0);

            break;
        }
    }

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eRestore, oTarget);

    // When the revive rested flag is set henchmen should revive from death
    // with full spells and daily abilities.
    nFlag = GetModuleFlag(ID1_FLAG_HENCHMAN_RESPAWN_RESTED);

    if (nFlag == ID1_HENCHMAN_RESPAWN_RESTED_ACTIVE)
    {
        ForceRest(oTarget);
    }*/
}

// Clean-up for grave markers.
void SanityCheck(object oDead)
{
    if (GetIsDead(oDead) == TRUE)
        DelayCommand(5.0f, SanityCheck(oDead));
    else
        ClearDeadMarker(oDead);
}

// Create a Marker on the Minimap outlining the location
// at which a henchmen object died.
void DeadMarker(object oDead)
{
    object oMarker;

    oMarker = CreateObject(OBJECT_TYPE_WAYPOINT, "potsc_corpsenode",
        GetLocation(oDead));
    SetLocalObject(oDead, "GRAVE_MARKER", oMarker);

    //sanity check so tomb stones aren't sticking round for the living...
    AssignCommand(GetModule(), DelayCommand(5.0f, SanityCheck(oDead)));
}

// Clear any death markers for the Target.
void ClearDeadMarker(object oDead)
{
    object oMarker;

    oMarker = GetLocalObject(oDead, "GRAVE_MARKER");
    DeleteLocalObject(oDead, "GRAVE_MARKER");

    SetMapPinEnabled(oMarker, FALSE);
    DestroyObject(oMarker);
}

// Check the state of the Henchmen's leader
// If the leader is not in combat and a safe distance from
// hostiles return the Henchman to the leader.
void CheckTargetSafeState(object oLeader, object oTarget)
{
    location lPos = GetLocation(oLeader);
    object oHostile = OBJECT_INVALID;
    int iRepeat = FALSE;
    // ID edit - Jason 25 August
    // Further ID edits - Grant 25 October
/*    int nDeathFlag = GetModuleFlag(ID1_FLAG_DEATH_HENCHMEN_DEATH);
    int nRespawnFlag = GetModuleFlag(ID1_FLAG_DEATH_RESPAWN_HENCHMEN);
    int bMasterRespawn = GetLocalInt(oTarget, "bMasterRespawn");

    // Check for area constrictions etc.
    switch (nRespawnFlag)
    {
        // Master must be nearby for the henchman to respawn.
        case ID1_DEATH_RESPAWN_HENCHMEN_NONE:
        {
            if (GetDistanceBetween(oLeader, oTarget) > 5.0)
            {
                iRepeat = TRUE;
            }

            break;
        }
        // Master must be in the same area.
        case ID1_DEATH_RESPAWN_HENCHMEN_AREA:
        {
            if (GetArea(oTarget) != GetArea(oLeader))
            {
                iRepeat = TRUE;
            }

            break;
        }
        // Master must be on the same level.
        case ID1_DEATH_RESPAWN_HENCHMEN_LEVEL:
        {
            // Level should be recorded on the henchman when he dies.
            if (GetLocalInt(oTarget, "nDeathLevel") !=
                GetLocalInt(GetModule(), "nCurrentLevel"))
            {
                iRepeat = TRUE;
            }

            break;
        }
        // Master must be in the same dungeon.
        case ID1_DEATH_RESPAWN_HENCHMEN_DUNGEON:
        {
            // For now this has been removed.
            break;
        }
        // Doesn't matter where the master is.
        default:
        {
            break;
        }
    }

    // When the henchman is only allowed to respawn when the master has done so.
    if (nDeathFlag == ID1_DEATH_HENCHMEN_DEATH_RESPAWN_PLAYER)
    {
        // Make sure the master has respawned first.
        if (!bMasterRespawn)
        {
            iRepeat = TRUE;
        }
    }*/
    // End edit

    // Check for a Valid Spawn State
    // (Leader is Valid and not in danger)
    if (GetIsObjectValid(oLeader) == FALSE)
    {
        iRepeat = TRUE;
    }
    else if (GetIsInCombat(oLeader) == TRUE)
    {
        iRepeat = TRUE;
    }
    else if (GetIsInCombat(oLeader) == FALSE)
    {
//        ActionSpeakStringByStrRef(36);
        oHostile = GetFirstObjectInShape(SHAPE_SPHERE, 20.0f, lPos,
            TRUE, OBJECT_TYPE_CREATURE);

       //SendMessageToPC(oLeader, "Checking Surrounding Targets: Tag '"
       //     + GetTag(oHostile) + "'");

        while (oHostile != OBJECT_INVALID)
        {
            if ((GetIsEnemy(oLeader, oHostile) == TRUE)
                && (GetIsDead(oHostile) == FALSE))
            {
                iRepeat = TRUE;
            }

            oHostile = GetNextObjectInShape(SHAPE_SPHERE, 20.0f, lPos,
                TRUE, OBJECT_TYPE_CREATURE);

            //SendMessageToPC(oLeader, "Checking Surrounding Targets: Tag '"
            //    + GetTag(oHostile) + "'");
        }
    }
    //ID Edit Aug 25 - Jason Lowry
/*    if (nDeathFlag == ID1_DEATH_HENCHMEN_DEATH_RESPAWN_DELAY)
    {
        // Wait 30 seconds and get up even if battle still in progress.
        DelayCommand(30.0,ReviveNPC(oTarget));
        return;
    }
    // End Edit
    // If not Safe try again later, else respawn the Henchmen
    else if (iRepeat == TRUE)
    {
        //SendMessageToPC(oLeader, "Target Unsafe.");
        DelayCommand(5.0f, CheckTargetSafeState(oLeader, oTarget));
    }
    else
    {
        //SendMessageToPC(oLeader, "Target Safe, Respawn Henchmen.");
        ReviveNPC(oTarget);
        DelayCommand(0.5f, MoveNPCToSafeLocation(oLeader, oTarget));
    }*/
}

// Return the NPC henchmen to the leader.
void MoveNPCToSafeLocation(object oLeader, object oTarget)
{
    location lLeader = GetLocation(oLeader);
    location lTarget = GetLocation(oTarget);
    location lSafePoint;

    // If the Leader is valid jump to them, else try again later.
    if (GetIsObjectValid(oLeader) == TRUE)
    {
        AddHenchman(oLeader, oTarget);
        DebugMessage("Clearing actions. Point 17.");
        AssignCommand(oTarget, ClearAllActions(TRUE));
        AssignCommand(oTarget, JumpToLocation(lLeader));
        AssignCommand(oTarget, ActionForceMoveToObject(oLeader));
    }
    else
    {
        DelayCommand(1.0f, MoveNPCToSafeLocation(oLeader, oTarget));
    }
}

//remove any negative effects
void SSRemoveEffects(object oTarget)
{
    effect eBad = GetFirstEffect(oTarget);

    // note: pulled from default death scripts
    while(GetIsEffectValid(eBad))
    {
        int nEffectType = GetEffectType(eBad);
        if (nEffectType == EFFECT_TYPE_ABILITY_DECREASE ||
            nEffectType == EFFECT_TYPE_AC_DECREASE ||
            nEffectType == EFFECT_TYPE_ARCANE_SPELL_FAILURE ||
            nEffectType == EFFECT_TYPE_ATTACK_DECREASE ||
            nEffectType == EFFECT_TYPE_BLINDNESS ||
            nEffectType == EFFECT_TYPE_CHARMED ||
            nEffectType == EFFECT_TYPE_CONFUSED ||
            nEffectType == EFFECT_TYPE_CURSE ||
            nEffectType == EFFECT_TYPE_CUTSCENE_PARALYZE ||
            nEffectType == EFFECT_TYPE_DAMAGE_DECREASE ||
            nEffectType == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            nEffectType == EFFECT_TYPE_DAZED ||
            nEffectType == EFFECT_TYPE_DEAF ||
            nEffectType == EFFECT_TYPE_DISEASE ||
            nEffectType == EFFECT_TYPE_DOMINATED ||
            nEffectType == EFFECT_TYPE_ENTANGLE ||
            nEffectType == EFFECT_TYPE_FRIGHTENED ||
            nEffectType == EFFECT_TYPE_NEGATIVELEVEL ||
            nEffectType == EFFECT_TYPE_PARALYZE ||
            nEffectType == EFFECT_TYPE_PETRIFY ||
            nEffectType == EFFECT_TYPE_POISON ||
            nEffectType == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            nEffectType == EFFECT_TYPE_SILENCE ||
            nEffectType == EFFECT_TYPE_SKILL_DECREASE ||
            nEffectType == EFFECT_TYPE_SLEEP ||
            nEffectType == EFFECT_TYPE_SLOW ||
            nEffectType == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            nEffectType == EFFECT_TYPE_STUNNED)
        {
                //Remove effect if it is negative.
                DelayCommand(0.1f, RemoveEffect(oTarget, eBad));
            }

        eBad = GetNextEffect(oTarget);
    }

    return;
}

//void main(){}

