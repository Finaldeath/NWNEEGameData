//::///////////////////////////////////////////////
//:: inc_respawn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Handles the death of the NPC Crewmen in act 3
    (Island of the Dead - Hunting of sigils)
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "x0_i0_henchman"

// Revive the NPC and heal him according to difficulty
void ReviveNPC(object oTarget);
// create a marker at the location of the fallen object
void DeadMarker(object oDead);
// Clear the death marker for the referenced object
void ClearDeadMarker(object oDead);
// Ensure that the coast is clear for oLeader before respawning
void CheckTargetSafeState(object oLeader, object oTarget);
// Move to the leader once the coast is clear
void MoveNPCToSafeLocation(object oLeader, object oTarget);


// Revive the NPC and heal him according to difficulty
void ReviveNPC(object oTarget)
{
    int iDiff = GetGameDifficulty();
    int iHitPoints = GetMaxHitPoints(oTarget);

    effect eRez = EffectResurrection();
    effect eRegen = EffectRegenerate((iHitPoints/15)+1, 1.0f);
    effect eRestore = EffectHeal(iHitPoints);
    effect eVFX = EffectVisualEffect(VFX_DUR_SANCTUARY);

    object oMapPoint = OBJECT_INVALID;

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eRez, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oTarget, 5.0f);
    SetImmortal(oTarget, TRUE);

    // If difficulty is easy, just restore them, otherwise make the regen HP.
    if ((iDiff == GAME_DIFFICULTY_EASY) || (iDiff == GAME_DIFFICULTY_VERY_EASY))
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRestore, oTarget);
    }
    else if (iDiff == GAME_DIFFICULTY_NORMAL)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, oTarget, 15.0f);
    }

    ClearDeadMarker(oTarget);
    AssignCommand(GetModule(), DelayCommand(5.0f, SetImmortal(oTarget, FALSE)));
}

// safety to ensure that no eronious markers a left behind
void SanityCheck(object oDead)
{
    if (GetIsDead(oDead) == TRUE)
        DelayCommand(10.0f, SanityCheck(oDead));
    else
        ClearDeadMarker(oDead);
}

// create a marker at the location of the fallen object
void DeadMarker(object oDead)
{
    object oMarker;

    oMarker = CreateObject(OBJECT_TYPE_WAYPOINT, "potsc_corpsenode",
        GetLocation(oDead));
    SetLocalObject(oDead, "GRAVE_MARKER", oMarker);

    //sanity check so tomb stones aren't sticking round for the living...
    AssignCommand(GetModule(), DelayCommand(10.0f, SanityCheck(oDead)));
}

// Clear the death marker for the referenced object
void ClearDeadMarker(object oDead)
{
    object oMarker;

    oMarker = GetLocalObject(oDead, "GRAVE_MARKER");
    DeleteLocalObject(oDead, "GRAVE_MARKER");

    SetMapPinEnabled(oMarker, FALSE);
    DestroyObject(oMarker);
}

// Ensure that the coast is clear for oLeader before respawning
void CheckTargetSafeState(object oLeader, object oTarget)
{
    location lPos = GetLocation(oLeader);
    object oHostile = OBJECT_INVALID;
    int iRepeat = FALSE;

    // if the leader isn't in combat check his surrounding area
    if (GetIsInCombat(oLeader) == FALSE)
    {
        oHostile = GetFirstObjectInShape(SHAPE_SPHERE, 25.0f, lPos,
            TRUE, OBJECT_TYPE_CREATURE);

        // Check for any hostiles in the immediate visinity
        while (GetIsObjectValid(oHostile) == TRUE)
        {
            if (GetIsReactionTypeHostile(oLeader, oHostile) == TRUE)
            {
                iRepeat = TRUE;
            }

            oHostile = GetNextObjectInShape(SHAPE_SPHERE, 25.0f, lPos,
                TRUE, OBJECT_TYPE_CREATURE);
        }
    }

    // If a hostile was identified bail and try again in 5 seconds
    if (iRepeat == TRUE)
    {
        DelayCommand(5.0f, CheckTargetSafeState(oLeader, oTarget));
    }
    // If the coast was clear revive the fallen NPC
    else
    {
        ReviveNPC(oTarget);
        //DelayCommand(0.5f, MoveNPCToSafeLocation(oLeader, oTarget));
    }
}

// Move to the leader once the coast is clear
void MoveNPCToSafeLocation(object oLeader, object oTarget)
{
    location lLeader = GetLocation(oLeader);
    location lTarget = GetLocation(oTarget);
    location lSafePoint;

    int bWasHench = GetLocalInt(oTarget, "WAS_HENCH");

    // if you in the same area as the leader, walk to them
    if (GetAreaFromLocation(lLeader) == GetAreaFromLocation(lTarget))
    {
        AssignCommand(oTarget, ClearAllActions(TRUE));
        AssignCommand(oTarget, ActionForceMoveToLocation(lLeader, TRUE, 10.0f));
    }
    // otherwise warp to their location.
    else
    {
        if (bWasHench == TRUE)
        {
            HireHenchman(oLeader, oTarget);
        }

        AssignCommand(oTarget, JumpToLocation(lLeader));
    }
}
