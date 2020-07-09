//::///////////////////////////////////////////////
//:: cut_a3_tasina2b
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has infuriated Tasina and as a result
    tasina has resurected the spirits of the
    original clergy. She has been consumed and
    the battle begins.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_cutscene"

const string sTasina001 = "Grrr!";
const string sTasina002 = "This whole process has been nothing short of infuriating!";
const string sAcolyte001 = "Please calm yourself, Sister Tasina. The ritual must proceed.";
const string sTasina003 = "Umberlee! Make me a vessel of your godhood!!";
const string sAcolyte002 = "Wha-What is happening?";
const string sTasina004 = "No, sisters! Look what has become of us! This... this is all your fault!";

//const string sTasina005 = "Kill them! Kill them all!";
//const string sAcolyte003 = "AAAHHHHH!";
//const string sPriestess001 = "Tasina!?";
//const string sPriestess002 = "AAHHH!";
//const string sPriestess003 = "PLACEHOLDER.PLACEHOLDER.PLACEHOLDER.";
//const string sGarm001 = "This bad.";
//const string sNisar001 = "'Bad' would be an understatment.";

void main()
{
    object oArea = OBJECT_SELF;
    object oModule = GetModule();
    object oWPHolding = GetObjectByTag("A3_TSN_HOLDING");
    object oWPPortal = GetObjectByTag("A3_TMPL_PORTAL");

    object oRealNisar = GetObjectByTag("a2_hench_nisar");
    object oRealGarm = GetObjectByTag("a1_hench_garm");

    object oNisar = GetLocalObject(oArea, "oNisar");
    object oGarm = GetLocalObject(oArea, "oGarm");
    object oPoly = GetLocalObject(oArea, "oPoly");

    object oPCCopy1 = GetLocalObject(oArea, "oPCCopy1");
    object oPCCopy2 = GetLocalObject(oArea, "oPCCopy2");
    object oPCCopy3 = GetLocalObject(oArea, "oPCCopy3");
    object oPCCopy4 = GetLocalObject(oArea, "oPCCopy4");

    object oWPGarm1_2 = GetObjectByTag("A3_TSN_GARM01_2");
    object oWPNisar1_2 = GetObjectByTag("A3_TSN_NISAR01_2");
    object oWPPlayer1_2 = GetObjectByTag("A3_TSN_PCRAPPR1_2");
    object oWPPlayer2_2 = GetObjectByTag("A3_TSN_PCRAPPR2_2");
    object oWPPlayer3_2 = GetObjectByTag("A3_TSN_PCRAPPR3_2");
    object oWPPlayer4_2 = GetObjectByTag("A3_TSN_PCRAPPR4_2");

    object oAcolyte1 = GetObjectByTag("a3_cutacolyte_1");
    object oPreistess1 = GetObjectByTag("a3_cutpriestess_1");
    object oPreistess2 = GetObjectByTag("a3_cutpriestess_2");
    object oPreistess3 = GetObjectByTag("a3_cutpriestess_3");
    object oPreistess4 = GetObjectByTag("a3_cutpriestess_4");

    object oElemental1 = CreateObject(OBJECT_TYPE_CREATURE, "a3_clrchrpy_cut", GetLocation(oWPHolding));
    object oElemental2 = CreateObject(OBJECT_TYPE_CREATURE, "a3_clrchrpy_cut", GetLocation(oWPHolding));
    object oElemental3 = CreateObject(OBJECT_TYPE_CREATURE, "a3_clrchrpy_cut", GetLocation(oWPHolding));
    object oElemental4 = CreateObject(OBJECT_TYPE_CREATURE, "a3_clrchrpy_cut", GetLocation(oWPHolding));
    object oElemental5 = CreateObject(OBJECT_TYPE_CREATURE, "a3_clrchrpy_cut", GetLocation(oWPHolding));

    object oStatue1 = GetObjectByTag("a3_fishstatue1");
    object oStatue2 = GetObjectByTag("a3_fishstatue2");;
    object oStatue3 = GetObjectByTag("a3_fishstatue3");;
    object oStatue4 = GetObjectByTag("a3_fishstatue4");;

    object oTasina = GetObjectByTag("a3_tasina");
    object oTasHag = CreateObject(OBJECT_TYPE_CREATURE, "a3_tashag_cut", GetLocation(oWPHolding));

    location lTasHag = GetLocation(oTasina);
    location lElemental1 = GetLocation(oAcolyte1);
    location lElemental2 = GetLocation(oPreistess1);
    location lElemental3 = GetLocation(oPreistess2);
    location lElemental4 = GetLocation(oPreistess3);
    location lElemental5 = GetLocation(oPreistess4);

    effect eDamage = EffectDamage(1000);
    effect eGhost = EffectCutsceneGhost();
    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);

    effect eSpellImpactA = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    effect eSpellImpactB = EffectVisualEffect(VFX_IMP_PULSE_WATER);
    effect eSpellImpact = EffectLinkEffects(eSpellImpactA, eSpellImpactB);

    effect eTasChange = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
    effect eDisappear = EffectDisappear();

    effect eMagicUsedA = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    effect eMagicUsedB = EffectVisualEffect(354);
    effect eMagicUsed = EffectLinkEffects(eMagicUsedA, eMagicUsedB);
    effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oTasHag);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oElemental1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oElemental2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oElemental3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oElemental4);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oElemental5);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oTasHag, 60.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oElemental1, 60.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oElemental2, 60.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oElemental3, 60.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oElemental4, 60.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oElemental5, 60.0f);

        //Start scene - Tasina is enraged
    cs_CameraSetFacing(0.0f, 120.0f, 6.5f, 74.0f, CAMERA_TRANSITION_TYPE_MEDIUM);

    cs_SpeakString(1.0f, oTasina, sTasina001);
    cs_PlayAnimation(1.50f, oTasina, ANIMATION_LOOPING_TALK_FORCEFUL, 1.0f, 10.0f);

    cs_SpeakString(3.0f, oTasina, sTasina002);

    cs_CameraSetFacing(7.0f, 125.0f, 11.5f, 73.0f, CAMERA_TRANSITION_TYPE_SLOW);
    cs_ActionMoveToObject(7.0f, oAcolyte1, oTasina, FALSE, 0.5f);
    cs_SpeakString(7.5f, oAcolyte1, sAcolyte001);

    cs_SpeakString(11.0f, oTasina, sTasina003);
    cs_PlayAnimation(12.5f, oTasina, ANIMATION_LOOPING_CONJURE2, 0.5f, 10.0f);
    cs_ApplyVFXToObject(14.0f, DURATION_TYPE_INSTANT, VFX_FNF_WAIL_O_BANSHEES, oTasina);

    cs_SpeakString(15.0f, oAcolyte1, sAcolyte002);

    //Tasina summons the power of umberlee - by accident
    cs_CameraSetFacing(17.0f, 210.0f, 11.7f, 70.0f, CAMERA_TRANSITION_TYPE_SLOW);
    cs_CameraSetFacing(20.0f, 300.0f, 13.8f, 65.0f, CAMERA_TRANSITION_TYPE_SLOW);
    cs_CameraSetFacing(23.0f, 30.0f, 12.2f, 70.0f, CAMERA_TRANSITION_TYPE_SLOW);
    cs_CameraSetFacing(26.0f, 120.0f, 6.0f, 75.0f, CAMERA_TRANSITION_TYPE_SLOW);

    DelayCommand(19.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eMagicUsed, GetLocation(oStatue1)));
    DelayCommand(19.5f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eMagicUsed, GetLocation(oStatue2)));
    DelayCommand(20.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eMagicUsed, GetLocation(oStatue3)));
    DelayCommand(20.5f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eMagicUsed, GetLocation(oStatue4)));

    cs_ApplyEffectToObject(20.0f, DURATION_TYPE_TEMPORARY, eDamage, oStatue1);
    cs_ApplyEffectToObject(20.5f, DURATION_TYPE_TEMPORARY, eDamage, oStatue2);
    cs_ApplyEffectToObject(21.0f, DURATION_TYPE_TEMPORARY, eDamage, oStatue3);
    cs_ApplyEffectToObject(21.5f, DURATION_TYPE_TEMPORARY, eDamage, oStatue4);

    DelayCommand(22.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eSpellImpact, GetLocation(oAcolyte1)));
    DelayCommand(23.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eSpellImpact, GetLocation(oPreistess1)));
    DelayCommand(24.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eSpellImpact, GetLocation(oPreistess2)));
    DelayCommand(25.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eSpellImpact, GetLocation(oPreistess3)));
    DelayCommand(26.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eSpellImpact, GetLocation(oPreistess4)));

    cs_DestroyObject(22.5f, oAcolyte1);
    cs_DestroyObject(23.5f, oPreistess1);
    cs_DestroyObject(24.5f, oPreistess2);
    cs_DestroyObject(25.5f, oPreistess3);
    cs_DestroyObject(26.5f, oPreistess4);

    cs_RemoveVFXFromObject(24.5f, oElemental1, TRUE);
    cs_RemoveVFXFromObject(24.5f, oElemental2, TRUE);
    cs_RemoveVFXFromObject(24.5f, oElemental3, TRUE);
    cs_RemoveVFXFromObject(24.5f, oElemental4, TRUE);
    cs_RemoveVFXFromObject(24.5f, oElemental5, TRUE);

    cs_JumpToLocation(22.5f, oElemental1, lElemental1);
    cs_JumpToLocation(23.5f, oElemental2, lElemental2);
    cs_JumpToLocation(24.5f, oElemental3, lElemental3);
    cs_JumpToLocation(25.5f, oElemental4, lElemental4);
    cs_JumpToLocation(26.5f, oElemental5, lElemental5);

    DelayCommand(28.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        eTasChange, GetLocation(oTasina)));
    cs_DestroyObject(28.5f, oTasina);
    cs_JumpToLocation(28.5f, oTasHag, lTasHag);
    cs_RemoveVFXFromObject(29.5f, oTasHag, TRUE);

    cs_PlayAnimation(29.5f, oTasHag, ANIMATION_LOOPING_PAUSE_TIRED, 0.8f, 4.0f);

    // Tasina threatens the player and combat ensues
    cs_SpeakString(33.0f, oTasHag, sTasina004);
    cs_PlayAnimation(33.0f, oTasHag, ANIMATION_LOOPING_TALK_FORCEFUL, 1.2f, 4.0f);

    cs_ApplyEffectToObject(36.1f, DURATION_TYPE_PERMANENT, eDisappear, oElemental1);
    cs_ApplyEffectToObject(36.5f, DURATION_TYPE_PERMANENT, eDisappear, oElemental2);
    cs_ApplyEffectToObject(37.5f, DURATION_TYPE_PERMANENT, eDisappear, oElemental3);
    cs_ApplyEffectToObject(37.2f, DURATION_TYPE_PERMANENT, eDisappear, oElemental4);
    cs_ApplyEffectToObject(36.9f, DURATION_TYPE_PERMANENT, eDisappear, oElemental5);

    cs_ActionMoveToObject(37.0f, oGarm, oWPGarm1_2, TRUE);
    cs_ActionMoveToObject(37.0f, oNisar, oWPNisar1_2, TRUE);
    cs_ActionMoveToObject(37.0f, oPoly, oWPPlayer1_2, TRUE);
    cs_ActionMoveToObject(37.0f, oPCCopy1, oWPPlayer1_2, TRUE);
    cs_ActionMoveToObject(37.0f, oPCCopy2, oWPPlayer2_2, TRUE);
    cs_ActionMoveToObject(37.0f, oPCCopy3, oWPPlayer3_2, TRUE);
    cs_ActionMoveToObject(37.0f, oPCCopy4, oWPPlayer4_2, TRUE);

    cs_ActionMoveToObject(37.5f, oTasHag, oWPPortal);
    cs_PlayAnimation(38.0f, oTasHag, ANIMATION_LOOPING_TALK_FORCEFUL, 1.2f, 4.0f);

    cs_JumpToLocation(39.0f, oRealNisar, GetLocation(oWPNisar1_2));
    cs_JumpToLocation(39.0f, oRealGarm, GetLocation(oWPGarm1_2));

    cs_JumpToLocation(40.0f, cs_GetPCObject(0), GetLocation(oWPPlayer1_2));
    cs_JumpToLocation(40.0f, cs_GetPCObject(1), GetLocation(oWPPlayer2_2));
    cs_JumpToLocation(40.0f, cs_GetPCObject(2), GetLocation(oWPPlayer3_2));
    cs_JumpToLocation(40.0f, cs_GetPCObject(3), GetLocation(oWPPlayer4_2));

    cs_DestroyObject(40.5f, oTasHag);

    cs_DestroyObject(40.5f, oGarm);
    cs_DestroyObject(40.5f, oNisar);
    cs_DestroyObject(40.5f, oPoly);

    cs_DestroyObject(40.5f, oPCCopy1);
    cs_DestroyObject(40.5f, oPCCopy2);
    cs_DestroyObject(40.5f, oPCCopy3);
    cs_DestroyObject(40.5f, oPCCopy4);

    cs_CameraDoFade(38.0f, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FASTEST);

    cs_EndCutscene(41.5f, TRUE, TRUE, FADE_SPEED_FAST);
    DelayCommand(41.5f, ExecuteScript("exe_a3_hagfight", oArea));
}
