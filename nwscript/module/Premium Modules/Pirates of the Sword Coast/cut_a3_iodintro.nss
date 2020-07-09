//::///////////////////////////////////////////////
//:: cut_a3_iodintro
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player and crew sail to the Island of
    the Dead under Kolmarrs direction.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "x0_i0_henchman"
#include "inc_global"

// oVO1: "As the Skull and Bones set sail from Spindrift Town,"
// oVO2: "Master Kolmarr began to whisper tales"
// oVO3: "o' a nearby island an' a mighty artifact"
// oVO4: "that would aid the chase o' the Midnight Rose."
// oVO5: "As the mists drew close around her hull,"
// oVO6: "he changed her course,"
// oVO7: "an' set his sights upon the Isle o' the Dead..."
const float f_VO_LENGTH_1 = 4.09; // pp1_allendry036
const float f_VO_LENGTH_2 = 3.9; // pp1_allendry037
const float f_VO_LENGTH_3 = 4.1;  // pp1_allendry038
const float f_VO_LENGTH_4 = 4.36; // pp1_allendry039
const float f_VO_LENGTH_5 = 3.15; // pp1_allendry040
const float f_VO_LENGTH_6 = 2.01; // pp1_allendry041
const float f_VO_LENGTH_7 = 4.4;  // pp1_allendry042

void main()
{
    //Sound
    object oVO1 = GetObjectByTagInArea("pp1_allendry036");
    object oVO2 = GetObjectByTagInArea("pp1_allendry037");
    object oVO3 = GetObjectByTagInArea("pp1_allendry038");
    object oVO4 = GetObjectByTagInArea("pp1_allendry039");
    object oVO5 = GetObjectByTagInArea("pp1_allendry040");
    object oVO6 = GetObjectByTagInArea("pp1_allendry041");
    object oVO7 = GetObjectByTagInArea("pp1_allendry042");


    effect eGhost = EffectCutsceneGhost();

    object oArea = OBJECT_SELF;
    object oModule = GetModule();

    object oSpectre = GetObjectByTag("a3_iodi_spectre");
    object oKolmarr = GetObjectByTag("a3_iodi_kolmarr");
    object oNisarReal = GetObjectByTag("a2_hench_nisar");
    object oGarmReal = GetObjectByTag("a1_hench_garm");

    object oWPSpectre = GetObjectByTag("A3_IODI_SPECTRE");
    object oWPNisar1 = GetObjectByTag("A3_IODI_NISAR1");
    object oWPGarm1 = GetObjectByTag("A3_IODI_GARM1");

    object oNisar = CopyObject(oNisarReal, GetLocation(oWPNisar1), OBJECT_INVALID, "A3_IODI_CUTNISAR");
    object oGarm = CopyObject(oGarmReal, GetLocation(oWPGarm1), OBJECT_INVALID, "A3_IODI_CUTGARM");

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oNisar);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oGarm);

    FireHenchman(GetMaster(oNisar), oNisar);
    FireHenchman(GetMaster(oGarm), oGarm);
    AssignCommand(oNisar, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oGarm, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oNisar,ChangeToStandardFaction(oNisar,STANDARD_FACTION_COMMONER));
    AssignCommand(oGarm,ChangeToStandardFaction(oGarm,STANDARD_FACTION_COMMONER));
    AssignCommand(oNisar, ClearAllActions(TRUE));
    AssignCommand(oGarm, ClearAllActions(TRUE));

    object oWPPlayer1 = GetObjectByTag("A3_IODI_PCCOPY1");
    object oWPPlayer2 = GetObjectByTag("A3_IODI_PCCOPY2");
    object oWPPlayer3 = GetObjectByTag("A3_IODI_PCCOPY3");
    object oWPPlayer4 = GetObjectByTag("A3_IODI_PCCOPY4");

    object oWPCrew1 = GetObjectByTag("A3_IODI_FOLLOWER1");
    object oWPCrew2 = GetObjectByTag("A3_IODI_FOLLOWER2");
    object oWPCrew3 = GetObjectByTag("A3_IODI_FOLLOWER3");
    object oWPCrew4 = GetObjectByTag("A3_IODI_FOLLOWER4");
    object oWPCrew5 = GetObjectByTag("A3_IODI_FOLLOWER5");

    object oPCCopy1 = cs_CopyPC(GetLocation(oWPPlayer1), FALSE, 0);
    object oPCCopy2 = cs_CopyPC(GetLocation(oWPPlayer2), FALSE, 1);
    object oPCCopy3 = cs_CopyPC(GetLocation(oWPPlayer3), FALSE, 2);
    object oPCCopy4 = cs_CopyPC(GetLocation(oWPPlayer4), FALSE, 3);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy4);

    string sNPCTag;
    sNPCTag = GetLocalString(oModule, "NPC_CREW1");
    object oCrew1 = CreateObject(OBJECT_TYPE_CREATURE, sNPCTag, GetLocation(oWPCrew1));
    sNPCTag = GetLocalString(oModule, "NPC_CREW2");
    object oCrew2 = CreateObject(OBJECT_TYPE_CREATURE, sNPCTag, GetLocation(oWPCrew2));
    sNPCTag = GetLocalString(oModule, "NPC_CREW3");
    object oCrew3 = CreateObject(OBJECT_TYPE_CREATURE, sNPCTag, GetLocation(oWPCrew3));
    sNPCTag = GetLocalString(oModule, "NPC_CREW4");
    object oCrew4 = CreateObject(OBJECT_TYPE_CREATURE, sNPCTag, GetLocation(oWPCrew4));
    sNPCTag = GetLocalString(oModule, "NPC_CREW5");
    object oCrew5 = CreateObject(OBJECT_TYPE_CREATURE, sNPCTag, GetLocation(oWPCrew5));

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oCrew1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oCrew2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oCrew3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oCrew4);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oCrew5);

    object oWayPoint0 = GetObjectByTagInArea("cs_camera_pos_1");
    object oWayPoint1 = GetObjectByTagInArea("cs_camera_pos_2");
    object oWayPoint2 = GetObjectByTagInArea("cs_camera_pos_3");

    float fDelay;
//------------------------------------------------------------------------------

    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    cs_SoundObjectPlay(5.0, oVO1);
    cs_SoundObjectPlay(f_VO_LENGTH_1, oVO2);
    cs_SoundObjectPlay(f_VO_LENGTH_2, oVO3);
    cs_SoundObjectPlay(f_VO_LENGTH_3, oVO4);

    cs_ResetDelay();

    cs_ActionPlayAnimation(0.0f, oNisar, ANIMATION_LOOPING_LOOK_FAR, 0.8f, 52.0f);
    cs_ActionPlayAnimation(0.0f, oGarm, ANIMATION_LOOPING_TALK_NORMAL, 0.8f, 52.0f);

    cs_ActionPlayAnimation_SafeForCrew(0.0f, oCrew1, ANIMATION_LOOPING_SIT_CROSS, 0.8f, 52.0f);
    cs_ActionPlayAnimation_SafeForCrew(0.0f, oCrew2, ANIMATION_LOOPING_LISTEN, 0.8f, 52.0f);
    cs_ActionPlayAnimation_SafeForCrew(0.0f, oCrew3, ANIMATION_LOOPING_GET_LOW, 0.9f, 52.0f);
    cs_ActionPlayAnimation_SafeForCrew(0.0f, oCrew4, ANIMATION_LOOPING_TALK_NORMAL, 1.2f, 52.0f);
    cs_ActionPlayAnimation_SafeForCrew(0.0f, oCrew5, ANIMATION_LOOPING_LOOK_FAR, 0.7f, 52.0f);

    cs_ActionPlayAnimation(0.0f, oKolmarr, ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 17.0f);

    cs_CameraUseCameraWaypoint(0.5f, 1);
    cs_CameraSetMovementRate(0.0, 0.3f);
    cs_CameraActionMoveToObject(1.5, oWayPoint1, TRUE);
    cs_CameraDoFade(0.0, CS_FADE_TYPE_FROM_BLACK, 0.01f);
    cs_CameraSetFacing(0.0, 70.0f, 18.0f, 70.0f, CAMERA_TRANSITION_TYPE_SLOW);

    cs_ActionPlayAnimation(14.5, oKolmarr, ANIMATION_LOOPING_TALK_FORCEFUL, 1.0f, 17.0f);

    //pan to island


    cs_CameraSetMovementRate(2.0, 0.55f);
    //cs_CameraSetFacing(1.0, 330.0f, 25.0f, 80.0f, CAMERA_TRANSITION_TYPE_VERY_SLOW);
    cs_CameraSetFacing(1.0, GetFacing(oWayPoint2), 25.0f, 83.0f, 8);
    cs_CameraActionMoveToObject(0.1, oWayPoint2, TRUE);

    cs_SoundObjectPlay(5.0, oVO5);
    cs_SoundObjectPlay(f_VO_LENGTH_5, oVO6);
    cs_SoundObjectPlay(f_VO_LENGTH_6, oVO7);

    cs_ActionMoveToObject(f_VO_LENGTH_7/2, oSpectre, oWPSpectre);


    cs_CameraDoFade(f_VO_LENGTH_7/2 + 2.0, CS_FADE_TYPE_TO_BLACK, 0.01f);

    cs_DestroyObject(1.0f, oNisar);
    cs_DestroyObject(0.0f, oGarm);
    cs_DestroyObject(0.0f, oPCCopy1);
    cs_DestroyObject(0.0f, oPCCopy2);
    cs_DestroyObject(0.0f, oPCCopy3);
    cs_DestroyObject(0.0f, oPCCopy4);
    cs_SoundObjectStop(0.0, oVO1);
    cs_SoundObjectStop(0.0, oVO2);
    cs_SoundObjectStop(0.0, oVO3);
    cs_SoundObjectStop(0.0, oVO4);
    cs_SoundObjectStop(0.0, oVO5);
    cs_SoundObjectStop(0.0, oVO6);
    cs_SoundObjectStop(0.0, oVO7);

    cs_EndCutscene(2.0f, TRUE, TRUE, FADE_SPEED_MEDIUM);
}
