//::///////////////////////////////////////////////
//:: cut_a3_seige2
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Walk player to ladder and start conversation.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

#include "_inc_cutscene"

const string sCrewString = "We'll take the battle topside, Captain!";
const string sGarmString1 = "Tonight we feassst on the minionsss of the warmblood goddesss!";
const string sNisarString1 = "Aye, for the Rose's honor, Cap'n!";

void main()
{
    string sNPCTag;
    effect eGhost = EffectCutsceneGhost();
    effect eDisapear = EffectDisappear();

    object oArea = OBJECT_SELF;
    object oModule = GetModule();

    object oNisar = GetObjectByTag("A3_SGCUT_NISAR");
    object oGarm = GetObjectByTag("A3_SGCUT_GARM");
    object oLadder = GetObjectByTag("a3_convobject");

    object oWPNisar2 = GetObjectByTag("A3_SEIGESPWN_NISAR2");
    object oWPNisar3 = GetObjectByTag("A3_SEIGESPWN_NISAR3");

    object oWPGarm2 = GetObjectByTag("A3_SEIGESPWN_GARM2");
    object oWPGarm3 = GetObjectByTag("A3_SEIGESPWN_GARM3");

    object oWPPlayer1_1 = GetObjectByTag("A3_SEIGE_PC1_1");

    object oWPPlayer1_2 = GetObjectByTag("A3_SEIGE_PC1_2");
    object oWPPlayer2_2 = GetObjectByTag("A3_SEIGE_PC2_2");
    object oWPPlayer3_2 = GetObjectByTag("A3_SEIGE_PC3_2");
    object oWPPlayer4_2 = GetObjectByTag("A3_SEIGE_PC4_2");

    object oWPPlayer1_3 = GetObjectByTag("A3_SEIGE_PC1_3");
    object oWPPlayer2_3 = GetObjectByTag("A3_SEIGE_PC2_3");
    object oWPPlayer3_3 = GetObjectByTag("A3_SEIGE_PC3_3");
    object oWPPlayer4_3 = GetObjectByTag("A3_SEIGE_PC4_3");

    object oWPPause = GetObjectByTag("A3_SEIGEPAUSE");
    object oWPLeave = GetObjectByTag("A3_SEIGELEAVE");
    object oWPCamera = GetObjectByTag("A3_SEIGE_PC1_1");

    sNPCTag = GetLocalString(oModule, "NPC_CREW_DEAD1");
    object oNPC1 = GetObjectByTag(sNPCTag);
    sNPCTag = GetLocalString(oModule, "NPC_CREW_DEAD2");
    object oNPC2 = GetObjectByTag(sNPCTag);
    sNPCTag = GetLocalString(oModule, "NPC_CREW_DEAD3");
    object oNPC3 = GetObjectByTag(sNPCTag);
    sNPCTag = GetLocalString(oModule, "NPC_CREW_DEAD4");
    object oNPC4 = GetObjectByTag(sNPCTag);
    sNPCTag = GetLocalString(oModule, "NPC_CREW_DEAD5");
    object oNPC5 = GetObjectByTag(sNPCTag);

    object oPCCopy1 = GetLocalObject(oArea, "a3_oPCCopy1");
    object oPCCopy2 = GetLocalObject(oArea, "a3_oPCCopy2");
    object oPCCopy3 = GetLocalObject(oArea, "a3_oPCCopy3");
    object oPCCopy4 = GetLocalObject(oArea, "a3_oPCCopy4");

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oNisar, 30.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oGarm, 30.0f);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oPCCopy1, 30.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oPCCopy2, 30.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oPCCopy3, 30.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oPCCopy4, 30.0f);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oNPC1, 30.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oNPC2, 30.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oNPC3, 30.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oNPC4, 30.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oNPC5, 30.0f);

    AssignCommand(oNPC1, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oNPC2, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oNPC3, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oNPC4, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oNPC5, SetIsDestroyable(TRUE, FALSE, FALSE));

    //players run on camera
    cs_CameraSetFacing(0.0f, 230.0f,10.0f, 55.0f, CAMERA_TRANSITION_TYPE_SLOW);
    cs_CameraActionMoveToObject(1.0f, oWPCamera);

    cs_ActionMoveToLocation(1.0f, oNPC1, GetLocation(oWPPause), TRUE);
    cs_ActionMoveToLocation(1.0f, oPCCopy1, GetLocation(oWPPlayer1_1), TRUE);
    cs_ActionSetFacingPoint(3.5f, oNPC1, GetPosition(oWPPlayer1_1));

    cs_CameraUseCameraWaypoint(3.0f, 2);

    cs_ActionMoveToLocation(4.0f, oNPC2, GetLocation(oWPLeave), TRUE);
    cs_ActionMoveToLocation(4.0f, oNPC3, GetLocation(oWPLeave), TRUE);
    cs_ActionMoveToLocation(4.0f, oNPC4, GetLocation(oWPLeave), TRUE);
    cs_ActionMoveToLocation(4.0f, oNPC5, GetLocation(oWPLeave), TRUE);

    cs_ActionSpeakString(6.0f, oNPC1, sCrewString);
    cs_ActionMoveToLocation(9.0f, oNPC1, GetLocation(oWPLeave), TRUE);

    cs_ActionMoveToLocation(9.0f, oPCCopy1, GetLocation(oWPPlayer1_2), TRUE);
    cs_ActionSetFacingPoint(9.1f, oPCCopy1, GetPosition(oWPLeave));

    cs_ActionMoveToLocation(10.0f, oNisar, GetLocation(oWPNisar2), TRUE);
    cs_ActionSetFacingPoint(10.1f, oNisar, GetPosition(oWPLeave));
    cs_ActionMoveToLocation(10.0f, oGarm, GetLocation(oWPGarm2), TRUE);
    cs_ActionSetFacingPoint(10.1f, oGarm, GetPosition(oWPLeave));

    cs_ActionMoveToLocation(11.0f, oPCCopy2, GetLocation(oWPPlayer2_2), TRUE);
    cs_ActionSetFacingPoint(11.1f, oPCCopy2, GetPosition(oWPLeave));
    cs_ActionMoveToLocation(11.0f, oPCCopy3, GetLocation(oWPPlayer3_2), TRUE);
    cs_ActionSetFacingPoint(11.1f, oPCCopy3, GetPosition(oWPLeave));
    cs_ActionMoveToLocation(11.0f, oPCCopy4, GetLocation(oWPPlayer4_2), TRUE);
    cs_ActionSetFacingPoint(11.1f, oPCCopy4, GetPosition(oWPLeave));

    cs_ApplyEffectToObject(10.0f, DURATION_TYPE_PERMANENT, eDisapear, oNPC2);
    cs_ApplyEffectToObject(10.5f, DURATION_TYPE_PERMANENT, eDisapear, oNPC3);
    cs_ApplyEffectToObject(11.0f, DURATION_TYPE_PERMANENT, eDisapear, oNPC4);
    cs_ApplyEffectToObject(11.5f, DURATION_TYPE_PERMANENT, eDisapear, oNPC5);
    cs_ApplyEffectToObject(12.0f, DURATION_TYPE_PERMANENT, eDisapear, oNPC1);

    cs_ActionSpeakString(13.0f, oGarm, sGarmString1);
    cs_PlayAnimation(13.2f, oGarm, ANIMATION_FIREFORGET_VICTORY2);
    cs_ActionSpeakString(16.0f, oNisar, sNisarString1);
    cs_PlayAnimation(16.2f, oNisar, ANIMATION_FIREFORGET_VICTORY1);

    cs_CameraDoFade(19.0f, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);

    cs_CameraUseCameraWaypoint(21.0f, 3);

    cs_ActionMoveToLocation(21.0f, oNisar, GetLocation(oWPNisar3), TRUE);
    cs_ActionMoveToLocation(21.0f, oGarm, GetLocation(oWPGarm3), TRUE);

    cs_ActionMoveToLocation(21.0f, oPCCopy1, GetLocation(oWPPlayer1_3), TRUE);
    cs_ActionMoveToLocation(21.0f, oPCCopy2, GetLocation(oWPPlayer2_3), TRUE);
    cs_ActionMoveToLocation(21.0f, oPCCopy3, GetLocation(oWPPlayer3_3), TRUE);
    cs_ActionMoveToLocation(21.0f, oPCCopy4, GetLocation(oWPPlayer4_3), TRUE);

    cs_CameraDoFade(22.0f, CS_FADE_TYPE_NONE);

    DelayCommand(24.0f, ExecuteScript("cut_a3_seige3", oArea));
}

