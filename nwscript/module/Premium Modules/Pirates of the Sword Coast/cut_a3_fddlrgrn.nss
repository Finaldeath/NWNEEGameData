//::///////////////////////////////////////////////
//:: cut_a3_fddlrgrn
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Start the Cutscene with the party arriving
    at Fiddler's Green.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "x0_i0_henchman"
#include "_inc_cutscene"
#include "inc_undead"

void CreateBubbles(object oTarget)
{
    //tiny bubbles...
    effect eBubbles = EffectVisualEffect(513);
    object oVFXHolder;

    oVFXHolder = CreateObject(OBJECT_TYPE_PLACEABLE, "a3_vfx_storage", GetLocation(oTarget));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBubbles, oTarget);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBubbles, oVFXHolder);
    SetLocalObject(oTarget, "oVFXHolder", oVFXHolder);
}

void main()
{
    object oArea = OBJECT_SELF;
    object oModule = GetModule();

    object oRealNisar = GetObjectByTag("a2_hench_nisar");
    object oRealGarm = GetObjectByTag("a1_hench_garm");

    object oWPNisar1 = GetObjectByTag("A3_FDLG_NISARSPWN");
    object oWPNisar2 = GetObjectByTag("A3_FDLG_NISAR2");
    object oWPGarm1 = GetObjectByTag("A3_FDLG_GARMSPWN");
    object oWPGarm2 = GetObjectByTag("A3_FDLG_GARM2");

    object oNisar = CopyObject(oRealNisar, GetLocation(oWPNisar1),
        OBJECT_INVALID, "NPC_TEMP");
    ApplyVFXEyes (oNisar);
    object oGarm = CopyObject(oRealGarm, GetLocation(oWPGarm1),
        OBJECT_INVALID, "NPC_TEMP");
    ApplyVFXEyes (oGarm);

    FireHenchman(GetMaster(oNisar), oNisar);
    FireHenchman(GetMaster(oGarm), oGarm);
    AssignCommand(oNisar, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oGarm, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oNisar, ChangeToStandardFaction(oNisar, STANDARD_FACTION_COMMONER));
    AssignCommand(oGarm, ChangeToStandardFaction(oGarm, STANDARD_FACTION_COMMONER));
    AssignCommand(oNisar, ClearAllActions(TRUE));
    AssignCommand(oGarm, ClearAllActions(TRUE));

    object oSPWNPlayer1_1 = GetObjectByTag("A3_FDLG_PLAYERSPWN1");
    object oSPWNPlayer2_1 = GetObjectByTag("A3_FDLG_PLAYERSPWN2");
    object oSPWNPlayer3_1 = GetObjectByTag("A3_FDLG_PLAYERSPWN3");
    object oSPWNPlayer4_1 = GetObjectByTag("A3_FDLG_PLAYERSPWN4");

    object oWPPlayer1_1 = GetObjectByTag("A3_FDLG_PLAYER1_1");
    object oWPPlayer2_1 = GetObjectByTag("A3_FDLG_PLAYER2_1");
    object oWPPlayer3_1 = GetObjectByTag("A3_FDLG_PLAYER3_1");
    object oWPPlayer4_1 = GetObjectByTag("A3_FDLG_PLAYER4_1");

    effect eGhost = EffectCutsceneGhost();
    effect eDistG = EffectDisappearAppear(GetLocation(oWPNisar2));
    effect eDistN = EffectDisappearAppear(GetLocation(oWPGarm2));
    effect eDist1 = EffectDisappearAppear(GetLocation(oWPPlayer1_1));
    effect eDist2 = EffectDisappearAppear(GetLocation(oWPPlayer2_1));
    effect eDist3 = EffectDisappearAppear(GetLocation(oWPPlayer3_1));
    effect eDist4 = EffectDisappearAppear(GetLocation(oWPPlayer4_1));

    object oPCCopy1 = cs_CopyPC(GetLocation(oSPWNPlayer1_1), FALSE, 0);
    object oPCCopy2 = cs_CopyPC(GetLocation(oSPWNPlayer2_1), FALSE, 1);
    object oPCCopy3 = cs_CopyPC(GetLocation(oSPWNPlayer3_1), FALSE, 2);
    object oPCCopy4 = cs_CopyPC(GetLocation(oSPWNPlayer4_1), FALSE, 3);
    ApplyVFXEyes (oPCCopy1);
    ApplyVFXEyes (oPCCopy2);
    ApplyVFXEyes (oPCCopy3);
    ApplyVFXEyes (oPCCopy4);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oNisar, 25.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oGarm, 25.0f);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oPCCopy1, 25.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oPCCopy2, 25.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oPCCopy3, 25.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oPCCopy4, 25.0f);

    CreateBubbles(oNisar);
    CreateBubbles(oGarm);
    CreateBubbles(oPCCopy1);
    CreateBubbles(oPCCopy2);
    CreateBubbles(oPCCopy3);
    CreateBubbles(oPCCopy4);

    //Start scene from black
    cs_CameraDoFade(0.0f, CS_FADE_TYPE_BLACK, FADE_SPEED_SLOWEST);
    cs_ApplyEffectToObject(0.0f, DURATION_TYPE_TEMPORARY, eDist1, oPCCopy1, 4.2f);
    cs_ApplyEffectToObject(0.0f, DURATION_TYPE_TEMPORARY, eDistN, oNisar, 4.4f);
    cs_ApplyEffectToObject(0.0f, DURATION_TYPE_TEMPORARY, eDistG, oGarm, 4.6f);
    cs_ApplyEffectToObject(0.0f, DURATION_TYPE_TEMPORARY, eDist2, oPCCopy2, 4.8f);
    cs_ApplyEffectToObject(0.0f, DURATION_TYPE_TEMPORARY, eDist3, oPCCopy3, 5.0f);
    cs_ApplyEffectToObject(0.0f, DURATION_TYPE_TEMPORARY, eDist4, oPCCopy4, 5.2f);

    cs_CameraUseCameraWaypoint(0.5, 100);
    cs_CameraSetFacing(1.0f, 360.0f, 6.0f, 77.0f, CAMERA_TRANSITION_TYPE_VERY_SLOW);
    cs_CameraDoFade(1.0f, CS_FADE_TYPE_FROM_BLACK);

    //end cutscene
    cs_CameraDoFade(7.0f, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_MEDIUM);

    cs_JumpToLocation(8.5f, cs_GetPCObject(0), GetLocation(oWPPlayer1_1));
    cs_JumpToLocation(8.5f, cs_GetPCObject(1), GetLocation(oWPPlayer2_1));
    cs_JumpToLocation(8.5f, cs_GetPCObject(2), GetLocation(oWPPlayer3_1));
    cs_JumpToLocation(8.5f, cs_GetPCObject(3), GetLocation(oWPPlayer4_1));

    cs_ClearAllActions(8.4, oRealNisar);
    cs_ClearAllActions(8.4, oRealGarm);
    cs_ActionJumpToLocation(8.5f, oRealNisar, GetLocation(oWPGarm2));
    cs_ActionJumpToLocation(8.5f, oRealGarm, GetLocation(oWPNisar2));

    cs_DestroyObject(8.1f, oPCCopy1);
    cs_DestroyObject(8.1f, oPCCopy2);
    cs_DestroyObject(8.1f, oPCCopy3);
    cs_DestroyObject(8.1f, oPCCopy4);
    cs_DestroyObject(8.1f, oGarm);
    cs_DestroyObject(8.1f, oNisar);

    cs_EndCutscene(10.0f, TRUE, TRUE, FADE_SPEED_FASTEST);
}
