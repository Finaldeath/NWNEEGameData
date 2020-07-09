//::///////////////////////////////////////////////
//:: cut_a3_bridge
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Start the Cutscene with the umberlant
    guardian destroying the bridge to the temple.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "x0_i0_henchman"
#include "_inc_cutscene"
#include "inc_undead"

const string sNisar001 = "Aye, well that was easy enough. This must be the place.";
const string sGarm001 = "Too easssy. Garm prefersss a challenge...";
const string sNisar002 = "What in all the nine hells is that!?";
const string sGarm002 = "Laogzed protect usss!";
//const string sGarm003 = "Wait for Garm!";

void main()
{
    effect eGhost = EffectCutsceneGhost();
    effect eDamage = EffectDamage(1000);

    object oArea = OBJECT_SELF;
    object oModule = GetModule();

    object oRealNisar = GetObjectByTag("a2_hench_nisar");
    object oRealGarm = GetObjectByTag("a1_hench_garm");

    object oWPGuardian = GetObjectByTag("A3_BRDG_GUARDSPWN");

    object oWPNisar1 = GetObjectByTag("A3_BRDG_NISARSPWN");
    object oWPNisar2 = GetObjectByTag("A3_BRDG_NISAR01");
    object oWPNisar4 = GetObjectByTag("A3_BRDG_NISAR03");

    object oWPGarm1 = GetObjectByTag("A3_BRDG_GARMSPWN");
    object oWPGarm2 = GetObjectByTag("A3_BRDG_GARM01");
    object oWPGarm3 = GetObjectByTag("A3_BRDG_GARM02");
    object oWPGarm4 = GetObjectByTag("A3_BRDG_GARM03");

    object oNisar = CopyObject(oRealNisar, GetLocation(oWPNisar1));
    object oGarm = CopyObject(oRealGarm, GetLocation(oWPGarm1));

    ApplyVFXEyes(oNisar);
    ApplyVFXEyes(oGarm);

    AssignCommand(oNisar, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oGarm, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oNisar, ChangeToStandardFaction(oNisar, STANDARD_FACTION_COMMONER));
    AssignCommand(oGarm, ChangeToStandardFaction(oGarm, STANDARD_FACTION_COMMONER));
    FireHenchman(GetMaster(oNisar), oNisar);
    FireHenchman(GetMaster(oGarm), oGarm);
    DelayCommand(1.0f, AssignCommand(oNisar, ClearAllActions(TRUE)));
    DelayCommand(1.0f,AssignCommand(oGarm, ClearAllActions(TRUE)));

    object oSPWNPlayer1_1 = GetObjectByTag("A3_BRDG_PLAYERSPWN1");
    object oSPWNPlayer2_1 = GetObjectByTag("A3_BRDG_PLAYERSPWN2");
    object oSPWNPlayer3_1 = GetObjectByTag("A3_BRDG_PLAYERSPWN3");
    object oSPWNPlayer4_1 = GetObjectByTag("A3_BRDG_PLAYERSPWN4");

    object oWPPlayer1_1 = GetObjectByTag("A3_BRDG_PLAYER1_1");
    object oWPPlayer2_1 = GetObjectByTag("A3_BRDG_PLAYER2_1");
    object oWPPlayer3_1 = GetObjectByTag("A3_BRDG_PLAYER3_1");
    object oWPPlayer4_1 = GetObjectByTag("A3_BRDG_PLAYER4_1");

    object oWPPlayer1_2 = GetObjectByTag("A3_BRDG_PLAYER1_2");
    object oWPPlayer2_2 = GetObjectByTag("A3_BRDG_PLAYER2_2");
    object oWPPlayer3_2 = GetObjectByTag("A3_BRDG_PLAYER3_2");
    object oWPPlayer4_2 = GetObjectByTag("A3_BRDG_PLAYER4_2");

    object oPCCopy1 = cs_CopyPC(GetLocation(oSPWNPlayer1_1), FALSE, 0);
    object oPCCopy2 = cs_CopyPC(GetLocation(oSPWNPlayer2_1), FALSE, 1);
    object oPCCopy3 = cs_CopyPC(GetLocation(oSPWNPlayer3_1), FALSE, 2);
    object oPCCopy4 = cs_CopyPC(GetLocation(oSPWNPlayer4_1), FALSE, 3);

    ApplyVFXEyes(oPCCopy1);
    ApplyVFXEyes(oPCCopy2);
    ApplyVFXEyes(oPCCopy3);
    ApplyVFXEyes(oPCCopy4);

    object oRockA1 = GetObjectByTag("A3_BOULDERA", 0);
    object oRockA2 = GetObjectByTag("A3_BOULDERA", 1);
    object oRockA3 = GetObjectByTag("A3_BOULDERA", 2);
    object oRockA4 = GetObjectByTag("A3_BOULDERA", 3);

    object oRockB1 = GetObjectByTag("A3_BOULDERB", 0);
    object oRockB2 = GetObjectByTag("A3_BOULDERB", 1);
    object oRockB3 = GetObjectByTag("A3_BOULDERB", 2);
    object oRockB4 = GetObjectByTag("A3_BOULDERB", 3);

    object oSndRoar = GetObjectByTag("a3_snd_beastroar");

    SetPlotFlag(oRockA1, FALSE);
    SetPlotFlag(oRockA2, FALSE);
    SetPlotFlag(oRockA3, FALSE);
    SetPlotFlag(oRockA4, FALSE);
    SetPlotFlag(oRockB1, FALSE);
    SetPlotFlag(oRockB2, FALSE);
    SetPlotFlag(oRockB3, FALSE);
    SetPlotFlag(oRockB4, FALSE);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oNisar, 25.0f);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oGarm, 25.0f);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy1, 25.0f);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy2, 25.0f);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy3, 25.0f);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy4, 25.0f);

    //Start scene from black
    cs_CameraDoFade(0.0f, CS_FADE_TYPE_BLACK);
    cs_CameraUseCameraWaypoint(0.5, 1);
    cs_CameraDoFade(1.0f, CS_FADE_TYPE_FROM_BLACK);

    cs_CameraSetFacing(1.0f, 110.0f, 10.0f, 60.0f, CAMERA_TRANSITION_TYPE_SLOW);

    cs_JumpToLocation(0.5f, oGarm, GetLocation(oWPGarm1));
    cs_JumpToLocation(0.5f, oNisar, GetLocation(oWPNisar1));

    //players run on camera
    cs_ActionMoveToLocation(2.0f, oGarm, GetLocation(oWPGarm2), FALSE);
    cs_ActionMoveToLocation(2.0f, oNisar, GetLocation(oWPNisar2), FALSE);

    cs_ActionMoveToLocation(1.0f, oPCCopy1, GetLocation(oWPPlayer1_1), FALSE);
    cs_ActionMoveToLocation(1.0f, oPCCopy2, GetLocation(oWPPlayer2_1), FALSE);
    cs_ActionMoveToLocation(1.0f, oPCCopy3, GetLocation(oWPPlayer3_1), FALSE);
    cs_ActionMoveToLocation(1.0f, oPCCopy4, GetLocation(oWPPlayer4_1), FALSE);

    cs_ActionSpeakString(6.0f, oNisar, sNisar001);
    cs_ActionMoveToObject(9.0f, oGarm, oWPGarm3);
    cs_SpeakString(10.0f, oGarm, sGarm001);
    cs_ActionSetFacingPoint(11.0f, oGarm, GetPosition(oPCCopy1));

    cs_ApplyVFXToObject(14.0f, DURATION_TYPE_TEMPORARY, VFX_FNF_SCREEN_SHAKE, oWPGuardian, 3.0f);
    cs_ActionSetFacingPoint(14.0f, oGarm, GetPosition(oWPGuardian));
    cs_PlayAnimation(16.0f, oGarm, ANIMATION_LOOPING_DEAD_BACK, 1.0f, 3.0f);

    cs_CameraUseCameraWaypoint(15.0f, 2);

    cs_ApplyEffectToObject(16.0f, DURATION_TYPE_INSTANT, eDamage, oRockA1);
    cs_ApplyEffectToObject(16.2f, DURATION_TYPE_INSTANT, eDamage, oRockA2);
    cs_ApplyEffectToObject(16.4f, DURATION_TYPE_INSTANT, eDamage, oRockA3);
    cs_ApplyEffectToObject(16.6f, DURATION_TYPE_INSTANT, eDamage, oRockA4);

    DelayCommand(17.5f, AssignCommand(oWPGuardian,
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,
        EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oWPGuardian), 12.0f)));

    cs_ApplyEffectToObject(17.2f, DURATION_TYPE_INSTANT, eDamage, oRockB1);
    cs_ApplyEffectToObject(17.4f, DURATION_TYPE_INSTANT, eDamage, oRockB2);
    cs_ApplyEffectToObject(17.6f, DURATION_TYPE_INSTANT, eDamage, oRockB3);
    cs_ApplyEffectToObject(17.8f, DURATION_TYPE_INSTANT, eDamage, oRockB4);

    cs_SoundObjectPlay(18.0f, oSndRoar);

    cs_CameraUseCameraWaypoint(19.0f, 3);

    cs_SpeakString(20.0f, oNisar, sNisar002);
    cs_ActionSetFacingPoint(20.0f, oGarm, GetPosition(oWPGuardian));

    cs_ActionMoveToLocation(21.0f, oNisar, GetLocation(oWPNisar4), TRUE);
    cs_ActionMoveToLocation(21.0f, oPCCopy1, GetLocation(oWPPlayer1_2), TRUE);
    cs_ActionMoveToLocation(21.0f, oPCCopy2, GetLocation(oWPPlayer2_2), TRUE);
    cs_ActionMoveToLocation(21.0f, oPCCopy3, GetLocation(oWPPlayer3_2), TRUE);
    cs_ActionMoveToLocation(21.0f, oPCCopy4, GetLocation(oWPPlayer4_2), TRUE);

    cs_SpeakString(22.0f, oGarm, sGarm002);
    cs_ActionMoveToLocation(23.0f, oGarm, GetLocation(oWPGarm4), TRUE);

    //end cutscene
    cs_CameraDoFade(25.0f, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_MEDIUM);

    cs_DestroyObject(26.0f, oPCCopy1);
    cs_DestroyObject(26.0f, oPCCopy2);
    cs_DestroyObject(26.0f, oPCCopy3);
    cs_DestroyObject(26.0f, oPCCopy4);
    cs_DestroyObject(26.0f, oGarm);
    cs_DestroyObject(26.0f, oNisar);

    cs_JumpToLocation(26.5f, cs_GetPCObject(0), GetLocation(oSPWNPlayer1_1));
    cs_JumpToLocation(26.5f, cs_GetPCObject(1), GetLocation(oSPWNPlayer2_1));
    cs_JumpToLocation(26.5f, cs_GetPCObject(2), GetLocation(oSPWNPlayer3_1));
    cs_JumpToLocation(26.5f, cs_GetPCObject(3), GetLocation(oSPWNPlayer4_1));
    cs_JumpToLocation(26.5f, oRealGarm, GetLocation(oWPGarm1));
    cs_JumpToLocation(26.5f, oRealNisar, GetLocation(oWPNisar1));

    cs_SoundObjectStop(27.0f, oSndRoar);
    cs_EndCutscene(27.0f, TRUE, TRUE, FADE_SPEED_FASTEST);
}
