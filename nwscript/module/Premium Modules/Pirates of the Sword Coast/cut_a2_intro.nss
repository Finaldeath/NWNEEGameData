//::///////////////////////////////////////////////
//:: Act 2 intro cutscene (part 1)
//:: cut_a2_intro.nss
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Mar 7/05
//:://////////////////////////////////////////////
#include "inc_global"

// oVO1: "There be something 'bout a ship that sings o' freedom"
// oVO2: "an', as the currents swept the tiny raft into the sunset,"
// oVO3: "a beacon shone out across the darkened sea,"
// oVO4: "a lighthouse, calling all her grateful sailors home..."
const float f_VO_LENGTH_1 = 3.94; // pp1_allendry029
const float f_VO_LENGTH_2 = 4.54; // pp1_allendry030
const float f_VO_LENGTH_3 = 3.72; // pp1_allendry031
const float f_VO_LENGTH_4 = 5.42; // pp1_allendry032

void main()
{
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    //waypoints
    object oWP_PC1_Start = GetObjectByTagInArea("cs_wp_intro_pc1");
    object oWP_PC1_Beach = GetObjectByTagInArea("cs_wp_intro_onbeach");
    object oWP_PC2_Start = GetObjectByTagInArea("cs_wp_intro_pc2");
    object oWP_PC2_Beach = GetObjectByTagInArea("cs_wp_intro_onbeach2");
    object oWP_PC3_Start = GetObjectByTagInArea("cs_wp_intro_pc3");
    object oWP_PC3_Beach = GetObjectByTagInArea("cs_wp_intro_onbeach3");
    object oWP_PC4_Start = GetObjectByTagInArea("cs_wp_intro_pc4");
    object oWP_PC4_Beach = GetObjectByTagInArea("cs_wp_intro_onbeach4");

    object oWP_Vantabular_1 = GetObjectByTagInArea("cs_wp_intro_vant1");
    object oWP_Vantabular_2 = GetObjectByTagInArea("cs_wp_intro_vant2");

    object oWP_Garm_1 = GetObjectByTagInArea("cs_wp_intro_garm1");
    object oWP_Garm_2 = GetObjectByTagInArea("cs_wp_intro_garm2");

    //Sound
    object oSoundRaftBreak = GetObjectByTagInArea("a2_snd_raftbreaking");
    object oVO1 = GetObjectByTagInArea("pp1_allendry029");
    object oVO2 = GetObjectByTagInArea("pp1_allendry030");
    object oVO3 = GetObjectByTagInArea("pp1_allendry031");
    object oVO4 = GetObjectByTagInArea("pp1_allendry032");

    object oAreaSound1 = GetObjectByTagInArea("SeagullCries");
    object oAreaSound2 = GetObjectByTagInArea("SeaSurfLarge");

    //creatures
    effect eCutGhost = EffectCutsceneGhost();

    object oVantabular = GetObjectByTagInArea("a2_vantabular");

    object oGarm = CreateObject(OBJECT_TYPE_CREATURE, "a1_cutgarm", GetLocation(oWP_Garm_1));
    AssignCommand(oGarm, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oGarm);

    location lLoc1 = GetLocation(oWP_PC1_Start);
    location lLoc2 = GetLocation(oWP_PC2_Start);
    location lLoc3 = GetLocation(oWP_PC3_Start);
    location lLoc4 = GetLocation(oWP_PC4_Start);
    object oPC1Copy = cs_CopyPC(lLoc1, FALSE, 0);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC1Copy);
    object oPC2Copy = cs_CopyPC(lLoc2, FALSE, 1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC2Copy);
    object oPC3Copy = cs_CopyPC(lLoc3, FALSE, 2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC3Copy);
    object oPC4Copy = cs_CopyPC(lLoc4, FALSE, 3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC4Copy);

    object oRaft = GetObjectByTagInArea("a2_cutraft");


/*---------------------------------------------------------------------------*/
    cs_SoundObjectStop(0.0, oAreaSound1);
    cs_SoundObjectStop(0.0, oAreaSound2);

    // this is a hack to get the vfx at the top of the lighthouse to start
    // displaying, so that it shows up properly when the cutscene pans to it
    cs_CameraUseCameraWaypoint(0.2, 2);

    cs_CameraUseCameraWaypoint(2.4, 1);

    cs_PlayAnimation(0.0, oPC1Copy, ANIMATION_LOOPING_SIT_CROSS, 1.0, 60.0);
    cs_PlayAnimation(0.0, oPC2Copy, ANIMATION_LOOPING_SIT_CROSS, 1.0, 60.0);
    cs_PlayAnimation(0.0, oPC3Copy, ANIMATION_LOOPING_SIT_CROSS, 1.0, 60.0);
    cs_PlayAnimation(0.0, oPC4Copy, ANIMATION_LOOPING_SIT_CROSS, 1.0, 60.0);
    cs_PlayAnimation(0.0, oGarm, ANIMATION_LOOPING_SIT_CROSS, 1.0, 60.0);

    cs_CameraDoFade(0.5, CS_FADE_TYPE_FROM_BLACK);
    cs_CameraUseCameraWaypoint(0.0, 3);

    cs_SoundObjectPlay(1.0, oVO1);
    //cs_SpeakString(0.0, oPC1Copy, "TEMP narration: There be something 'bout a ship that sings o' freedom");

    cs_SoundObjectPlay(f_VO_LENGTH_1, oVO2);
    //cs_SpeakString(0.0, oPC1Copy, "TEMP narration: an', as the currents swept the tiny raft into the sunset,");

    cs_CameraUseCameraWaypoint(f_VO_LENGTH_2/2, 4);

    cs_SoundObjectPlay(f_VO_LENGTH_2/2, oVO3);
    //cs_SpeakString(0.0, oPC1Copy, "TEMP narration: a beacon shone out across the darkened sea,");

    cs_SoundObjectPlay(f_VO_LENGTH_3, oVO4);
    //cs_SpeakString(0.0, oPC1Copy, "TEMP narration: a lighthouse, calling all her grateful sailors home...");

    cs_CameraDoFade(f_VO_LENGTH_4, CS_FADE_TYPE_TO_BLACK);

    // pc is on beach
    //cs_ActionJumpToObject(4.0, oPCCopy, oWP_PC_Beach);
    cs_CameraUseCameraWaypoint(1.5, 2);
    cs_RenderPCVisible(0.0);
    cs_DestroyObject(0.0, oRaft);
    cs_ClearAllActions(0.0, oPC2Copy);
    cs_ClearAllActions(0.0, oPC3Copy);
    cs_ClearAllActions(0.0, oPC4Copy);
    cs_ClearAllActions(0.0, oGarm);
    cs_ActionJumpToObject(0.1, oPC2Copy, oWP_PC2_Beach);
    cs_ActionJumpToObject(0.0, oPC3Copy, oWP_PC3_Beach);
    cs_ActionJumpToObject(0.0, oPC4Copy, oWP_PC4_Beach);
    cs_ActionJumpToObject(0.0, oGarm, oWP_Garm_2);

    // raft-breaking sound
    cs_SoundObjectPlay(0.1, oSoundRaftBreak, TRUE);

    // vantabular runs up to the player
    cs_ActionMoveToObject(0.3, oVantabular, oWP_Vantabular_1, TRUE);
    cs_ActionMoveToObject(0.1, oVantabular, oWP_Vantabular_2, TRUE);

    cs_CameraDoFade(0.7, CS_FADE_TYPE_FROM_BLACK);

    // end cutscene
    cs_SoundObjectStop(5.0, oVO1);
    cs_SoundObjectStop(0.0, oVO2);
    cs_SoundObjectStop(0.0, oVO3);
    cs_SoundObjectStop(0.0, oVO4);
    cs_SoundObjectStop(0.0, oSoundRaftBreak);
    cs_DestroyObject(0.0, oGarm);

    cs_SoundObjectPlay(0.1, oAreaSound1, TRUE);
    cs_SoundObjectPlay(0.0, oAreaSound2, TRUE);

    cs_EndCutscene(0.1);
}
