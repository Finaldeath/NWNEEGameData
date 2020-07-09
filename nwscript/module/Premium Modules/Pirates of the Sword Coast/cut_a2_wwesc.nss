//::///////////////////////////////////////////////
//:: Whipped Willigan escape
//:: cut_a2_wwesc
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Whipped Willigan makes his dramatic escape
    from the clutches of his evil wife and her
    wicked sisters.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 22, 2005
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    // waypoints
    object oWP_Fanny_1 = GetObjectByTagInArea(a2w_Willigan_CS_Fanny_1);
    object oWP_FannySis1_1 = GetObjectByTagInArea(a2w_Willigan_CS_FannySis1_1);
    object oWP_FannySis2_1 = GetObjectByTagInArea(a2w_Willigan_CS_FannySis2_1);
    object oWP_Willigan_1 = GetObjectByTagInArea(a2w_Willigan_CS_Willigan_1);
    object oWP_PC1_1 = GetObjectByTagInArea(a2w_Willigan_CS_PC1_1);
    object oWP_PC2_1 = GetObjectByTagInArea(a2w_Willigan_CS_PC2_1);
    object oWP_PC3_1 = GetObjectByTagInArea(a2w_Willigan_CS_PC3_1);
    object oWP_PC4_1 = GetObjectByTagInArea(a2w_Willigan_CS_PC4_1);
    object oWP_Hench1_1 = GetObjectByTagInArea(a2w_Willigan_CS_Hench1_1);
    object oWP_Hench2_1 = GetObjectByTagInArea(a2w_Willigan_CS_Hench2_1);

    effect eCutGhost = EffectCutsceneGhost();
    // creatures
    object oFanny = GetObjectByTag(a2c_tag_Fanny);
    object oFannySis1 = GetObjectByTag(a2c_tag_FannySis1);
    object oFannySis2 = GetObjectByTag(a2c_tag_FannySis2);
    object oWilligan = GetObjectByTag(a2c_tag_Willigan);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oFanny);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oFannySis1);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oFannySis2);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oWilligan, 0.0, TRUE);

    // the logic behind this - First, I only copy henchmen who are in the area.
    // Second, if only one henchman is in the area, I want the one to use the
    // object oHench1, and oHench2 should be invalid. This ensures that the one
    // henchman is placed in the best spot for the cutscene.
    object oRealHench1 = GetObjectByTagInArea(a1c_tag_Garm);
    object oRealHench2 = OBJECT_INVALID;
    if(GetIsObjectValid(oRealHench1)) oRealHench2 = GetObjectByTagInArea(a2c_tag_Nisar);
    else oRealHench1 = GetObjectByTagInArea(a2c_tag_Nisar);
    object oHench1 = CopyObject(oRealHench1, GetLocation(oWP_Hench1_1), OBJECT_INVALID, "cs_hench1_copy");
    object oHench2 = CopyObject(oRealHench2, GetLocation(oWP_Hench2_1), OBJECT_INVALID, "cs_hench2_copy");
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oHench1);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oHench2);
    AssignCommand(oHench1, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oHench2, SetIsDestroyable(TRUE, FALSE, FALSE));

    object oPCCopy1 = cs_CopyPC(GetLocation(oWP_PC1_1));
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oPCCopy1);
    object oPCCopy2 = cs_CopyPC(GetLocation(oWP_PC2_1), FALSE, 1);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oPCCopy2);
    object oPCCopy3 = cs_CopyPC(GetLocation(oWP_PC3_1), FALSE, 2);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oPCCopy3);
    object oPCCopy4 = cs_CopyPC(GetLocation(oWP_PC4_1), FALSE, 3);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oPCCopy4);

    // placeables
    object oWillyTarget = GetObjectByTagInArea(a2p_Willigan_CS_Willy_Target);
    object oFannyTarget = GetObjectByTagInArea(a2p_Willigan_CS_Fanny_Target);

    // door
    object oDoor = GetObjectByTagInArea(a2d_Willigan_Spindrift);
    SetPlotFlag(oDoor, FALSE);
    // unlikely the door will be open at this point, but just in case
    if(GetIsOpen(oDoor)) AssignCommand(oDoor, ActionCloseDoor(oDoor));

    float fDelay;
//------------------------------------------------------------------------------

    cs_ActionJumpToObject(0.0, oFanny, oWP_Fanny_1);
    cs_ActionJumpToObject(0.0, oFannySis1, oWP_FannySis1_1);
    cs_ActionJumpToObject(0.0, oFannySis2, oWP_FannySis2_1);
    cs_ActionJumpToObject(0.0, oWilligan, oWP_Willigan_1);

    effect eImmobilze = EffectCutsceneImmobilize();
    cs_ApplyEffectToObject(0.1, DURATION_TYPE_PERMANENT, eImmobilze, oFanny);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eImmobilze, oFannySis1);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eImmobilze, oFannySis2);

    // camera fades in on sisters blocking door. They look menacing.
    cs_CameraUseCameraWaypoint(0.4, 1);
    cs_CameraDoFade(0.5, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    cs_ActionAttack(1.0, oFanny, oFannyTarget, FALSE);
    cs_ActionAttack(0.0, oFannySis1, oFannyTarget, FALSE);
    cs_ActionAttack(0.0, oFannySis2, oFannyTarget, FALSE);

    // camera switchs to Willy, PC & henchmen. They also look menacing.
    cs_CameraDoFade(2.0, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);
    cs_CameraUseCameraWaypoint(0.9, 2);
    cs_CameraDoFade(0.5, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    cs_ActionAttack(1.0, oWilligan, oWillyTarget, FALSE);
    cs_ActionAttack(0.0, oPCCopy1, oWillyTarget, FALSE);
    cs_ActionAttack(0.0, oPCCopy2, oWillyTarget, FALSE);
    cs_ActionAttack(0.0, oPCCopy3, oWillyTarget, FALSE);
    cs_ActionAttack(0.0, oPCCopy4, oWillyTarget, FALSE);
    cs_ActionAttack(0.0, oHench1, oWillyTarget, FALSE);
    cs_ActionAttack(0.0, oHench2, oWillyTarget, FALSE);

    cs_CameraDoFade(2.0, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);
    cs_CameraUseCameraWaypoint(0.9, 3);
    cs_CameraDoFade(0.5, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    cs_ClearAllActions(1.2, oWilligan);
    cs_ActionPlayAnimation(0.1, oWilligan, ANIMATION_FIREFORGET_VICTORY1);
    cs_SpeakString(0.0, oWilligan, s_A2_WILLIGAN_CHARGE);

    cs_ClearAllActions(1.0, oHench1);
    cs_ClearAllActions(0.0, oHench2);
    cs_ClearAllActions(0.0, oPCCopy1);
    cs_ClearAllActions(0.0, oPCCopy2);
    cs_ClearAllActions(0.0, oPCCopy3);
    cs_ClearAllActions(0.0, oPCCopy4);
    cs_ActionPlayAnimation(0.1, oHench1, ANIMATION_FIREFORGET_VICTORY1);
    cs_ActionPlayAnimation(0.0, oHench2, ANIMATION_FIREFORGET_VICTORY1);
    cs_ActionPlayAnimation(0.0, oPCCopy1, ANIMATION_FIREFORGET_VICTORY1);
    cs_ActionPlayAnimation(0.0, oPCCopy2, ANIMATION_FIREFORGET_VICTORY1);
    cs_ActionPlayAnimation(0.0, oPCCopy3, ANIMATION_FIREFORGET_VICTORY1);
    cs_ActionPlayAnimation(0.0, oPCCopy4, ANIMATION_FIREFORGET_VICTORY1);

    // I'm storing what the delay has built up to. Then I reset it back to 0.0.
    // Then I apply the Immobilize effect on some people. The immobilize effect
    // happens at the start of the cutscene, but I specify a duration of fDelay.
    // This way I can muck about with the timing of the cutscene, but the
    // immobilization is always removed at the right time.
    // And after this, I reset the delay to fDelay so I can continue with the scene.
    fDelay = cs_GetDelay();
    cs_ResetDelay(-1.0, 0.0);
    // Willy is the only object that gets re-used after the cutscene, which
    // is why he's the only one to use the bDestroyOnCSEnd parameter
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_TEMPORARY, eImmobilze, oWilligan, fDelay, TRUE);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_TEMPORARY, eImmobilze, oPCCopy1, fDelay);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_TEMPORARY, eImmobilze, oPCCopy2, fDelay);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_TEMPORARY, eImmobilze, oPCCopy3, fDelay);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_TEMPORARY, eImmobilze, oPCCopy4, fDelay);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_TEMPORARY, eImmobilze, oHench1, fDelay);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_TEMPORARY, eImmobilze, oHench2, fDelay);
    cs_ResetDelay(-1.0, fDelay);

    cs_ActionMoveToObject(1.0, oWilligan, oWillyTarget, TRUE, 0.0);
    cs_ActionMoveToObject(0.1, oHench1, oWillyTarget, TRUE, 0.0);
    cs_ActionMoveToObject(0.0, oHench2, oWillyTarget, TRUE, 0.0);
    cs_ActionMoveToObject(0.0, oPCCopy1, oWillyTarget, TRUE, 0.0);
    cs_ActionMoveToObject(0.0, oPCCopy2, oWillyTarget, TRUE, 0.0);
    cs_ActionMoveToObject(0.0, oPCCopy3, oWillyTarget, TRUE, 0.0);
    cs_ActionMoveToObject(0.0, oPCCopy4, oWillyTarget, TRUE, 0.0);

    cs_ClearAllActions(1.5, oFanny);
    cs_ClearAllActions(0.0, oFannySis1);
    cs_ClearAllActions(0.0, oFannySis2);
    cs_ActionPlayAnimation(0.1, oFanny, ANIMATION_LOOPING_DEAD_BACK, 1.0, 60.0);
    cs_ActionPlayAnimation(0.0, oFannySis1, ANIMATION_LOOPING_DEAD_BACK, 1.0, 60.0);
    cs_ActionPlayAnimation(0.0, oFannySis2, ANIMATION_LOOPING_DEAD_BACK, 1.0, 60.0);

    effect eDamage = EffectDamage(1000);
    cs_ApplyEffectToObject(0.5, DURATION_TYPE_INSTANT, eDamage, oDoor);

    cs_CameraDoFade(0.2, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);
    cs_DestroyObject(1.5, oHench1);
    cs_DestroyObject(0.0, oHench2);
    cs_DestroyObject(0.0, oFanny);
    cs_DestroyObject(0.0, oFannySis1);
    cs_DestroyObject(0.0, oFannySis2);
    cs_DestroyObject(0.0, oDoor); // if aborted, damage effect isn't applied
    cs_EndCutscene(0.1, FALSE, TRUE, FADE_SPEED_SLOWEST);

}
