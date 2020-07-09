//::///////////////////////////////////////////////
//:: cut_a3_shark
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

const string sNisar001 = "Aye, see the sunken ship, Cap'n?";
const string sGarm001 = "Sssomething huntsss usss, Eater-of-Garm...";
const string sGarm002 = "Mighty ssscalekin! Honored elder! Greatessst of Laogzed'sss creationsss!";

void main()
{
    effect eGhost = EffectCutsceneGhost();
    object oArea = OBJECT_SELF;
    object oModule = GetModule();

    object oWPSPWNDragon = GetObjectByTag("A3_SHRKSTRT_DRGN");
    object oWPDragon = GetObjectByTag("A3_SHRKSPWN_DRGN");

    object oRealNisar = GetObjectByTag("a2_hench_nisar");
    object oRealGarm = GetObjectByTag("a1_hench_garm");

    object oWPNisar1 = GetObjectByTag("A3_SHRK_SPWNNISAR");
    object oWPNisar2 = GetObjectByTag("A3_SHRKTRG_NISAR");
    object oWPGarm1 = GetObjectByTag("A3_SHRK_SPWNGARM");
    object oWPGarm2 = GetObjectByTag("A3_SHRKTRG_GARM");

    object oNisar = CopyObject(oRealNisar, GetLocation(oWPNisar1));
    object oGarm = CopyObject(oRealGarm, GetLocation(oWPGarm1));

    FireHenchman(GetMaster(oNisar), oNisar);
    FireHenchman(GetMaster(oGarm), oGarm);
    AssignCommand(oNisar, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oGarm, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oNisar, ChangeToStandardFaction(oNisar, STANDARD_FACTION_COMMONER));
    AssignCommand(oGarm, ChangeToStandardFaction(oGarm, STANDARD_FACTION_COMMONER));
    AssignCommand(oNisar, ClearAllActions(TRUE));
    AssignCommand(oGarm, ClearAllActions(TRUE));

    object oSPWNPlayer1_1 = GetObjectByTag("A3_SHRK_PCSPWN_01");
    object oSPWNPlayer2_1 = GetObjectByTag("A3_SHRK_PCSPWN_02");
    object oSPWNPlayer3_1 = GetObjectByTag("A3_SHRK_PCSPWN_03");
    object oSPWNPlayer4_1 = GetObjectByTag("A3_SHRK_PCSPWN_04");

    object oWPPlayer1_1 = GetObjectByTag("A3_SHRKTRG_PC_01");
    object oWPPlayer2_1 = GetObjectByTag("A3_SHRKTRG_PC_02");
    object oWPPlayer3_1 = GetObjectByTag("A3_SHRKTRG_PC_03");
    object oWPPlayer4_1 = GetObjectByTag("A3_SHRKTRG_PC_04");

    object oWPShrkSpwn1 = GetObjectByTag("A3_SHRK_SPWN1");
    object oWPShrkSpwn2 = GetObjectByTag("A3_SHRK_SPWN2");
    object oWPShrkSpwn3 = GetObjectByTag("A3_SHRK_SPWN3");
    object oWPShrkSpwn4 = GetObjectByTag("A3_SHRK_SPWN4");

    object oWPShrkSpwnB1 = GetObjectByTag("A3_SHRK_SPWNB1");
    object oWPShrkSpwnB2 = GetObjectByTag("A3_SHRK_SPWNB2");

    object oPCCopy1 = cs_CopyPC(GetLocation(oSPWNPlayer1_1), FALSE, 0);
    object oPCCopy2 = cs_CopyPC(GetLocation(oSPWNPlayer2_1), FALSE, 1);
    object oPCCopy3 = cs_CopyPC(GetLocation(oSPWNPlayer3_1), FALSE, 2);
    object oPCCopy4 = cs_CopyPC(GetLocation(oSPWNPlayer4_1), FALSE, 3);

    object oSharkTarg1 = GetObjectByTag("A3_SHRKTRGT_01");
    object oSharkTarg2 = GetObjectByTag("A3_SHRKTRGT_02");
    object oSharkTarg3 = GetObjectByTag("A3_SHRKTRGT_03");
    object oSharkTarg4 = GetObjectByTag("A3_SHRKTRGT_04");
    object oSharkTarg5 = GetObjectByTag("A3_SHRKTRGT_05");
    object oSharkTarg6 = GetObjectByTag("A3_SHRKTRGT_06");

    object oDragon = CreateObject(OBJECT_TYPE_CREATURE, "a3_dragona", GetLocation(oWPSPWNDragon));

    object oShark1 = CreateObject(OBJECT_TYPE_CREATURE, "a3_cutshark", GetLocation(oWPShrkSpwn1));
    object oShark2 = CreateObject(OBJECT_TYPE_CREATURE, "a3_cutshark", GetLocation(oWPShrkSpwn2));
    object oShark3 = CreateObject(OBJECT_TYPE_CREATURE, "a3_cutshark", GetLocation(oWPShrkSpwn3));
    object oShark4 = CreateObject(OBJECT_TYPE_CREATURE, "a3_cutshark", GetLocation(oWPShrkSpwn4));

    object oSharkB1 = CreateObject(OBJECT_TYPE_CREATURE, "a3_cutshark", GetLocation(oWPShrkSpwnB1));
    object oSharkB2 = CreateObject(OBJECT_TYPE_CREATURE, "a3_cutshark", GetLocation(oWPShrkSpwnB1));
    object oSharkB3 = CreateObject(OBJECT_TYPE_CREATURE, "a3_cutshark", GetLocation(oWPShrkSpwnB1));
    object oSharkB4 = CreateObject(OBJECT_TYPE_CREATURE, "a3_cutshark", GetLocation(oWPShrkSpwnB2));
    object oSharkB5 = CreateObject(OBJECT_TYPE_CREATURE, "a3_cutshark", GetLocation(oWPShrkSpwnB2));
    object oSharkB6 = CreateObject(OBJECT_TYPE_CREATURE, "a3_cutshark", GetLocation(oWPShrkSpwnB2));

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oShark1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oShark2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oShark3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oShark4);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oSharkB1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oSharkB2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oSharkB3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oSharkB4);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oSharkB5);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oSharkB6);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oNisar);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oGarm);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy4);

    //Start scene from black
    cs_CameraDoFade(0.0f, CS_FADE_TYPE_BLACK);
    cs_CameraUseCameraWaypoint(0.5, 10);
    cs_CameraDoFade(1.0f, CS_FADE_TYPE_FROM_BLACK);

    cs_CameraSetFacing(1.0f, 100.0f, 18.0f, 80.0f, CAMERA_TRANSITION_TYPE_SLOW);

    cs_JumpToLocation(0.0f, oGarm, GetLocation(oWPGarm1));
    cs_JumpToLocation(0.0f, oNisar, GetLocation(oWPNisar1));

    //players run on camera
    cs_ActionMoveToLocation(0.0f, oGarm, GetLocation(oWPGarm2), FALSE);
    cs_ActionMoveToLocation(0.0f, oNisar, GetLocation(oWPNisar2), FALSE);
    cs_ActionMoveToLocation(0.0f, oPCCopy1, GetLocation(oWPPlayer1_1), FALSE);
    cs_ActionMoveToLocation(0.0f, oPCCopy2, GetLocation(oWPPlayer2_1), FALSE);
    cs_ActionMoveToLocation(0.0f, oPCCopy3, GetLocation(oWPPlayer3_1), FALSE);
    cs_ActionMoveToLocation(0.0f, oPCCopy4, GetLocation(oWPPlayer4_1), FALSE);

    //Sharks run on camera
    cs_ActionMoveToLocation(1.0f, oShark1, GetLocation(oWPShrkSpwn4));
    cs_ActionMoveToLocation(3.0f, oShark2, GetLocation(oWPShrkSpwn3));
    cs_ActionMoveToLocation(5.0f, oShark3, GetLocation(oWPShrkSpwn1));
    cs_ActionMoveToLocation(7.0f, oShark4, GetLocation(oWPShrkSpwn2));
    cs_ActionMoveToLocation(9.0f, oShark1, GetLocation(oWPShrkSpwn2));
    cs_ActionMoveToLocation(11.0f, oShark2, GetLocation(oWPShrkSpwn1));
    cs_ActionMoveToLocation(13.0f, oShark3, GetLocation(oWPShrkSpwn4));
    cs_ActionMoveToLocation(15.0f, oShark4, GetLocation(oWPShrkSpwn3));

    cs_ActionMoveToLocation(20.0f, oShark1, GetLocation(oWPShrkSpwnB1));
    cs_ActionMoveToLocation(20.0f, oShark2, GetLocation(oWPShrkSpwnB1));
    cs_ActionMoveToLocation(20.0f, oShark3, GetLocation(oWPShrkSpwnB2));
    cs_ActionMoveToLocation(20.0f, oShark4, GetLocation(oWPShrkSpwnB2));

    cs_ActionSpeakString(6.0f, oNisar, sNisar001);
    cs_SpeakString(10.0f, oGarm, sGarm001);

    cs_ActionSetFacingPoint(11.0f, oGarm, GetPosition(oSharkTarg1));
    cs_ActionSetFacingPoint(12.0f, oNisar, GetPosition(oSharkTarg6));
    cs_ActionSetFacingPoint(12.0f, oPCCopy1, GetPosition(oSPWNPlayer1_1));
    cs_ActionSetFacingPoint(12.0f, oPCCopy4, GetPosition(oSPWNPlayer1_1));
    cs_ActionSetFacingPoint(12.0f, oPCCopy2, GetPosition(oSharkTarg2));
    cs_ActionSetFacingPoint(12.0f, oPCCopy3, GetPosition(oSharkTarg5));

    cs_CameraUseCameraWaypoint(15.0f, 11);

    cs_ActionMoveToLocation(11.0f, oSharkB1, GetLocation(oSharkTarg1));
    cs_ActionMoveToLocation(11.5f, oSharkB2, GetLocation(oSharkTarg2));
    cs_ActionMoveToLocation(12.0f, oSharkB3, GetLocation(oSharkTarg3));
    cs_ActionMoveToLocation(12.5f, oSharkB4, GetLocation(oSharkTarg4));
    cs_ActionMoveToLocation(11.0f, oSharkB5, GetLocation(oSharkTarg5));
    cs_ActionMoveToLocation(11.5f, oSharkB6, GetLocation(oSharkTarg6));

    cs_ActionSetFacingPoint(12.0f, oSharkB1, GetPosition(oWPDragon));
    cs_ActionSetFacingPoint(12.5f, oSharkB2, GetPosition(oWPDragon));
    cs_ActionSetFacingPoint(13.0f, oSharkB3, GetPosition(oWPDragon));
    cs_ActionSetFacingPoint(13.5f, oSharkB4, GetPosition(oWPDragon));
    cs_ActionSetFacingPoint(12.0f, oSharkB5, GetPosition(oWPDragon));
    cs_ActionSetFacingPoint(12.5f, oSharkB6, GetPosition(oWPDragon));

    DelayCommand(17.0f, AssignCommand(oWPDragon, ApplyEffectAtLocation(
        DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_UNDEAD_DRAGON),
        GetLocation(oWPDragon), 3.0f)));

    DelayCommand(21.0f, AssignCommand(oWPDragon, ApplyEffectAtLocation(
        DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SUMMONDRAGON),
        GetLocation(oWPDragon), 1.0f)));

    cs_ActionPlayAnimation(21.0f, oGarm, ANIMATION_FIREFORGET_DODGE_DUCK, 0.7);
    cs_ActionPlayAnimation(21.2f, oNisar, ANIMATION_FIREFORGET_DODGE_DUCK, 0.8);
    cs_ActionPlayAnimation(21.1f, oPCCopy1, ANIMATION_FIREFORGET_DODGE_DUCK, 0.9);
    cs_ActionPlayAnimation(21.3f, oPCCopy4, ANIMATION_FIREFORGET_DODGE_DUCK, 1.1);
    cs_ActionPlayAnimation(21.5f, oPCCopy2, ANIMATION_FIREFORGET_DODGE_DUCK, 1.0);
    cs_ActionPlayAnimation(21.6f, oPCCopy3, ANIMATION_FIREFORGET_DODGE_DUCK, 1.2);

    cs_JumpToLocation(21.5f, oDragon, GetLocation(oWPDragon));

    cs_ActionSetFacingPoint(22.0f, oGarm, GetPosition(oWPDragon));
    cs_ActionSetFacingPoint(22.0f, oNisar, GetPosition(oWPDragon));
    cs_ActionSetFacingPoint(22.0f, oPCCopy1, GetPosition(oWPDragon));
    cs_ActionSetFacingPoint(22.0f, oPCCopy4, GetPosition(oWPDragon));
    cs_ActionSetFacingPoint(22.0f, oPCCopy2, GetPosition(oWPDragon));
    cs_ActionSetFacingPoint(22.0f, oPCCopy3, GetPosition(oWPDragon));

    cs_JumpToLocation(21.5f, oDragon, GetLocation(oWPDragon));
    cs_CameraUseCameraWaypoint(22.0f, 12);

    DelayCommand(22.3f, AssignCommand(oSharkB1, ActionMoveAwayFromLocation(GetLocation(oWPDragon), TRUE)));
    DelayCommand(23.0f, AssignCommand(oSharkB2, ActionMoveAwayFromLocation(GetLocation(oWPDragon), TRUE)));
    DelayCommand(23.1f, AssignCommand(oSharkB3, ActionMoveAwayFromLocation(GetLocation(oWPDragon), TRUE)));
    DelayCommand(22.8f, AssignCommand(oSharkB4, ActionMoveAwayFromLocation(GetLocation(oWPDragon), TRUE)));
    DelayCommand(22.9f, AssignCommand(oSharkB5, ActionMoveAwayFromLocation(GetLocation(oWPDragon), TRUE)));
    DelayCommand(23.2f, AssignCommand(oSharkB6, ActionMoveAwayFromLocation(GetLocation(oWPDragon), TRUE)));

    cs_ActionSetFacingPoint(24.0f, oGarm, GetPosition(oWPDragon));
    cs_ActionPlayAnimation(24.1f, oGarm, ANIMATION_LOOPING_WORSHIP, 1.0f, 6.0f);
    cs_SpeakString(24.2f, oGarm, sGarm002);

    cs_CameraDoFade(28.0f, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_MEDIUM);

    cs_JumpToLocation(30.0f, cs_GetPCObject(0), GetLocation(oWPPlayer1_1));
    cs_JumpToLocation(30.0f, cs_GetPCObject(1), GetLocation(oWPPlayer2_1));
    cs_JumpToLocation(30.0f, cs_GetPCObject(2), GetLocation(oWPPlayer3_1));
    cs_JumpToLocation(30.0f, cs_GetPCObject(3), GetLocation(oWPPlayer4_1));
    cs_JumpToLocation(30.0f, GetObjectByTag("a2_hench_garm"),
        GetLocation(oWPGarm2));
    cs_JumpToLocation(30.0f, GetObjectByTag("a2_hench_nisar"),
        GetLocation(oWPNisar2));

    cs_DestroyObject(30.0f, oPCCopy1);
    cs_DestroyObject(30.0f, oPCCopy2);
    cs_DestroyObject(30.0f, oPCCopy3);
    cs_DestroyObject(30.0f, oPCCopy4);

    cs_DestroyObject(30.0f, oShark1);
    cs_DestroyObject(30.0f, oShark2);
    cs_DestroyObject(30.0f, oShark3);
    cs_DestroyObject(30.0f, oShark4);

    cs_DestroyObject(30.0f, oSharkB1);
    cs_DestroyObject(30.0f, oSharkB2);
    cs_DestroyObject(30.0f, oSharkB3);
    cs_DestroyObject(30.0f, oSharkB4);
    cs_DestroyObject(30.0f, oSharkB5);
    cs_DestroyObject(30.0f, oSharkB6);

    cs_DestroyObject(30.0f, oGarm);
    cs_DestroyObject(30.0f, oNisar);

    cs_EndCutscene(30.0f, TRUE, TRUE, FADE_SPEED_MEDIUM);
}
