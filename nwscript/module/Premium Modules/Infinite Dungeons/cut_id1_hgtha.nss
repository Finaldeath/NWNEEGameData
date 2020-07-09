//::///////////////////////////////////////////////
//:: cut_id1_hgtha
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Hagatha boss battle intro cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 9, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"

// SPEAKSTRINGS
///////////////

const string S_MINION1_1 = "Um... Hag... I mean, Widow Hagatha. I was rolling rocks... um... and...";
const string S_MINION2_1 = "Rock-head try to say he broke a totem.";
const string S_MINION1_2 = "Me? Me not one who break it! You roll rocks first!";
const string S_MINION2_2 = "You roll rock that hit totem!";
const string S_HAGATHA1 = "Enough! Gods grant me patience, why did it have to be hill giants?";
const string S_HAGATHA2 = "I'll fix it, but no more rock rolling! You'll be the death of me.";

// CONSTANTS
//////////////

const int MUSIC_SCENE = TRACK_HOTU_UNDERMOUNTAIN;
const int MUSIC_BATTLE = 76; // ID music

const string TAG_HAGATHA = "id1_cs_hgt_hgtha";
const string TAG_MINION1 = "id1_cs_hgt_min1";
const string TAG_MINION2 = "id1_cs_hgt_min2";
const string RESREF_TOTEM = "x0_skullpole";
const string RESREF_SKULLS = "plc_pileskulls";
const string RESREF_RUBBLE = "nw_pl_rubble001";
const string TAG_AUDIO_TOTEMBREAK = "ID1_STATIC_hgt_break";
const string TAG_AUDIO_SPELL = "ID1_STATIC_hgt_spell";

const string WP_TOTEM = "ID1_STATIC_WP_TOTEM_4";
const string WP_TOTEM2 = "ID1_STATIC_WP_TOTEM_1";
const string WP_TOTEM3 = "ID1_STATIC_WP_TOTEM_2";
const string WP_RUBBLE = "ID1_STATIC_WP_CS_RUBBLE";
const string WP_SKULLS = "ID1_STATIC_WP_CS_SKULLS";
const string WP_HAGATHA_1 = "ID1_STATIC_WP_CS_HAGATHA_1";
const string WP_HAGATHA_2 = "ID1_STATIC_WP_CS_HAGATHA_2";
const string WP_HAGATHA_3 = "ID1_STATIC_WP_CS_HAGATHA_3";
const string WP_MINION1_1 = "ID1_STATIC_WP_CS_MINION1_1";
const string WP_MINION2_1 = "ID1_STATIC_WP_CS_MINION2_1";
const string WP_MINION1_2 = "ID1_STATIC_WP_CS_MINION1_2";
const string WP_MINION2_2 = "ID1_STATIC_WP_CS_MINION2_2";
const string WP_MINION1_3 = "ID1_STATIC_WP_CS_MINION1_3";
const string WP_MINION2_3 = "ID1_STATIC_WP_CS_MINION2_3";

void main()
{
    float fDelay;

    // using incremented delay type
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    // Object setup

    // waypoints
    object oWP_Totem = GetObjectByTagInArea(WP_TOTEM);
    object oWP_Totem2 = GetObjectByTagInArea(WP_TOTEM2);
    object oWP_Totem3 = GetObjectByTagInArea(WP_TOTEM3);
    object oWP_Rubble = GetObjectByTagInArea(WP_RUBBLE);
    object oWP_Skulls = GetObjectByTagInArea(WP_SKULLS);
    object oWP_Hagatha_1 = GetObjectByTagInArea(WP_HAGATHA_1);
    object oWP_Hagatha_2 = GetObjectByTagInArea(WP_HAGATHA_2);
    object oWP_Hagatha_3 = GetObjectByTagInArea(WP_HAGATHA_3);
    object oWP_Minion1_1 = GetObjectByTagInArea(WP_MINION1_1);
    object oWP_Minion2_1 = GetObjectByTagInArea(WP_MINION2_1);
    object oWP_Minion1_2 = GetObjectByTagInArea(WP_MINION1_2);
    object oWP_Minion2_2 = GetObjectByTagInArea(WP_MINION2_2);
    object oWP_Minion1_3 = GetObjectByTagInArea(WP_MINION1_3);
    object oWP_Minion2_3 = GetObjectByTagInArea(WP_MINION2_3);

    // creatures
    object oCre_Hagatha = CreateObject(OBJECT_TYPE_CREATURE, TAG_HAGATHA, GetLocation(oWP_Hagatha_2));
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, EffectMovementSpeedIncrease(50), oCre_Hagatha);
    object oCre_Minion1 = CreateObject(OBJECT_TYPE_CREATURE, TAG_MINION1, GetLocation(oWP_Minion1_1));
    object oCre_Minion2 = CreateObject(OBJECT_TYPE_CREATURE, TAG_MINION2, GetLocation(oWP_Minion2_1));

    // placeables
    object oPla_Totem = CreateObject(OBJECT_TYPE_PLACEABLE, RESREF_TOTEM, GetLocation(oWP_Totem));
    // make totem invisible
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oPla_Totem);

    object oPla_Totem2 = CreateObject(OBJECT_TYPE_PLACEABLE, RESREF_TOTEM, GetLocation(oWP_Totem2));
    object oPla_Totem3 = CreateObject(OBJECT_TYPE_PLACEABLE, RESREF_TOTEM, GetLocation(oWP_Totem3));

    object oPla_Rubble = CreateObject(OBJECT_TYPE_PLACEABLE, RESREF_RUBBLE, GetLocation(oWP_Rubble));
    object oPla_Skulls = CreateObject(OBJECT_TYPE_PLACEABLE, RESREF_SKULLS, GetLocation(oWP_Skulls));

    // sounds
    object oAud_TotemBreak = GetObjectByTagInArea(TAG_AUDIO_TOTEMBREAK);
    object oAud_Spell = GetObjectByTagInArea(TAG_AUDIO_SPELL);

    //==========================================================================

    cs_MusicBackgroundChangeDay(0.0, MUSIC_SCENE);
    cs_MusicBackgroundChangeNight(0.0, MUSIC_SCENE);

    // initial camera
    cs_CameraUseCameraWaypoint(1.0, 1);

    // animation on Hagatha
    cs_PlayAnimation(0.5, oCre_Hagatha, ANIMATION_LOOPING_CONJURE1, 1.0, 4.0);

    // beam effect
    effect eBeam = EffectBeam(VFX_BEAM_SILENT_HOLY, oPla_Totem2, BODY_NODE_CHEST);
    //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oCre_Hagatha, 3.5);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_TEMPORARY, eBeam, oCre_Hagatha, 2.5);
    cs_SoundObjectPlay(0.0, oAud_Spell);
    fDelay = cs_GetDelay();
    cs_SoundObjectStop(2.5, oAud_Spell);
    cs_ResetDelay(-1.0, fDelay);

    // fade-in
    cs_CameraDoFade(0.2, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    cs_ApplyVFXToObject(0.7, DURATION_TYPE_INSTANT, VFX_IMP_HEALING_S, oCre_Hagatha);;

    // breaking totem sound
    //cs_PlaySound(2.0, cs_GetPCObject(), "as_cv_woodbreak2");
    cs_SoundObjectPlay(2.3, oAud_TotemBreak);

    // Hagatha turns to sound
    cs_PlayAnimation(0.2, oCre_Hagatha, ANIMATION_FIREFORGET_HEAD_TURN_LEFT);

    // camera 2
    cs_CameraDoFade(0.8, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FASTEST);
    cs_CameraUseCameraWaypoint(0.5, 2);
    // Hagatha approaches
    cs_ActionMoveToObject(0.0, oCre_Hagatha, oWP_Hagatha_3, FALSE, 0.0);
    // make first totem invisible
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oPla_Totem2);
    cs_CameraDoFade(0.9, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FASTEST);

    // giants turn heads towards her
    cs_PlayAnimation(0.8, oCre_Minion1, ANIMATION_FIREFORGET_HEAD_TURN_RIGHT);
    cs_PlayAnimation(0.4, oCre_Minion2, ANIMATION_FIREFORGET_HEAD_TURN_LEFT);

    // giants face her
    //cs_ActionSetFacingPoint(1.0, oCre_Minion1, GetPosition(oWP_Hagatha_3));
    //cs_ActionSetFacingPoint(0.3, oCre_Minion2, GetPosition(oWP_Hagatha_3));

    // talking
    cs_PlayAnimation(1.5, oCre_Minion1, ANIMATION_LOOPING_CONJURE1, 1.0, 3.0);
    // funky way of setting the camera - ensures facing is directly at minion waypoint
    cs_CameraSetFacing(0.0, GetFacingBetweenObjects(cs_GetCameraWaypointObject(3), oWP_Minion1_1),
                            cs_GetCameraWaypointDistance(3),
                            cs_GetCameraWaypointPitch(3),
                            cs_GetCameraWaypointFacingSpeed(3));
    cs_CameraSetHeight(0.0, cs_GetCameraWaypointHeight(3));
    cs_SpeakString(0.1, oCre_Minion1, S_MINION1_1);

    //cs_CameraUseCameraWaypoint(3.5, 4);
    cs_CameraSetFacing(3.5, GetFacingBetweenObjects(cs_GetCameraWaypointObject(4), oWP_Minion2_1),
                            cs_GetCameraWaypointDistance(4),
                            cs_GetCameraWaypointPitch(4),
                            cs_GetCameraWaypointFacingSpeed(4));
    cs_SpeakString(0.1, oCre_Minion2, S_MINION2_1);

    //cs_CameraUseCameraWaypoint(3.5, 5);
    cs_CameraSetFacing(3.5, GetFacingBetweenObjects(cs_GetCameraWaypointObject(5), oWP_Minion1_1),
                            cs_GetCameraWaypointDistance(5),
                            cs_GetCameraWaypointPitch(5),
                            cs_GetCameraWaypointFacingSpeed(5));
    cs_SpeakString(0.1, oCre_Minion1, S_MINION1_2);

    cs_PlayAnimation(3.5, oCre_Minion2, ANIMATION_LOOPING_CONJURE1, 1.0, 2.5);
    //cs_CameraUseCameraWaypoint(0.0, 4);
    cs_CameraSetFacing(0.0, GetFacingBetweenObjects(cs_GetCameraWaypointObject(4), oWP_Minion2_1),
                            cs_GetCameraWaypointDistance(4),
                            cs_GetCameraWaypointPitch(4),
                            cs_GetCameraWaypointFacingSpeed(4));
    cs_SpeakString(0.1, oCre_Minion2, S_MINION2_2);

    cs_CameraUseCameraWaypoint(2.5, 2);
    cs_SpeakString(0.0, oCre_Minion1, "");
    cs_SpeakString(0.0, oCre_Minion2, "");
    cs_SpeakString(0.2, oCre_Hagatha, S_HAGATHA1);

    cs_CameraUseCameraWaypoint(2.5, 6);
    cs_SpeakString(0.7, oCre_Hagatha, S_HAGATHA2);

    // summon totem
    cs_ActionCastFakeSpellAtObject(1.3, oCre_Hagatha, SPELL_HORRID_WILTING, oPla_Totem);
    cs_ApplyVFXToObject(1.7, DURATION_TYPE_INSTANT, VFX_FNF_SUMMON_MONSTER_1, oPla_Totem, 0.0, FALSE, FALSE);
    cs_ApplyVFXToObject(0.5, DURATION_TYPE_INSTANT, VFX_IMP_DESTRUCTION, oPla_Totem, 0.0, FALSE, FALSE);
    cs_RemoveVFXFromObject(0.0, oPla_Totem);

    cs_MusicBackgroundChangeDay(1.0, MUSIC_BATTLE);
    cs_MusicBackgroundChangeNight(0.0, MUSIC_BATTLE);

    cs_ApplyVFXToObject(0.5, DURATION_TYPE_INSTANT, VFX_FNF_HOWL_MIND, oPla_Totem);
    cs_PlayAnimation(0.1, oCre_Minion1, ANIMATION_LOOPING_DEAD_BACK, 1.0, 10.0);
    cs_PlayAnimation(0.0, oCre_Minion2, ANIMATION_LOOPING_DEAD_BACK, 1.0, 10.0);

    cs_CameraDoFade(1.5, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);

    // clean-up
    cs_DestroyObject(2.0, oCre_Hagatha);
    cs_DestroyObject(0.0, oCre_Minion1);
    cs_DestroyObject(0.0, oCre_Minion2);
    cs_DestroyObject(0.0, oPla_Totem);
    cs_DestroyObject(0.0, oPla_Totem2);
    cs_DestroyObject(0.0, oPla_Totem3);
    cs_DestroyObject(0.0, oPla_Rubble);
    cs_DestroyObject(0.0, oPla_Skulls);

    cs_SoundObjectStop(0.0, oAud_Spell);
    cs_SoundObjectStop(0.0, oAud_TotemBreak);

    cs_EndCutscene(1.0);
}
