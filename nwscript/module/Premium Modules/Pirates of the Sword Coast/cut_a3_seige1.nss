//::///////////////////////////////////////////////
//:: cut_a3_seige1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Start the Cutscene with the Crew fighting the
    sahaugin seige.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "x0_i0_henchman"
#include "_inc_cutscene"
#include "inc_undead"

const string STRING = "PLACEHOLDER.PLACEHOLDER.PLACEHOLDER.";

void main()
{
    string sNPCTag;
    effect eGhost = EffectCutsceneGhost();

    object oArea = OBJECT_SELF;
    object oModule = GetModule();

    object oNisarReal = GetObjectByTag("a2_hench_nisar");
    object oGarmReal = GetObjectByTag("a1_hench_garm");

    // JE: need to make the real Nisar and Garm invisible - they have been
    // removed from the party, which is why we have to do it manually this time.
    cs_ApplyVFXToObject(1.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oNisarReal);
    cs_ApplyVFXToObject(1.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oGarmReal);

    object oNisar = CopyObject(oNisarReal, GetLocation(oNisarReal), OBJECT_INVALID, "A3_SGCUT_NISAR");
    ApplyVFXEyes (oNisar);
    object oGarm = CopyObject(oGarmReal, GetLocation(oGarmReal), OBJECT_INVALID, "A3_SGCUT_GARM");
    ApplyVFXEyes (oGarm);

    FireHenchman(GetMaster(oNisar), oNisar);
    FireHenchman(GetMaster(oGarm), oGarm);
    AssignCommand(oNisar, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oGarm, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oNisar, ChangeToStandardFaction(oNisar, STANDARD_FACTION_COMMONER));
    AssignCommand(oGarm, ChangeToStandardFaction(oGarm, STANDARD_FACTION_COMMONER));
    DelayCommand(0.7f, AssignCommand(oNisar, ClearAllActions(TRUE)));
    DelayCommand(0.7f, AssignCommand(oGarm, ClearAllActions(TRUE)));

    object oWPNisar1 = GetObjectByTag("A3_SEIGESPWN_NISAR1");
    object oWPGarm1 = GetObjectByTag("A3_SEIGESPWN_GARM1");

    object oWPPlayer1_1 = GetObjectByTag("A3_SEIGESTART1");
    object oWPPlayer2_1 = GetObjectByTag("A3_SEIGESTART2");
    object oWPPlayer3_1 = GetObjectByTag("A3_SEIGESTART3");
    object oWPPlayer4_1 = GetObjectByTag("A3_SEIGESTART4");

    object oPCCopy1 = cs_CopyPC(GetLocation(oWPPlayer1_1), FALSE, 0);
    object oPCCopy2 = cs_CopyPC(GetLocation(oWPPlayer2_1), FALSE, 1);
    object oPCCopy3 = cs_CopyPC(GetLocation(oWPPlayer3_1), FALSE, 2);
    object oPCCopy4 = cs_CopyPC(GetLocation(oWPPlayer4_1), FALSE, 3);
    ApplyVFXEyes (oPCCopy1);
    ApplyVFXEyes (oPCCopy2);
    ApplyVFXEyes (oPCCopy3);
    ApplyVFXEyes (oPCCopy4);

    SetLocalObject(oArea, "a3_oPCCopy1", oPCCopy1);
    SetLocalObject(oArea, "a3_oPCCopy2", oPCCopy2);
    SetLocalObject(oArea, "a3_oPCCopy3", oPCCopy3);
    SetLocalObject(oArea, "a3_oPCCopy4", oPCCopy4);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oNisar, 5.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oGarm, 5.0f);

    //Start scene from black
    cs_CameraDoFade(0.0f, CS_FADE_TYPE_BLACK);
    cs_CameraUseCameraWaypoint(0.5, 1);
    cs_CameraDoFade(1.0f, CS_FADE_TYPE_FROM_BLACK);

    //players run on camera
    cs_ActionMoveToLocation(0.0f, oPCCopy1, GetLocation(oWPPlayer1_1), TRUE);
    cs_ActionMoveToLocation(0.0f, oPCCopy2, GetLocation(oWPPlayer2_1), TRUE);
    cs_ActionMoveToLocation(0.0f, oPCCopy3, GetLocation(oWPPlayer3_1), TRUE);
    cs_ActionMoveToLocation(0.0f, oPCCopy4, GetLocation(oWPPlayer4_1), TRUE);

    //cs_CameraSetFacing(1.5f, 270.0f, 16.0f, 67.0f, CAMERA_TRANSITION_TYPE_SLOW);

    cs_ActionMoveToLocation(2.0f, oNisar, GetLocation(oWPNisar1), TRUE);
    cs_ActionMoveToLocation(2.5f, oGarm, GetLocation(oWPGarm1), TRUE);

    cs_MusicBattlePlay(4.0f);
    cs_ActionStartConversation(4.0f, oNisar, cs_GetPCObject(), "a3_henchseige");
}

