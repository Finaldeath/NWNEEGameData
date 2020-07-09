//::///////////////////////////////////////////////
//:: cut_a3_undead1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player teleports into Kolmarrs trap and
    Kolmarr initiates dialog.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "x0_i0_henchman"
#include "_inc_cutscene"

const string sKolmarr1 = "Yes, I can feel it! The time is at hand!";

void main()
{
    object oArea = OBJECT_SELF;
    object oModule = GetModule();

    object oKolmarr = GetObjectByTag("a3_necro_fight");
    object oNisarReal = GetObjectByTag("a2_hench_nisar");
    object oGarmReal = GetObjectByTag("a1_hench_garm");

    object oWPNisar1 = GetObjectByTag("A3_NDD_NISARSPWN");
    object oWPNisar2 = GetObjectByTag("A3_NDD_NISAR2");
    object oWPGarm1 = GetObjectByTag("A3_NDD_GARMSPWN");
    object oWPGarm2 = GetObjectByTag("A3_NDD_GARM2");
    object oWPKolmar1 = GetObjectByTag("A3_NECROFIGHT0");
    object oWPKolmar2 = GetObjectByTag("A3_NECROFIGHT1");
    object oWPKolmar3 = GetObjectByTag("A3_NECROFIGHT2");

    object oNisar = CopyObject(oNisarReal, GetLocation(oWPNisar1), OBJECT_INVALID, "A3_NDD_NISAR");
    object oGarm = CopyObject(oGarmReal, GetLocation(oWPGarm1), OBJECT_INVALID, "A3_NDD_GARM");

    AssignCommand(oNisar, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oGarm, SetIsDestroyable(TRUE, FALSE, FALSE));
    FireHenchman(GetMaster(oNisar), oNisar);
    FireHenchman(GetMaster(oGarm), oGarm);
    DelayCommand(1.0, ChangeToStandardFaction(oNisar, STANDARD_FACTION_COMMONER));
    DelayCommand(1.0, ChangeToStandardFaction(oGarm, STANDARD_FACTION_COMMONER));
    DelayCommand(1.1, AssignCommand(oNisar, ClearAllActions(TRUE)));
    DelayCommand(1.1, AssignCommand(oGarm, ClearAllActions(TRUE)));

    //TEST
    DelayCommand(1.5, AssignCommand(oNisar, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oNisar))));
    DelayCommand(1.5, AssignCommand(oGarm, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oGarm))));

    object oSPWNPlayer1_1 = GetObjectByTag("A3_NDD_PLAYERSPWN1");
    object oSPWNPlayer2_1 = GetObjectByTag("A3_NDD_PLAYERSPWN2");
    object oSPWNPlayer3_1 = GetObjectByTag("A3_NDD_PLAYERSPWN3");
    object oSPWNPlayer4_1 = GetObjectByTag("A3_NDD_PLAYERSPWN4");

    object oWPPlayer1_1 = GetObjectByTag("A3_NDD_PLAYER1_1");
    object oWPPlayer2_1 = GetObjectByTag("A3_NDD_PLAYER2_1");
    object oWPPlayer3_1 = GetObjectByTag("A3_NDD_PLAYER3_1");
    object oWPPlayer4_1 = GetObjectByTag("A3_NDD_PLAYER4_1");

    effect eGhost = EffectCutsceneGhost();
    effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);

    object oPCCopy1 = cs_CopyPC(GetLocation(oSPWNPlayer1_1), FALSE, 0, "A3_NDD_PC1");
    object oPCCopy2 = cs_CopyPC(GetLocation(oSPWNPlayer2_1), FALSE, 1, "A3_NDD_PC2");
    object oPCCopy3 = cs_CopyPC(GetLocation(oSPWNPlayer3_1), FALSE, 2, "A3_NDD_PC3");
    object oPCCopy4 = cs_CopyPC(GetLocation(oSPWNPlayer4_1), FALSE, 3, "A3_NDD_PC4");

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oNisar, 25.0f);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oGarm, 25.0f);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy1, 25.0f);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy2, 25.0f);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy3, 25.0f);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy4, 25.0f);

    cs_CameraUseCameraWaypoint(0.5, 1);
    cs_CameraSetFacing(1.0f, 110.0f, 7.0f, 75.0f, CAMERA_TRANSITION_TYPE_VERY_SLOW);
    cs_CameraDoFade(1.0f, CS_FADE_TYPE_FROM_BLACK);

    cs_ActionMoveToObject(1.0f, oKolmarr, oWPKolmar2);
    cs_SpeakString(4.0f, oKolmarr, sKolmarr1);

    cs_ActionPlayAnimation(7.0f, oKolmarr, ANIMATION_LOOPING_CONJURE1, 1.0f, 6.0f);
    cs_ApplyVFXToObject(7.5f, DURATION_TYPE_TEMPORARY, VFX_DUR_PROTECTION_EVIL_MAJOR, oKolmarr, 6.5f);
    cs_ApplyVFXToObject(7.5f, DURATION_TYPE_INSTANT, VFX_FNF_LOS_EVIL_20, oKolmarr);

    DelayCommand(9.2, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eSummon, GetLocation(oWPPlayer1_1)));
    cs_ClearAllActions(9.0f, oWPPlayer1_1);
    cs_JumpToObject(9.5f, oPCCopy1, oWPPlayer1_1);

    DelayCommand(9.4, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eSummon, GetLocation(oWPGarm2)));
    cs_ClearAllActions(9.0f, oGarm);
    cs_JumpToObject(9.7f, oGarm, oWPGarm2);

    DelayCommand(9.6, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eSummon, GetLocation(oWPNisar2)));
    cs_ClearAllActions(9.0f, oNisar);
    cs_JumpToObject(9.9f, oNisar, oWPNisar2);

    if (GetIsObjectValid(oPCCopy2) == TRUE)
    {
        DelayCommand(9.8, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
            eSummon, GetLocation(oWPPlayer2_1)));
        cs_JumpToObject(10.1f, oPCCopy2, oWPPlayer2_1);
    }
    if (GetIsObjectValid(oPCCopy3) == TRUE)
    {
        DelayCommand(10.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
            eSummon, GetLocation(oWPPlayer3_1)));
        cs_JumpToObject(10.3f, oPCCopy3, oWPPlayer3_1);
    }
    if (GetIsObjectValid(oPCCopy4) == TRUE)
    {
        DelayCommand(10.2, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
            eSummon, GetLocation(oWPPlayer4_1)));
        cs_JumpToObject(10.5f, oPCCopy4, oWPPlayer4_1);
    }

    cs_ApplyVFXToObject(11.0f, DURATION_TYPE_PERMANENT, VFX_FNF_PWSTUN, oPCCopy1);
    cs_ApplyVFXToObject(11.0f, DURATION_TYPE_PERMANENT, VFX_DUR_PARALYZED, oPCCopy1);
    cs_ApplyVFXToObject(11.2f, DURATION_TYPE_PERMANENT, VFX_FNF_PWSTUN, oGarm);
    cs_ApplyVFXToObject(11.2f, DURATION_TYPE_PERMANENT, VFX_DUR_PARALYZED, oGarm);
    cs_ApplyVFXToObject(11.4f, DURATION_TYPE_PERMANENT, VFX_FNF_PWSTUN, oNisar);
    cs_ApplyVFXToObject(11.4f, DURATION_TYPE_PERMANENT, VFX_DUR_PARALYZED, oNisar);
    cs_ApplyVFXToObject(11.6f, DURATION_TYPE_PERMANENT, VFX_FNF_PWSTUN, oPCCopy2);
    cs_ApplyVFXToObject(11.6f, DURATION_TYPE_PERMANENT, VFX_DUR_PARALYZED, oPCCopy2);
    cs_ApplyVFXToObject(11.8f, DURATION_TYPE_PERMANENT, VFX_FNF_PWSTUN, oPCCopy3);
    cs_ApplyVFXToObject(11.8f, DURATION_TYPE_PERMANENT, VFX_DUR_PARALYZED, oPCCopy3);
    cs_ApplyVFXToObject(12.0f, DURATION_TYPE_PERMANENT, VFX_FNF_PWSTUN, oPCCopy4);
    cs_ApplyVFXToObject(12.0f, DURATION_TYPE_PERMANENT, VFX_DUR_PARALYZED, oPCCopy4);

    cs_ActionMoveToObject(13.0f, oKolmarr, oWPKolmar3);
    cs_ActionStartConversation(15.0f, oKolmarr, cs_GetPCObject());

    //end cutscene
    //cs_CameraDoFade(10.0f, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_MEDIUM);
}
