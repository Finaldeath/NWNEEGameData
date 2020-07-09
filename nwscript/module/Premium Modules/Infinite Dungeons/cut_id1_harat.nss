//::///////////////////////////////////////////////
//:: cut_id1_harat
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Harat boss battle intro cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 8, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"
#include "inc_id1_harat"

// SPEAKSTRINGS
///////////////

const string S_HARAT = "Fools, the God of Darkness knows no mercy!";

// CONSTANTS
//////////////

const int MUSIC_SCENE = TRACK_CRYPT2;
const int MUSIC_BATTLE = 76; // ID music

const string WP_MINION1 = "ID1_STATIC_WP_CS_MINION1";
const string WP_MINION2 = "ID1_STATIC_WP_CS_MINION2";
const string WP_MINION3 = "ID1_STATIC_WP_CS_MINION3";
const string WP_HARAT1 = "ID1_STATIC_WP_CS_HARAT1";
const string WP_HARAT2 = "ID1_STATIC_WP_CS_HARAT2";
const string WP_HARAT3 = "ID1_STATIC_WP_CS_HARAT3";
const string WP_HARAT4 = "ID1_STATIC_WP_CS_HARAT4";
const string WP_HARAT5 = "ID1_STATIC_WP_CS_HARAT5";
const string WP_HARAT_TARGET = "ID1_STATIC_WP_CS_HARAT_TARGET";
const string WP_IMP1 = "ID1_STATIC_WP_CS_IMP1";
const string WP_IMP2 = "ID1_STATIC_WP_CS_IMP2";
const string WP_IMP3 = "ID1_STATIC_WP_CS_IMP3";
const string WP_IMP4 = "ID1_STATIC_WP_CS_IMP4";
const string WP_IMP5 = "ID1_STATIC_WP_CS_IMP5";

const string TAG_MINION = "id1_cs_hrt_min";
const string TAG_HARAT = "id1_cs_hrt_harat";
const string TAG_HARAT_SPEAKER = "id1_cs_hrt_spkr";
const string TAG_IMP = "id1_cs_hrt_imp";
const string TAG_LEVER = "ID1_STATIC_CHAIN_LEVER";

void ChangeMinionFaction(object oCreature, int nCutNumber);

void main()
{
    // using incremented delay type
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    int nCutNumber = GetLocalInt(OBJECT_SELF, "cs_last_cut_number");

    // Object setup

    // waypoints
    object oWP_Minion1 = GetObjectByTagInArea(WP_MINION1);
    object oWP_Minion2 = GetObjectByTagInArea(WP_MINION2);
    object oWP_Minion3 = GetObjectByTagInArea(WP_MINION3);
    object oWP_Harat1 = GetObjectByTagInArea(WP_HARAT1);
    object oWP_Harat2 = GetObjectByTagInArea(WP_HARAT2);
    object oWP_Harat3 = GetObjectByTagInArea(WP_HARAT3);
    object oWP_Harat4 = GetObjectByTagInArea(WP_HARAT4);
    object oWP_Harat5 = GetObjectByTagInArea(WP_HARAT5);
    object oWP_HaratTarget = GetObjectByTagInArea(WP_HARAT_TARGET);
    object oWP_Imp1 = GetObjectByTagInArea(WP_IMP1);
    object oWP_Imp2 = GetObjectByTagInArea(WP_IMP2);
    object oWP_Imp3 = GetObjectByTagInArea(WP_IMP3);
    object oWP_Imp4 = GetObjectByTagInArea(WP_IMP4);
    object oWP_Imp5 = GetObjectByTagInArea(WP_IMP5);

    // creatures
    object oCre_Minion = CreateObject(OBJECT_TYPE_CREATURE, TAG_MINION, GetLocation(oWP_Minion1));
    object oCre_Imp = CreateObject(OBJECT_TYPE_CREATURE, TAG_IMP, GetLocation(oWP_Imp1));

    object oCre_Harat = CreateObject(OBJECT_TYPE_CREATURE, TAG_HARAT, GetLocation(oWP_Harat1));
    // Apply ghosty effect that represents invulnerabilty
    effect eGhost = EffectVisualEffect(VFX_DUR_PARALYZED);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_PARALYZED, oCre_Harat);

    object oCre_HaratSpeaker = CreateObject(OBJECT_TYPE_CREATURE, TAG_HARAT_SPEAKER, GetLocation(oWP_Harat3));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_HaratSpeaker);

    // placeables
    object oPla_Lever = GetNearestObjectByTag(TAG_LEVER, oWP_Minion1);

    // setup for chain effect
    int nSource1 = GetLocalInt(oPla_Lever, N_CHAIN_SOURCE_1);
    int nSource2 = GetLocalInt(oPla_Lever, N_CHAIN_SOURCE_2);
    int nSource3 = GetLocalInt(oPla_Lever, N_CHAIN_SOURCE_3);
    int nSource4 = GetLocalInt(oPla_Lever, N_CHAIN_SOURCE_4);
    object oSource1 = GetObjectByTag(CHAIN_SOURCE_PRFX + IntToString(nSource1));
    object oSource2 = GetObjectByTag(CHAIN_SOURCE_PRFX + IntToString(nSource2));
    object oSource3 = GetObjectByTag(CHAIN_SOURCE_PRFX + IntToString(nSource3));
    object oSource4 = GetObjectByTag(CHAIN_SOURCE_PRFX + IntToString(nSource4));
    effect eBeam = EffectBeam(VFX_BEAM_CHAIN, oCre_Harat, BODY_NODE_CHEST);


    //==========================================================================

    cs_MusicBackgroundChangeDay(0.0, MUSIC_SCENE);
    cs_MusicBackgroundChangeNight(0.0, MUSIC_SCENE);

    // initial camera
    cs_CameraUseCameraWaypoint(0.8, 1);

    // start Harat clumping around
    cs_ActionMoveToObject(0.8, oCre_Harat, oWP_Harat2, TRUE, 0.1);

    // start camera 2 movement
    cs_CameraUseCameraWaypoint(0.0, 2);

    // imp moves up
    cs_ActionMoveToObject(0.0, oCre_Imp, oWP_Imp2, FALSE, 0.1);

    // fade-in
    cs_CameraDoFade(0.5, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    // imp laughs
    cs_PlayAnimation(3.0, oCre_Imp, ANIMATION_FIREFORGET_SPASM);
    cs_PlayVoiceChat(0.0, oCre_Imp, VOICE_CHAT_LAUGH);

    // imp fires magic missile at lever guardian. what a jerk.
    cs_ActionCastSpellAtObject(1.0, oCre_Imp, SPELL_MAGIC_MISSILE, oCre_Minion);

    // move Harat into position now
    cs_ActionMoveToObject(0.0, oCre_Harat, oWP_Harat3, TRUE, 0.1);
    cs_ActionSetFacing(0.1, oCre_Harat, GetFacingBetweenObjects(oWP_Harat3, oWP_Harat4));

    // lever guardian falls down
    cs_PlayAnimation(2.75, oCre_Minion, ANIMATION_LOOPING_DEAD_BACK, 1.0, 3.0);
    // knocks lever in the process
    cs_PlayAnimation(0.2, oPla_Lever, ANIMATION_PLACEABLE_ACTIVATE);

    // camera 3 & 4 (to show beam effects hitting Harat)
    cs_CameraUseCameraWaypoint(0.3, 3);
    cs_CameraUseCameraWaypoint(0.05, 4);

    // beam effect stuff
    cs_ClearAllActions(0.4, oCre_Harat);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_TEMPORARY, eBeam, oSource1, 4.0);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_TEMPORARY, eBeam, oSource2, 4.0);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_TEMPORARY, eBeam, oSource3, 4.0);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_TEMPORARY, eBeam, oSource4, 4.0);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_INSTANT, VFX_FNF_PWSTUN, oCre_Harat, 0.0, FALSE, FALSE);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_INSTANT, VFX_IMP_BREACH, oCre_Harat, 0.0, FALSE, FALSE);

    cs_MusicBackgroundChangeDay(0.0, MUSIC_BATTLE);
    cs_MusicBackgroundChangeNight(0.0, MUSIC_BATTLE);

    // Harat's pissed
    cs_PlayAnimation(0.2, oCre_Harat, ANIMATION_LOOPING_SPASM, 1.0, 3.5);
    cs_PlayVoiceChat(0.0, oCre_Harat, VOICE_CHAT_PAIN1);
    // move imp
    cs_ActionMoveToObject(0.0, oCre_Imp, oWP_Imp3, FALSE, 0.1);
    // remove first vfx from Harat
    cs_RemoveVFXFromObject(0.50, oCre_Harat);
    // another harat sound
    cs_PlayVoiceChat(1.0, oCre_Harat, VOICE_CHAT_PAIN2);
    cs_PlayVoiceChat(1.0, oCre_Harat, VOICE_CHAT_PAIN1);
    // another vfx
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_INSTANT, VFX_FNF_LOS_EVIL_10, oCre_Harat);


    // minions turn to harat
    cs_SetFacingPoint(0.5, oCre_Minion, GetPosition(oWP_Harat3));
    cs_SetFacingPoint(0.0, oCre_Imp, GetPosition(oWP_Harat3));

    // Harat turns to minions, says something
    cs_ActionSetFacing(1.5, oCre_Harat, GetFacingBetweenObjects(oWP_Harat3, oWP_Harat4));
    cs_SpeakString(0.3, oCre_HaratSpeaker, S_HARAT);

    cs_ActionMoveToObject(0.8, oCre_Minion, oWP_Minion2, FALSE, 0.0);
    cs_ActionMoveToObject(0.5, oCre_Imp, oWP_Imp4, FALSE, 0.0);

    // set minion's faction - is set to commoner at first, so the imp's magic
    // missile works properly. We now set it to hostile so harat's spells work
    DelayCommand(cs_GetDelay(), ChangeMinionFaction(oCre_Minion, nCutNumber));
    // also make sure both minions are killable
    cs_SetPlotFlag(0.0, oCre_Imp, FALSE);
    cs_SetImmortal(0.0, oCre_Imp, FALSE);
    cs_SetPlotFlag(0.0, oCre_Minion, FALSE);
    cs_SetImmortal(0.0, oCre_Minion, FALSE);

    // Destroys minions. Fireball should catch both at once.
    //cs_ActionCastSpellAtObject(0.7, oCre_Harat, SPELL_FIREBALL, oCre_Imp, METAMAGIC_ANY, TRUE);
    cs_ActionCastSpellAtLocation(0.7, oCre_Harat, SPELL_FIREBALL, GetLocation(oWP_HaratTarget), METAMAGIC_ANY, TRUE);
    cs_PlayAnimation(0.1, oCre_Minion, ANIMATION_LOOPING_TALK_PLEADING, 1.0, 5.0);
    cs_PlayVoiceChat(0.4, oCre_Harat, VOICE_CHAT_GATTACK2);
    // camera 5
    cs_CameraUseCameraWaypoint(0.3, 5);
    cs_PlayVoiceChat(0.5, oCre_Harat, VOICE_CHAT_GATTACK1);

    // camera 6
    cs_CameraUseCameraWaypoint(2.0, 6);

    // Harat walks away
    cs_ActionMoveToObject(1.5, oCre_Harat, oWP_Harat5);

    // fade-out
    cs_CameraDoFade(2.5, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);

    // clean-up
    cs_DestroyObject(2.0, oCre_Minion);
    cs_DestroyObject(0.0, oCre_Imp);
    cs_DestroyObject(0.0, oCre_Harat);
    cs_DestroyObject(0.0, oCre_HaratSpeaker);

    // restore lever to original position
    cs_PlayAnimation(0.0, oPla_Lever, ANIMATION_PLACEABLE_DEACTIVATE, 1.0, 0.0, TRUE);

    cs_EndCutscene(1.0);
}

void ChangeMinionFaction(object oCreature, int nCutNumber)
{
    if(csm_CutsceneAborted(nCutNumber, OBJECT_SELF)) return;

    ChangeToStandardFaction(oCreature, STANDARD_FACTION_HOSTILE);
}
