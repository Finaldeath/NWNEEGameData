//::///////////////////////////////////////////////
//:: cut_a3_tasina
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has entered the temple and is running
    into Tasina as she attempts to unlock the
    power of the statues.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "x0_i0_henchman"
#include "_inc_cutscene"
#include "inc_undead"

const string sTasina001 = "Why won't this WORK!? Curse these mildewed texts!";
const string sPriestess001 = "Don't worry, Sister Tasina. I'm sure the answer's in here somewhere.";
const string sAcolyte001 = "Don't give up. We came here to do this and we're not leaving until it's done!";
const string sTasina002 = "Thanks for the support, sisters. I almost have it, I know I do.";
const string sTasina003 = "Let's take another look at these old manuscripts...";
const string sPriestess002 = "...I don't like this place, do you?";
const string sAcolyte002 = "It's not what I expected of Umberlee, that's for sure...";
const string sTasina004 = "Hrmm... This one seems promising.";

void main()
{
    effect eGhost = EffectCutsceneGhost();
    effect eDamage = EffectDamage(1000);

    object oArea = OBJECT_SELF;
    object oModule = GetModule();

    object oWPNisar1 = GetObjectByTag("A3_TSN_NISAR01");
    object oWPGarm1 = GetObjectByTag("A3_TSN_GARM01");
    object oWPPoly1 = GetObjectByTag("A3_TSN_POLY01");
    object oWPHolding = GetObjectByTag("A3_TSN_HOLDING");
    object oWPPortal = GetObjectByTag("A3_TMPL_PORTAL");

    object oRealNisar = GetObjectByTag("a2_hench_nisar");
    object oRealGarm = GetObjectByTag("a1_hench_garm");

    cs_JumpToObject(0.0f, oRealNisar, oWPHolding);
    cs_JumpToObject(0.0f, oRealGarm, oWPHolding);

    object oNisar = CopyObject(oRealNisar, GetLocation(oWPHolding), OBJECT_INVALID, "a3_cutnisar");
    ApplyVFXEyes (oNisar);
    object oGarm = CopyObject(oRealGarm, GetLocation(oWPHolding), OBJECT_INVALID, "a3_cutgarm");
    ApplyVFXEyes (oGarm);
    object oPoly = CreateObject(OBJECT_TYPE_CREATURE, "cut_poly", GetLocation(oWPHolding));

    AssignCommand(oNisar, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oGarm, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oPoly, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oNisar, ChangeToStandardFaction(oNisar, STANDARD_FACTION_COMMONER));
    AssignCommand(oGarm, ChangeToStandardFaction(oGarm, STANDARD_FACTION_COMMONER));

    AssignCommand(oNisar, ClearAllActions(TRUE));
    AssignCommand(oGarm, ClearAllActions(TRUE));
    DelayCommand(0.5f, RemoveHenchman(GetMaster(oNisar), oNisar));
    DelayCommand(0.5f, RemoveHenchman(GetMaster(oGarm), oGarm));
    DelayCommand(0.7f, AssignCommand(oNisar, ClearAllActions(TRUE)));
    DelayCommand(0.7f, AssignCommand(oGarm, ClearAllActions(TRUE)));

    SetLocalObject(oArea, "oGarm", oGarm);
    SetLocalObject(oArea, "oNisar", oNisar);
    SetLocalObject(oArea, "oPoly", oPoly);

    object oWPPlayer1_1 = GetObjectByTag("A3_TSN_PCRAPPR1");
    object oWPPlayer2_1 = GetObjectByTag("A3_TSN_PCRAPPR2");
    object oWPPlayer3_1 = GetObjectByTag("A3_TSN_PCRAPPR3");
    object oWPPlayer4_1 = GetObjectByTag("A3_TSN_PCRAPPR4");

    object oPCCopy1 = cs_CopyPC(GetLocation(oWPHolding), FALSE, 0);
    object oPCCopy2 = cs_CopyPC(GetLocation(oWPHolding), FALSE, 1);
    object oPCCopy3 = cs_CopyPC(GetLocation(oWPHolding), FALSE, 2);
    object oPCCopy4 = cs_CopyPC(GetLocation(oWPHolding), FALSE, 3);
    ApplyVFXEyes (oPCCopy1);
    ApplyVFXEyes (oPCCopy2);
    ApplyVFXEyes (oPCCopy3);
    ApplyVFXEyes (oPCCopy4);

    SetLocalObject(oArea, "oPCCopy1", oPCCopy1);
    SetLocalObject(oArea, "oPCCopy2", oPCCopy2);
    SetLocalObject(oArea, "oPCCopy3", oPCCopy3);
    SetLocalObject(oArea, "oPCCopy4", oPCCopy4);

    object oTasina = GetObjectByTag("a3_tasina");
    object oWPTsn = GetObjectByTag("A3_TSN_TASINA");

    object oAcolyte1 = GetObjectByTag("a3_cutacolyte_1");
    object oPreistess1 = GetObjectByTag("a3_cutpriestess_1");
    object oPreistess2 = GetObjectByTag("a3_cutpriestess_2");
    object oPreistess3 = GetObjectByTag("a3_cutpriestess_3");
    object oPreistess4 = GetObjectByTag("a3_cutpriestess_4");

    object oDevice1 = GetObjectByTag("a3_floatingorb_1");
    object oDevice2 = GetObjectByTag("a3_floatingorb_2");
    object oDevice3 = GetObjectByTag("a3_floatingorb_3");
    object oDevice4 = GetObjectByTag("a3_floatingorb_4");

    object oHandAlter1 = GetObjectByTag("a3_hand1");
    object oHandAlter2 = GetObjectByTag("a3_hand2");
    object oHandAlter3 = GetObjectByTag("a3_hand3");

    object oBooks = GetObjectByTag("a3_tsnbooks");
    object oVFX_Targ = GetObjectByTag("a3_vfx_targ");

    AssignCommand(oTasina, SetIsDestroyable(TRUE, FALSE, FALSE));

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oNisar, 25.0f);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oGarm, 25.0f);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy4);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oAcolyte1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPreistess1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPreistess2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPreistess3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPreistess4);

    //Start scene from black
    cs_CameraDoFade(0.0f, CS_FADE_TYPE_BLACK);
    cs_CameraUseCameraWaypoint(0.5, 1);
    cs_CameraDoFade(2.0f, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_SLOW);

    cs_CameraSetFacing(2.0f, 135.0f, 5.6f, 67.0f, CAMERA_TRANSITION_TYPE_SLOW);

    //Tasina fumbles with incantations.
    cs_ActionPlayAnimation(0.0f, oTasina, ANIMATION_LOOPING_WORSHIP, 0.75f, 10.0f);
    cs_ActionPlayAnimation(0.0f, oAcolyte1, ANIMATION_LOOPING_WORSHIP, 0.75f, 12.0f);
    cs_ActionPlayAnimation(0.0f, oPreistess1, ANIMATION_LOOPING_WORSHIP, 0.75f, 13.0f);

    cs_ActionPlayAnimation(0.2f, oPreistess2, ANIMATION_LOOPING_WORSHIP, 0.75f, 13.0f);
    cs_ActionPlayAnimation(0.0f, oPreistess3, ANIMATION_LOOPING_WORSHIP, 0.75f, 13.0f);
    cs_ActionPlayAnimation(0.1f, oPreistess4, ANIMATION_LOOPING_WORSHIP, 0.75f, 13.0f);

    cs_ApplyVFXToObject(11.0f, DURATION_TYPE_INSTANT, VFX_IMP_DEATH_L, oVFX_Targ);

    cs_PlayAnimation(11.0f, oDevice1, ANIMATION_PLACEABLE_DEACTIVATE);
    cs_PlayAnimation(11.0f, oDevice2, ANIMATION_PLACEABLE_DEACTIVATE);
    cs_PlayAnimation(11.0f, oDevice3, ANIMATION_PLACEABLE_DEACTIVATE);
    cs_PlayAnimation(11.0f, oDevice4, ANIMATION_PLACEABLE_DEACTIVATE);

    cs_SpeakString(13.0f, oTasina, sTasina001);
    cs_PlayAnimation(13.1f, oTasina, ANIMATION_LOOPING_TALK_FORCEFUL, 1.2f, 4.0f);

    cs_ActionSetFacingPoint(17.5f, oPreistess1, GetPosition(oTasina));
    cs_ActionSpeakString(18.0f, oPreistess1, sPriestess001);
    cs_PlayAnimation(18.1f, oPreistess1, ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 3.0f);
    cs_PlayAnimation(18.5f, oTasina, ANIMATION_LOOPING_PAUSE_TIRED, 1.0f, 9.0f);

    cs_ActionSetFacingPoint(19.0f, oAcolyte1, GetPosition(oTasina));
    cs_ActionSpeakString(22.0f, oAcolyte1, sAcolyte001);
    cs_PlayAnimation(22.1f, oPreistess1, ANIMATION_LOOPING_TALK_NORMAL, 1.0f, 3.0f);

    cs_ActionSetFacingPoint(26.0f, oTasina, GetPosition(oPreistess1));
    cs_SpeakString(26.5f, oTasina, sTasina002);
    cs_SpeakString(30.5f, oAcolyte1, "");

    cs_SpeakString(31.0f, oTasina, sTasina003);
    cs_ActionMoveToObject(31.0f, oTasina, oBooks, FALSE, 0.0f);
    cs_ActionPlayAnimation(31.5f, oTasina, ANIMATION_LOOPING_GET_LOW, 1.0f, 9.0f);

    cs_SpeakString(34.0f, oPreistess1, sPriestess002);
    cs_SpeakString(37.0f, oAcolyte1, sAcolyte002);

    cs_SpeakString(40.5f, oPreistess1, "");
    cs_SpeakString(40.5f, oAcolyte1, "");

    cs_SpeakString(41.0f, oTasina, sTasina004);
    cs_ActionSetFacing(41.2f, oAcolyte1, 0.0f);
    cs_ActionSetFacing(41.0f, oPreistess1, 0.0f);

    cs_ActionMoveToObject(42.0f, oTasina, oWPTsn, FALSE, 0.0f);
    cs_ActionSetFacingPoint(42.5f, oTasina, GetPosition(oWPPortal));

    cs_ActionPlayAnimation(43.0f, oAcolyte1, ANIMATION_LOOPING_WORSHIP, 0.75f, 18.0f);
    cs_ActionPlayAnimation(43.2f, oPreistess1, ANIMATION_LOOPING_WORSHIP, 0.75f, 18.0f);

    cs_ActionPlayAnimation(43.2f, oPreistess2, ANIMATION_LOOPING_WORSHIP, 0.75f, 18.0f);
    cs_ActionPlayAnimation(43.0f, oPreistess3, ANIMATION_LOOPING_WORSHIP, 0.75f, 18.0f);
    cs_ActionPlayAnimation(43.1f, oPreistess4, ANIMATION_LOOPING_WORSHIP, 0.75f, 18.0f);

    cs_ActionPlayAnimation(44.0f, oTasina, ANIMATION_FIREFORGET_READ);
    cs_ActionPlayAnimation(45.0f, oTasina, ANIMATION_LOOPING_CONJURE2, 1.0f, 14.0f);

    cs_CameraSetFacing(45.0f, 30.0f, 10.6f, 75.0f, CAMERA_TRANSITION_TYPE_SLOW);

    cs_PlayAnimation(47.0f, oDevice1, ANIMATION_PLACEABLE_ACTIVATE);
    cs_PlayAnimation(47.0f, oDevice2, ANIMATION_PLACEABLE_ACTIVATE);
    cs_PlayAnimation(47.0f, oDevice3, ANIMATION_PLACEABLE_ACTIVATE);
    cs_PlayAnimation(47.0f, oDevice4, ANIMATION_PLACEABLE_ACTIVATE);

    cs_ApplyVFXToObject(54.0f, DURATION_TYPE_TEMPORARY, VFX_FNF_SCREEN_SHAKE, oVFX_Targ, 4.0f);
    cs_ActionPlayAnimation(55.0f, oTasina, ANIMATION_FIREFORGET_DODGE_DUCK, 0.3f);
    cs_ApplyVFXToObject(55.0f, DURATION_TYPE_INSTANT, VFX_FNF_WORD, oVFX_Targ);

    cs_ApplyEffectToObject(56.5f, DURATION_TYPE_INSTANT, eDamage, oHandAlter1);
    cs_ApplyEffectToObject(56.7f, DURATION_TYPE_INSTANT, eDamage, oHandAlter2);
    cs_ApplyEffectToObject(56.9f, DURATION_TYPE_INSTANT, eDamage, oHandAlter3);

    cs_ApplyVFXToObject(57.0f, DURATION_TYPE_INSTANT, VFX_FNF_IMPLOSION, oVFX_Targ);
    cs_ApplyVFXToObject(59.6f, DURATION_TYPE_INSTANT, VFX_FNF_SUMMONDRAGON, oVFX_Targ);

    cs_JumpToObject(60.1f, oPCCopy1, oWPPlayer1_1);
    cs_JumpToObject(60.1f, oGarm, oWPGarm1);
    cs_JumpToObject(60.1f, oNisar, oWPNisar1);
    cs_JumpToObject(60.1f, oPoly, oWPPoly1);
    cs_JumpToObject(60.1f, oPCCopy2, oWPPlayer2_1);
    cs_JumpToObject(60.1f, oPCCopy3, oWPPlayer3_1);
    cs_JumpToObject(60.1f, oPCCopy4, oWPPlayer4_1);

    cs_CameraSetFacing(60.0f, 100.0f, 6.0f, 75.0f, CAMERA_TRANSITION_TYPE_SLOW);
    cs_ActionStartConversation(61.0f, cs_GetPCObject(), oTasina, "a3_tasina");
}
