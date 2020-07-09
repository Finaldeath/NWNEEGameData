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
// Modified 30th March , B W-Husey to remove the evil plot item eating bug
// Modified 17th April to get henchmen to respawn properly

#include "inc_undead"
#include "x0_i0_henchman"
#include "dla_i0_horse"

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

//    DelayCommand(0.2, DLA_SetHenchman(oLeader, oDead));    Does nothing
    DelayCommand(5.0f, CheckTargetSafeState(oLeader, oDead));
}

// Return a Henchman to life with properties
// based on game Difficulty.
void ReviveNPC(object oTarget)
{
    int iDiff = GetGameDifficulty();
    int iHitPoints = GetMaxHitPoints(oTarget);
    int iUndead = GetLocalInt(oTarget, "IOP_CUST_UNDEAD");

    effect eRez = EffectResurrection();
    effect eRegen = EffectRegenerate((iHitPoints/15)+1, 1.0f);
    effect eRestore = EffectHeal(iHitPoints);
    effect eVFX = EffectVisualEffect(VFX_DUR_SANCTUARY);

    object oMapPoint = OBJECT_INVALID;
    object oCommoner = GetObjectByTag("cr_comfact");
    object oDefender  = GetObjectByTag("cr_deffact");
    object oMerchant = GetObjectByTag("cr_merfact");

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eRez, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oTarget, 5.0f);
    SetImmortal(oTarget, TRUE);

    SSRemoveEffects(oTarget);

    if ((iDiff == GAME_DIFFICULTY_EASY) || (iDiff == GAME_DIFFICULTY_VERY_EASY))
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRestore, oTarget);
    }
    else if (iDiff == GAME_DIFFICULTY_NORMAL)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, oTarget, 15.0f);
    }

    // the the object that rez'd
    if (iUndead == TRUE)
    {
        ApplyVFXEyes(oTarget);
    }

    ClearDeadMarker(oTarget);
    AssignCommand(GetModule(), DelayCommand(5.0f, SetImmortal(oTarget, FALSE)));

    int i =1;
    object oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,oTarget,i,CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY);
    while(GetIsObjectValid(oCreature))
    {
        if(GetFactionEqual(oCreature,oCommoner) ||
           GetFactionEqual(oCreature,oDefender) ||
           GetFactionEqual(oCreature,oMerchant))
        {
            SetIsTemporaryFriend(oTarget,oCreature);
            SetIsTemporaryFriend(oCreature,oTarget);
        }
        i++;
        oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,oTarget,i,CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY);
    }
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
//        ActionSpeakStringByStrRef(36); //THIS EVIL LINE CAUSES PLOT ITEMS TO DISSAPPEAR
// I NEVER WANT TO SEE IT AGAIN!
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


    // If not Safe try again later, else respawn the Henchmen
    if (iRepeat == TRUE)
    {
        //SendMessageToPC(oLeader, "Target Unsafe.");
        DelayCommand(5.0f, CheckTargetSafeState(oLeader, oTarget));
    }
    else
    {
        //SendMessageToPC(oLeader, "Target Safe, Respawn Henchmen.");
        ReviveNPC(oTarget);
        DelayCommand(0.5f, MoveNPCToSafeLocation(oLeader, oTarget));
    }
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
        DLA_SetHenchman(oTarget, oLeader);
//        DLA_SetHenchman(oLeader, oTarget);
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
