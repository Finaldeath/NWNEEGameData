//::///////////////////////////////////////////////
//:: cut_a3_tasina2a
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has convinced tasina that Umberlee is
    evil, as they deside to abandon the temple the
    Guardian beast attacks.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_cutscene"

//const string sAcolyte001 = "The Dweller stirs, Sister Tasina...";
//const string sTasina001 = "It senses our delay.";
//const string sTasina002 = "We have angered our goddess, sisters! We must stand and face her wrath.";
//const string sTasina003 = "To arms, pirates! The Dweller is a caged beast and we must put it from its misery!";
//const string sAcolyte002 = "'We' mistress? 'We' need to leave before Umberlee destroys us in her fury!";
//const string sTasina004 = "No! These are our pirates! I won't leave them here!";
//const string sPriestess001 = "Forgive me, Sister Tasina...";
//const string sPriestess002 = "Save yourselves, pirates, and survive this battle if you can. We'll await you aboard the Rose.";

const string sAcolyte001 = "The Aspects stir, Sister Tasina...";
const string sTasina001 = "They sense our delay.";
const string sTasina002 = "We have angered our goddess, sisters! We must stand and face her wrath.";
const string sAcolyte002 = "'We' mistress? 'We' need to leave before Umberlee destroys us in her fury!";
const string sTasina004 = "No! These are our pirates! I won't leave them here!";
const string sPriestess001 = "Forgive me, Sister Tasina...";
const string sPriestess002 = "Save yourselves, pirates, and survive this battle if you can. We'll await you aboard the Rose.";

//const string sGarm001 = "No, this is not fair! Big creature is not 'eater of Garm', even if garm is a little 'off' right now.";
//const string sGarm002 = "Here that, ugly fish! Garm will be eater of you!";
//const string sNisar001 = "I won't meet my end by any ugly fish!";
//const string sNisar002 = "Let's bring the roof down arround his slimey ears!";

void main()
{
    object oArea = OBJECT_SELF;
    object oModule = GetModule();

    object oRealNisar = GetObjectByTag("a2_hench_nisar");
    object oRealGarm = GetObjectByTag("a1_hench_garm");

    object oNisar = GetLocalObject(oArea, "oNisar");
    object oGarm = GetLocalObject(oArea, "oGarm");
    object oPoly = GetLocalObject(oArea, "oPoly");

    object oPCCopy1 = GetLocalObject(oArea, "oPCCopy1");
    object oPCCopy2 = GetLocalObject(oArea, "oPCCopy2");
    object oPCCopy3 = GetLocalObject(oArea, "oPCCopy3");
    object oPCCopy4 = GetLocalObject(oArea, "oPCCopy4");

    object oTasina = GetObjectByTag("a3_tasina");

    object oAcolyte1 = GetObjectByTag("a3_cutacolyte_1");
    object oPreistess1 = GetObjectByTag("a3_cutpriestess_1");
    object oPreistess2 = GetObjectByTag("a3_cutpriestess_2");
    object oPreistess3 = GetObjectByTag("a3_cutpriestess_3");
    object oPreistess4 = GetObjectByTag("a3_cutpriestess_4");
    object oPreistess5 = GetObjectByTag("a3_cutpriestess_5");

    object oWPMonster = GetObjectByTag("WP_BEASTSPWN_A");
    object oMonster = CreateObject(OBJECT_TYPE_PLACEABLE, "a3_monster", GetLocation(oWPMonster));
    object oSNDRoar1 = GetObjectByTag("snd_beastroar1");
    object oSNDRoar2 = GetObjectByTag("snd_beastroar2");

    object oWPNisar1 = GetObjectByTag("A3_TSN_NISAR01");
    object oWPGarm1 = GetObjectByTag("A3_TSN_GARM01");


    object oWPAvatar = GetObjectByTag("cs_wp_avatar");
    object oWPAvatar2 = GetObjectByTag("cs_wp_avatar2");
    object oAvatar = CreateObject(OBJECT_TYPE_CREATURE, "potsc_avatar", GetLocation(oWPAvatar));
    ChangeToStandardFaction(oAvatar, STANDARD_FACTION_COMMONER);
    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oAvatar, 12.0));
    cs_ClearAllActions(0.0, oAvatar);

    effect eSpellIMP = EffectVisualEffect(VFX_FNF_PWSTUN);

    AssignCommand(oMonster, SetFacingPoint(GetPosition(oTasina)));

    //Start scene
    cs_CameraSetFacing(0.0f, 120.0f, 6.5f, 74.0f, CAMERA_TRANSITION_TYPE_MEDIUM);

    cs_SoundObjectPlay(0.5f, oSNDRoar1);
    cs_SoundObjectStop(5.0f, oSNDRoar1);

    cs_ApplyVFXToObject(0.5f, DURATION_TYPE_TEMPORARY, VFX_FNF_SCREEN_SHAKE, oMonster, 20.0f);

    // The acolyte panicks as she realises the Guardian has turned on them
    cs_ActionSetFacingPoint(1.0f, oAcolyte1, GetPosition(oWPMonster));
    cs_ActionSpeakString(1.0f, oAcolyte1, sAcolyte001);

    DelayCommand(1.0f, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,
        EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oMonster), 5.0f));

    cs_ActionSetFacingPoint(2.0f, oPreistess1, GetPosition(oWPMonster));
    cs_ActionSetFacingPoint(2.0f, oTasina, GetPosition(oWPMonster));
    cs_ActionSetFacingPoint(2.0f, oPCCopy1, GetPosition(oWPMonster));

    cs_ActionSpeakString(4.0f, oTasina, sTasina001);

    // close up on the guardian
    cs_CameraDoFade(8.8f, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FASTEST);
    cs_CameraUseCameraWaypoint(9.3f, 10);
    cs_CameraDoFade(9.8f, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_MEDIUM);

    DelayCommand(8.5f, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,
        EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oMonster), 5.0f));

    cs_MusicBattlePlay(9.0f);
    //cs_ActionSpeakString(9.0f, oTasina, "");
    //cs_ActionSpeakString(9.0f, oAcolyte1, "");

    cs_SoundObjectPlay(10.5f, oSNDRoar2);

    // avatar appears
    cs_ApplyVFXToObject(11.0, DURATION_TYPE_INSTANT, VFX_FNF_ELECTRIC_EXPLOSION, oAvatar);
    cs_PlayAnimation(13.0, oAvatar, ANIMATION_FIREFORGET_TAUNT);

    cs_ActionMoveToObject(34.0, oAvatar, oWPAvatar2, FALSE, 0.0);
    cs_ActionSetFacing(35.0, oAvatar, GetFacing(oWPAvatar2));

    cs_SoundObjectStop(15.0f, oSNDRoar2);

    DelayCommand(15.7f, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,
        EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oMonster), 5.0f));

    cs_CameraDoFade(15.8f, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FASTEST);
    cs_CameraUseCameraWaypoint(16.3f, 11);
    cs_CameraDoFade(16.8f, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    // Tasina imparts what she knows upon the player
    cs_ActionSetFacingPoint(17.0f, oTasina, GetPosition(oPCCopy1));
    cs_SpeakString(17.5f, oTasina, sTasina002);
    //cs_SpeakString(22.0f, oTasina, sTasina003);

    cs_ActionSetFacingPoint(19.0f, oAcolyte1, GetPosition(oTasina));
    cs_ActionSetFacingPoint(20.5f, oPreistess1, GetPosition(oTasina));
    cs_SpeakString(21.5f, oAcolyte1, sAcolyte002);

    cs_ActionSetFacingPoint(22.5f, oTasina, GetPosition(oAcolyte1));
    cs_SpeakString(25.5f, oTasina, sTasina004);
    cs_PlayAnimation(25.5f, oTasina, ANIMATION_LOOPING_TALK_FORCEFUL, 1.3f, 5.0f);

    // The Preistess portals Tasina out of the dungeon.
    cs_ActionMoveToObject(26.5f, oPreistess1, oTasina);
    cs_ActionCastFakeSpellAtObject(27.5f, oPreistess1, SPELL_MAGIC_WEAPON, oTasina);

    DelayCommand(29.0f, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,
        eSpellIMP, GetLocation(oTasina), 5.0f));
    cs_DestroyObject(29.5f, oTasina);

    cs_ActionSetFacingPoint(30.5f, oPreistess1, GetPosition(oAcolyte1));
    cs_SpeakString(30.5f, oPreistess1, sPriestess001);

    cs_ActionSetFacingPoint(33.0f, oPreistess1, GetPosition(oPCCopy1));
    cs_SpeakString(33.5f, oPreistess1, sPriestess002);

    cs_PlayAnimation(37.5f, oPreistess1, ANIMATION_LOOPING_CONJURE2, 1.0f, 5.0f);

    // portal the Acolytes
    DelayCommand(39.0f, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,
        eSpellIMP, GetLocation(oAcolyte1), 5.0f));
    cs_DestroyObject(39.5f, oAcolyte1);

    // portal the preistess
    DelayCommand(39.2f, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,
        eSpellIMP, GetLocation(oPreistess5), 5.0f));
    cs_DestroyObject(39.7f, oPreistess5);
    DelayCommand(39.4f, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,
        eSpellIMP, GetLocation(oPreistess4), 5.0f));
    cs_DestroyObject(39.9f, oPreistess4);
    DelayCommand(39.6f, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,
        eSpellIMP, GetLocation(oPreistess3), 5.0f));
    cs_DestroyObject(40.1f, oPreistess3);
    DelayCommand(39.8f, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,
        eSpellIMP, GetLocation(oPreistess2), 5.0f));
    cs_DestroyObject(40.3f, oPreistess2);
    DelayCommand(40.0f, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,
        eSpellIMP, GetLocation(oPreistess1), 5.0f));
    cs_DestroyObject(40.5f, oPreistess1);

    cs_JumpToLocation(42.5f, oRealNisar, GetLocation(oWPNisar1));
    cs_JumpToLocation(42.5f, oRealGarm, GetLocation(oWPGarm1));

    cs_JumpToLocation(42.5f, cs_GetPCObject(1), GetLocation(oPCCopy1));
    cs_JumpToLocation(42.5f, cs_GetPCObject(2), GetLocation(oPCCopy2));
    cs_JumpToLocation(42.5f, cs_GetPCObject(3), GetLocation(oPCCopy3));
    cs_JumpToLocation(42.5f, cs_GetPCObject(4), GetLocation(oPCCopy4));

    cs_DestroyObject(43.0f, oMonster);

    cs_DestroyObject(43.0f, oGarm);
    cs_DestroyObject(43.0f, oNisar);
    cs_DestroyObject(43.0f, oPoly);

    cs_DestroyObject(43.0f, oPCCopy1);
    cs_DestroyObject(43.0f, oPCCopy2);
    cs_DestroyObject(43.0f, oPCCopy3);
    cs_DestroyObject(43.0f, oPCCopy4);

    cs_CameraDoFade(41.5f, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_MEDIUM);
    cs_EndCutscene(43.0f, TRUE, TRUE, FADE_SPEED_FASTEST);

    DelayCommand(43.0f, ExecuteScript("exe_a3_vtrfight", oArea));
}
