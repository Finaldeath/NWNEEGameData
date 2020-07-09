//::///////////////////////////////////////////////
//:: cut_id1_narr03
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Third narrator cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 9, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"

// SPEAKSTRINGS
///////////////

const string S_NARRATION_1 = "Since when did the mighty Halaster rely on simple minions to promote his cause?";
const string S_NARRATION_2 = "Dark is the day when even the mighty must depend on underlings to carry out their orders and do what must be done.";
const string S_NARRATION_3 = "But, in the blackest depths of Undermountain, who gives the orders now? Is it some dark evil, or is it the mind of a mad man?";

const float VO_LENGTH_1 = 5.0;
const float VO_LENGTH_2 = 7.26;
const float VO_LENGTH_3 = 9.17;

const string TAG_AUDIO_VO_1 = "ID1_STATIC_narr3_1";
const string TAG_AUDIO_VO_2 = "ID1_STATIC_narr3_2";
const string TAG_AUDIO_VO_3 = "ID1_STATIC_narr3_3";

// CONSTANTS
//////////////

const string WP_HALASTER1 = "ID1_STATIC_CS_HALASTER31";
const string WP_HALASTER2 = "ID1_STATIC_CS_HALASTER32";
const string WP_HALASTER3 = "ID1_STATIC_CS_HALASTER33";
const string WP_NARR1 = "ID1_STATIC_CS_NARR31";
const string WP_PORTAL1 = "ID1_STATIC_CS_PORTAL6";
const string WP_PORTAL2 = "ID1_STATIC_CS_PORTAL5";
const string WP_PORTAL3 = "ID1_STATIC_CS_PORTAL4";
const string WP_MINION = "ID1_STATIC_CS_MINION";

const string TAG_NARRATOR = "id1_cs_narrator";
const string TAG_HALASTER = "id1_cs_halaster";
const string TAG_MINION1 = "id1_cs_nar3_min1";
const string TAG_MINION2 = "id1_cs_nar3_min2";
const string TAG_MINION3 = "id1_cs_nar3_min3";
const string TAG_AUDIO_LAUGH = "ID1_STATIC_halaster1";

// custom vfx - removed screen shake
const int VFX_FNF_FIRESTORM_NO_SHAKE = 580;
const int VFX_FNF_SUMMON_MONSTER_3_NO_SHAKE = 581;


void main()
{
    float fDelay;

    // using incremented delay type
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    // fog  - store current settings
    int nOriginalFogDay = GetFogColor(FOG_TYPE_SUN, OBJECT_SELF);
    int nOriginalFogNight = GetFogColor(FOG_TYPE_MOON, OBJECT_SELF);
    int nOriginalFogAmountDay = GetFogAmount(FOG_TYPE_SUN, OBJECT_SELF);
    int nOriginalFogAmountNight = GetFogAmount(FOG_TYPE_MOON, OBJECT_SELF);

    // Object setup

    // waypoints
    object oWP_Halaster1 = GetObjectByTagInArea(WP_HALASTER1);
    object oWP_Halaster2 = GetObjectByTagInArea(WP_HALASTER2);
    object oWP_Halaster3 = GetObjectByTagInArea(WP_HALASTER3);
    object oWP_Narrator1 = GetObjectByTagInArea(WP_NARR1);
    object oWP_Portal1 = GetObjectByTagInArea(WP_PORTAL1);
    object oWP_Portal2 = GetObjectByTagInArea(WP_PORTAL2);
    object oWP_Portal3 = GetObjectByTagInArea(WP_PORTAL3);
    object oWP_Minion = GetObjectByTagInArea(WP_MINION);

    // creatures
    object oCre_Narrator = CreateObject(OBJECT_TYPE_CREATURE, TAG_NARRATOR, cs_GetCameraWaypointLocation(31));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Narrator);
    object oCre_Narrator2 = CreateObject(OBJECT_TYPE_CREATURE, TAG_NARRATOR, GetLocation(oWP_Narrator1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Narrator);

    object oCre_Halaster = CreateObject(OBJECT_TYPE_CREATURE, TAG_HALASTER, GetLocation(oWP_Halaster3));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectMovementSpeedIncrease(140), oCre_Halaster);

    object oCre_Minion1 = CreateObject(OBJECT_TYPE_CREATURE, TAG_MINION1, GetLocation(oWP_Portal1));
    object oCre_Minion2 = CreateObject(OBJECT_TYPE_CREATURE, TAG_MINION2, GetLocation(oWP_Portal2));
    object oCre_Minion3 = CreateObject(OBJECT_TYPE_CREATURE, TAG_MINION3, GetLocation(oWP_Portal3));
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Minion1);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Minion2);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Minion3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectMovementSpeedIncrease(99), oCre_Minion3);

    // placeables

    // sounds
    object oAud_Laugh = GetObjectByTagInArea(TAG_AUDIO_LAUGH);
    object oAud_VO1 = GetObjectByTagInArea(TAG_AUDIO_VO_1);
    object oAud_VO2 = GetObjectByTagInArea(TAG_AUDIO_VO_2);
    object oAud_VO3 = GetObjectByTagInArea(TAG_AUDIO_VO_3);

    //==========================================================================

    // set fog
    cs_SetFogColor(0.0, FOG_TYPE_ALL, FOG_COLOR_BLACK);
    cs_SetFogAmount(0.0, FOG_TYPE_ALL, 50);

    // initial camera
    cs_CameraUseCameraWaypoint(1.0, 31);

    // set Halaster moving, and set facing
    cs_ActionMoveToObject(0.8, oCre_Halaster, oWP_Halaster1, TRUE, 0.01);
    cs_ActionSetFacingPoint(0.1, oCre_Halaster, GetPosition(oWP_Portal1));

    // fade-in
    cs_CameraDoFade(0.2, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    // VO 1
    cs_SoundObjectPlay(1.0, oAud_VO1);
    cs_SpeakString(0.0, oCre_Narrator, S_NARRATION_1);

    fDelay = cs_GetDelay();
    cs_PlayAnimation(1.3, oCre_Halaster, ANIMATION_LOOPING_TALK_FORCEFUL, 2.0, 1.3);
    cs_ApplyVFXToObject(0.4, DURATION_TYPE_INSTANT, VFX_FNF_SUMMON_MONSTER_3_NO_SHAKE, oCre_Minion1, 0.0, FALSE, FALSE);
    cs_RemoveVFXFromObject(0.7, oCre_Minion1);
    cs_ActionMoveToObject(0.0, oCre_Halaster, oWP_Halaster2, TRUE, 0.01);
    cs_ActionSetFacing(0.1, oCre_Halaster, GetFacingBetweenObjects(oWP_Halaster2, oWP_Portal2));
    cs_ActionMoveToObject(0.6, oCre_Minion1, oWP_Minion);
    cs_ResetDelay(-1.0, fDelay);

    // just before camera 2, jump Halaster to make sure he's reach his destination
    //cs_ClearAllActions(VO_LENGTH_1 - 0.5, oCre_Halaster);
    //cs_ActionJumpToObject(0.3, oCre_Halaster, oWP_Halaster2);
    //cs_ActionSetFacingPoint(0.1, oCre_Halaster, GetPosition(oWP_Portal2));

    // camera 2
    cs_CameraUseCameraWaypoint(VO_LENGTH_1, 32);
    cs_ActionJumpToLocation(0.0, oCre_Narrator, cs_GetCameraWaypointLocation(32));

    // VO 2
    cs_SoundObjectPlay(0.5, oAud_VO2);
    cs_SpeakString(0.0, oCre_Narrator, S_NARRATION_2);

    fDelay = cs_GetDelay();
    cs_PlayAnimation(2.5, oCre_Halaster, ANIMATION_LOOPING_TALK_FORCEFUL, 2.0, 1.3);
    cs_ApplyVFXToObject(0.4, DURATION_TYPE_INSTANT, VFX_FNF_SUMMON_MONSTER_3_NO_SHAKE, oCre_Minion2, 0.0, FALSE, FALSE);
    cs_RemoveVFXFromObject(0.7, oCre_Minion2);
    cs_PlayAnimation(0.2, oCre_Minion2, ANIMATION_FIREFORGET_TAUNT);
    cs_ActionMoveToObject(0.4, oCre_Minion2, oWP_Minion);
    cs_ActionSetFacing(1.9, oCre_Halaster, GetFacingBetweenObjects(oWP_Halaster2, oWP_Portal3));
    cs_ResetDelay(-1.0, fDelay);


    // camera 3
    cs_CameraUseCameraWaypoint(VO_LENGTH_2, 33);
    cs_ActionJumpToLocation(0.0, oCre_Narrator, cs_GetCameraWaypointLocation(33));

    // VO 3
    cs_SoundObjectPlay(0.2, oAud_VO3);
    cs_SpeakString(0.0, oCre_Narrator, S_NARRATION_3);

    fDelay = cs_GetDelay();
    cs_PlayAnimation(2.0, oCre_Halaster, ANIMATION_LOOPING_TALK_FORCEFUL, 2.0, 2.0);
    cs_ApplyVFXToObject(1.0, DURATION_TYPE_INSTANT, VFX_FNF_SUMMON_MONSTER_3_NO_SHAKE, oCre_Minion3, 0.0, FALSE, FALSE);
    cs_RemoveVFXFromObject(0.5, oCre_Minion3);
    cs_ActionMoveToObject(0.6, oCre_Minion3, oWP_Minion);
    cs_ResetDelay(-1.0, fDelay);

    // Halaster laugh
    cs_SoundObjectPlay(VO_LENGTH_3 - 1.5, oAud_Laugh);
    cs_PlayAnimation(0.0, oCre_Halaster, ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 3.0);

    // fade-out
    cs_CameraDoFade(1.5, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);

    // clean-up
    cs_DestroyObject(2.0, oCre_Halaster);
    cs_DestroyObject(0.0, oCre_Narrator);
    cs_DestroyObject(0.0, oCre_Narrator2);
    cs_DestroyObject(0.0, oCre_Minion1);
    cs_DestroyObject(0.0, oCre_Minion2);
    cs_DestroyObject(0.0, oCre_Minion3);

    cs_SoundObjectStop(0.0, oAud_Laugh);
    cs_SoundObjectStop(0.0, oAud_VO1);
    cs_SoundObjectStop(0.0, oAud_VO2);
    cs_SoundObjectStop(0.0, oAud_VO3);

    // restore fog
    cs_SetFogColor(0.0, FOG_TYPE_MOON, nOriginalFogNight);
    cs_SetFogColor(0.0, FOG_TYPE_SUN, nOriginalFogDay);
    cs_SetFogAmount(0.0, FOG_TYPE_MOON, nOriginalFogAmountNight);
    cs_SetFogAmount(0.0, FOG_TYPE_SUN, nOriginalFogAmountDay);

    cs_EndCutscene(1.5, FALSE, TRUE);
}
