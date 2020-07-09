//::///////////////////////////////////////////////
//:: cut_a2_tas1
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Act 2 cutscene where player meets Tasina
    as she's about to leave.

    This cutscene should NOT be abortable, due
    to the conversation at the end which needs
    to be a part of the cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 17/05
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    int nPriestessCount = GetLocalInt(OBJECT_SELF, l_n_A2_TEMPLE_PRIESTESS_COUNT);
    int nSahClericCount = GetLocalInt(OBJECT_SELF, l_n_A2_TEMPLE_SAHCLERIC_COUNT);
    int nSahGuardCount = GetLocalInt(OBJECT_SELF, l_n_A2_TEMPLE_SAHGUARD_COUNT);
    int nIndex = 0;

    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    // waypoints
    object oWP_Portal = GetWaypointByTag(a2w_BeneathTemple_Portal);

    object oWP_PC1_1 = GetObjectByTagInArea("cs_wp_pc1_1");
    object oWP_PC2_1 = GetObjectByTagInArea("cs_wp_pc2_1");
    object oWP_PC3_1 = GetObjectByTagInArea("cs_wp_pc3_1");
    object oWP_PC4_1 = GetObjectByTagInArea("cs_wp_pc4_1");
    object oWP_PC1_2 = GetObjectByTagInArea("cs_wp_pc1_2");
    object oWP_PC2_2 = GetObjectByTagInArea("cs_wp_pc2_2");
    object oWP_PC3_2 = GetObjectByTagInArea("cs_wp_pc3_2");
    object oWP_PC4_2 = GetObjectByTagInArea("cs_wp_pc4_2");
    object oWP_PC1_3 = GetObjectByTagInArea("cs_wp_pc1_3");
    object oWP_PC2_3 = GetObjectByTagInArea("cs_wp_pc2_3");
    object oWP_PC3_3 = GetObjectByTagInArea("cs_wp_pc3_3");
    object oWP_PC4_3 = GetObjectByTagInArea("cs_wp_pc4_3");

    object oWP_Garm_1 = GetObjectByTagInArea("cs_wp_garm_1");
    object oWP_Garm_2 = GetObjectByTagInArea("cs_wp_garm_2");
    object oWP_Garm_3 = GetObjectByTagInArea("cs_wp_garm_3");
    object oWP_Nisar_1 = GetObjectByTagInArea("cs_wp_nisar_1");
    object oWP_Nisar_2 = GetObjectByTagInArea("cs_wp_nisar_2");
    object oWP_Nisar_3 = GetObjectByTagInArea("cs_wp_nisar_3");

    object oWP_Tasina_1 = GetObjectByTagInArea("cs_wp_tasina_1");

    // creatures
    object oTasina = GetObjectByTagInArea(a2c_tag_Tasina);

    // other objects
    object oDoor = GetObjectByTagInArea("a2_door_cut_tasina");

    effect eCutGhost = EffectCutsceneGhost();
    object oPC1 = cs_CopyPC(GetLocation(oWP_PC1_1), FALSE, 0);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC1);
    object oPC2 = cs_CopyPC(GetLocation(oWP_PC2_1), FALSE, 1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC2);
    object oPC3 = cs_CopyPC(GetLocation(oWP_PC3_1), FALSE, 2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC3);
    object oPC4 = cs_CopyPC(GetLocation(oWP_PC4_1), FALSE, 3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC4);

    object oGarm = CopyObject(GetObjectByTagInArea(a1c_tag_Garm), GetLocation(oWP_Garm_1), OBJECT_INVALID, "garm_copy");
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oGarm);
    object oNisar = CopyObject(GetObjectByTagInArea(a2c_tag_Nisar), GetLocation(oWP_Nisar_1), OBJECT_INVALID, "nisar_copy");
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oNisar);

    AssignCommand(oNisar, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oGarm, SetIsDestroyable(TRUE, FALSE, FALSE));

    AssignCommand(oNisar, ChangeToStandardFaction(oNisar,STANDARD_FACTION_COMMONER));
    AssignCommand(oGarm, ChangeToStandardFaction(oGarm,STANDARD_FACTION_COMMONER));

//------------------------------------------------------------------------------

    // set up initial positions
    cs_PlayAnimation(0.0, oTasina, ANIMATION_LOOPING_MEDITATE, 1.0, 60.0);
    cs_CameraUseCameraWaypoint(0.4, 2, TRUE);
    //cs_ActionCloseDoor(0.1, oDoor, oDoor);

    // fade-in
    cs_CameraDoFade(1.8, CS_FADE_TYPE_FROM_BLACK);

    // door opens, players/henchmen walk in
    cs_ActionOpenDoor(1.2, oDoor, oDoor);
    cs_ActionMoveToObject(0.1, oPC1, oWP_PC1_2, FALSE, 0.0);
    cs_ActionMoveToObject(0.0, oPC2, oWP_PC2_2, FALSE, 0.0);
    cs_ActionMoveToObject(0.0, oPC3, oWP_PC3_2, FALSE, 0.0);
    cs_ActionMoveToObject(0.0, oPC4, oWP_PC4_2, FALSE, 0.0);
    cs_ActionMoveToObject(0.0, oGarm, oWP_Garm_2, FALSE, 0.0);
    cs_ActionMoveToObject(0.0, oNisar, oWP_Nisar_2, FALSE, 0.0);

    // tasina stands up, turns head, turns around
    cs_ClearAllActions(1.4, oTasina);
    cs_PlayAnimation(0.1, oTasina, ANIMATION_FIREFORGET_HEAD_TURN_LEFT);
    cs_SetFacingPoint(0.15, oTasina, GetPosition(oWP_PC1_2));

    // tasina walks towards player
    // she moves a bit too slow, so I'll speed her up slightly
    // NOTE: I'm marking bDestroyOnCSEnd, which means ALL effects on Tasina are
    // going to be removed on cutscene end.
    effect eSpeedUp = EffectMovementSpeedIncrease(50);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eSpeedUp, oTasina, 0.0, TRUE);
    cs_ActionMoveToObject(1.0, oTasina, oWP_Tasina_1, FALSE, 0.0);

    // focus on players, who are just inside the door
    cs_CameraUseCameraWaypoint(2.3, 5);

    // players keep moving towards tasina
    cs_ActionMoveToObject(0.0, oPC1, oWP_PC1_3, FALSE, 0.0);
    cs_ActionMoveToObject(0.05, oGarm, oWP_Garm_3, FALSE, 0.0);
    cs_ActionMoveToObject(0.02, oNisar, oWP_Nisar_3, FALSE, 0.0);
    cs_ActionMoveToObject(0.01, oPC2, oWP_PC2_3, FALSE, 0.0);
    cs_ActionMoveToObject(0.03, oPC3, oWP_PC3_3, FALSE, 0.0);
    cs_ActionMoveToObject(0.04, oPC4, oWP_PC4_3, FALSE, 0.0);



    cs_CameraUseCameraWaypoint(2.5, 3);
    cs_CameraUseCameraWaypoint(0.3, 4);

    cs_ActionStartConversation(4.0, oTasina, cs_GetPCObject());

    // this cutscene is ended in Tasina's conversation
}
