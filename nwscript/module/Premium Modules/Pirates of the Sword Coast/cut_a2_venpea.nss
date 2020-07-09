//::///////////////////////////////////////////////
//:: PC encounters either Vengaul or Honeypea
//:: cut_a2_venpea.nss
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Mar 7/05
//:://////////////////////////////////////////////
#include "_inc_cutscene"

void main()
{
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    //waypoints
    //object oWP_PC1_1 = GetObjectByTagInArea("cs_wp_bandit_pc1_1");
    object oWP_PC2_1 = GetObjectByTagInArea("cs_wp_bandit_pc2_1");
    object oWP_PC3_1 = GetObjectByTagInArea("cs_wp_bandit_pc3_1");
    object oWP_PC4_1 = GetObjectByTagInArea("cs_wp_bandit_pc4_1");
    //object oWP_PC1_2 = GetObjectByTagInArea("cs_wp_bandit_pc1_2");
    object oWP_PC2_2 = GetObjectByTagInArea("cs_wp_bandit_pc2_2");
    object oWP_PC3_2 = GetObjectByTagInArea("cs_wp_bandit_pc3_2");
    object oWP_PC4_2 = GetObjectByTagInArea("cs_wp_bandit_pc4_2");

    object oWP_BanditFacing = GetObjectByTagInArea("cs_camera_pos_12");

    //creatures
    //object oPCCopy1 = cs_CopyPC(GetLocation(oWP_PC1_1), FALSE, 0);
    object oPCCopy2 = cs_CopyPC(GetLocation(oWP_PC2_1), FALSE, 1);
    object oPCCopy3 = cs_CopyPC(GetLocation(oWP_PC3_1), FALSE, 2);
    object oPCCopy4 = cs_CopyPC(GetLocation(oWP_PC4_1), FALSE, 3);

    object oBandit = GetLocalObject(OBJECT_SELF, "NPC_BANDIT"); // OBJECT_SELF = current area

    cs_RenderPCVisible(0.1);
    cs_CameraUseCameraWaypoint(0.0, 11);

    // camera fades in
    cs_CameraDoFade(0.1, CS_FADE_TYPE_FROM_BLACK);
    cs_CameraUseCameraWaypoint(0.0, 12);

    // pc party is walking towards dude
    //cs_ActionMoveToObject(0.0, oPCCopy1, oWP_PC1_2);
    cs_ActionMoveToObject(0.0, oPCCopy2, oWP_PC2_2);
    cs_ActionMoveToObject(0.0, oPCCopy3, oWP_PC3_2);
    cs_ActionMoveToObject(0.0, oPCCopy4, oWP_PC4_2);

    // dude turns to party
    cs_SetFacingPoint(0.5, oBandit, GetPosition(oWP_BanditFacing));
    // and waves
    cs_PlayAnimation(0.2, oBandit, ANIMATION_FIREFORGET_GREETING);
    // and walks towards pc1
    cs_ActionMoveToObject(0.2, oBandit, oWP_BanditFacing);

    cs_EndCutscene(2.0);
}
