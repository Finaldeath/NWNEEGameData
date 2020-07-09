//::///////////////////////////////////////////////
//:: cut_id1_narr04
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Fourth narrator cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 9, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"

// SPEAKSTRINGS
///////////////

const string S_NARRATION_1 = "There comes a moment in each person's life when a single decision can alter the course of history.";
const string S_NARRATION_2 = "What if Szazz Tam had been satisfied with the fullness of his life and chosen not to become a lich?";
const string S_NARRATION_3 = "What if Elminster had opted to become a farmer, not a mage?";
const string S_NARRATION_4 = "What if Bhaal had made room within his heart for a moment of compassion?";
const string S_NARRATION_5 = "What if, after a thousand years, Halaster had finally tired of Undermountain and sought to see the world?";
const string S_NARRATION_6 = "What if... 'tis just a child's game, isn't it? Life. Choices. What if.";

const float VO_LENGTH_1 = 6.68;
const float VO_LENGTH_2 = 6.35;
const float VO_LENGTH_3 = 4.65;
const float VO_LENGTH_4 = 4.98;
const float VO_LENGTH_5 = 8.4; // 8.75 - has a long pause at the end, which is why I shortened this time
const float VO_LENGTH_6 = 8.3;

const string TAG_AUDIO_VO_1 = "ID1_STATIC_narr4_1";
const string TAG_AUDIO_VO_2 = "ID1_STATIC_narr4_2";
const string TAG_AUDIO_VO_3 = "ID1_STATIC_narr4_3";
const string TAG_AUDIO_VO_4 = "ID1_STATIC_narr4_4";
const string TAG_AUDIO_VO_5 = "ID1_STATIC_narr4_5";
const string TAG_AUDIO_VO_6 = "ID1_STATIC_narr4_6";

// CONSTANTS
//////////////

const string WP_HALASTER1 = "ID1_STATIC_CS_HALASTER41";
const string WP_HALASTER2 = "ID1_STATIC_CS_HALASTER42";
const string WP_SZAZZ1 = "ID1_STATIC_CS_SZAZZ1";
const string WP_SZAZZ2 = "ID1_STATIC_CS_SZAZZ2";
const string WP_SZAZZ3 = "ID1_STATIC_CS_SZAZZ3";
const string WP_ELM1 = "ID1_STATIC_CS_ELM1";
const string WP_ELM2 = "ID1_STATIC_CS_ELM2";
const string WP_ELM_DIRT = "ID1_STATIC_CS_ELM_DIRT";
const string WP_ELM_GRASS1 = "ID1_STATIC_CS_ELM_GRASS1";
const string WP_ELM_GRASS2 = "ID1_STATIC_CS_ELM_GRASS2";
const string WP_ELM_GRASS3 = "ID1_STATIC_CS_ELM_GRASS3";
const string WP_BHAAL1 = "ID1_STATIC_CS_BHAAL1";
const string WP_BHAAL2 = "ID1_STATIC_CS_BHAAL2";
const string WP_BHAAL3 = "ID1_STATIC_CS_BHAAL3";
const string WP_NARR1 = "ID1_STATIC_CS_NARR41";

const string TAG_NARRATOR = "id1_cs_narrator";
const string TAG_HALASTER = "id1_cs_halaster";
const string TAG_ELMINSTER1 = "id1_cs_nar4_elm1";
const string TAG_ELMINSTER2 = "id1_cs_nar4_elm2";
const string TAG_ELMINSTER_DIRT = "x0_dirtpatch";
const string TAG_ELMINSTER_GRASS = "plc_grasstuft";

const string TAG_SZAZZ1 = "id1_cs_nar4_szz1";
const string TAG_SZAZZ2 = "id1_cs_nar4_szz2";
const string TAG_SZAZZ_BAR = "x2_plc_drowbar";
const string TAG_BHAAL1 = "id1_cs_nar4_bhl1";
const string TAG_BHAAL2 = "id1_cs_nar4_bhl2";
const string TAG_BHAAL3 = "id1_cs_nar4_bhl3";

const string TAG_DOOR = "ID1_STATIC_CS_DOOR1";

void main()
{
    int nCutNumber = cs_GetCutsceneRunning();
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
    object oWP_Szazz1 = GetObjectByTagInArea(WP_SZAZZ1);
    object oWP_Szazz2 = GetObjectByTagInArea(WP_SZAZZ2);
    object oWP_Szazz3 = GetObjectByTagInArea(WP_SZAZZ3);
    object oWP_Elminster1 = GetObjectByTagInArea(WP_ELM1);
    object oWP_Elminster2 = GetObjectByTagInArea(WP_ELM2);
    object oWP_Elminster_Dirt = GetObjectByTagInArea(WP_ELM_DIRT);
    object oWP_Elminster_Grass1 = GetObjectByTagInArea(WP_ELM_GRASS1);
    object oWP_Elminster_Grass2 = GetObjectByTagInArea(WP_ELM_GRASS2);
    object oWP_Elminster_Grass3 = GetObjectByTagInArea(WP_ELM_GRASS3);
    object oWP_Bhaal1 = GetObjectByTagInArea(WP_BHAAL1);
    object oWP_Bhaal2 = GetObjectByTagInArea(WP_BHAAL2);
    object oWP_Bhaal3 = GetObjectByTagInArea(WP_BHAAL3);
    object oWP_Narr1 = GetObjectByTagInArea(WP_NARR1);

    // creatures
    object oCre_Narrator = CreateObject(OBJECT_TYPE_CREATURE, TAG_NARRATOR, cs_GetCameraWaypointLocation(41));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Narrator);
    object oCre_Narrator2 = CreateObject(OBJECT_TYPE_CREATURE, TAG_NARRATOR, GetLocation(oWP_Narr1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Narrator2);

    object oCre_Halaster = CreateObject(OBJECT_TYPE_CREATURE, TAG_HALASTER, GetLocation(oWP_Halaster1));

    object oCre_Szazz1 = CreateObject(OBJECT_TYPE_CREATURE, TAG_SZAZZ1, GetLocation(oWP_Szazz1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Szazz1);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Szazz1);
    object oCre_Szazz2 = CreateObject(OBJECT_TYPE_CREATURE, TAG_SZAZZ2, GetLocation(oWP_Szazz2));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Szazz2);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Szazz2);

    object oCre_Elm1 = CreateObject(OBJECT_TYPE_CREATURE, TAG_ELMINSTER1, GetLocation(oWP_Elminster1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Elm1);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Elm1);
    object oCre_Elm2 = CreateObject(OBJECT_TYPE_CREATURE, TAG_ELMINSTER2, GetLocation(oWP_Elminster2));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Elm2);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Elm2);

    object oCre_Bhaal1 = CreateObject(OBJECT_TYPE_CREATURE, TAG_BHAAL1, GetLocation(oWP_Bhaal1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Bhaal1);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Bhaal1);
    object oCre_Bhaal2 = CreateObject(OBJECT_TYPE_CREATURE, TAG_BHAAL2, GetLocation(oWP_Bhaal2));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Bhaal2);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Bhaal2);
    cs_PlayAnimation(0.0, oCre_Bhaal2, ANIMATION_LOOPING_GET_LOW, 0.6, 60.0);
    object oCre_Bhaal3 = CreateObject(OBJECT_TYPE_CREATURE, TAG_BHAAL3, GetLocation(oWP_Bhaal3));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Bhaal3);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Bhaal3);
    cs_PlayAnimation(0.0, oCre_Bhaal3, ANIMATION_LOOPING_DEAD_FRONT, 1.0, 60.0);

    // placeables
    object oPla_Szazz = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_SZAZZ_BAR, GetLocation(oWP_Szazz3));
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oPla_Szazz);

    object oPla_Elm1 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_ELMINSTER_DIRT, GetLocation(oWP_Elminster_Dirt));
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oPla_Elm1);
    object oPla_Elm2 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_ELMINSTER_GRASS, GetLocation(oWP_Elminster_Grass1));
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oPla_Elm2);
    object oPla_Elm3 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_ELMINSTER_GRASS, GetLocation(oWP_Elminster_Grass2));
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oPla_Elm3);
    object oPla_Elm4 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_ELMINSTER_GRASS, GetLocation(oWP_Elminster_Grass3));
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oPla_Elm4);

    // door
    object oDoor = GetObjectByTagInArea(TAG_DOOR);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oDoor);

    // sounds
    object oAud_VO1 = GetObjectByTagInArea(TAG_AUDIO_VO_1);
    object oAud_VO2 = GetObjectByTagInArea(TAG_AUDIO_VO_2);
    object oAud_VO3 = GetObjectByTagInArea(TAG_AUDIO_VO_3);
    object oAud_VO4 = GetObjectByTagInArea(TAG_AUDIO_VO_4);
    object oAud_VO5 = GetObjectByTagInArea(TAG_AUDIO_VO_5);
    object oAud_VO6 = GetObjectByTagInArea(TAG_AUDIO_VO_6);

    //==========================================================================

    // set fog
    cs_SetFogColor(0.0, FOG_TYPE_ALL, FOG_COLOR_BLACK);
    cs_SetFogAmount(0.0, FOG_TYPE_ALL, 50);

    // initial camera
    cs_CameraUseCameraWaypoint(1.0, 41);
    cs_ActionJumpToLocation(0.0, oCre_Narrator, cs_GetCameraWaypointLocation(41));

    // start camera 2
    cs_CameraUseCameraWaypoint(0.8, 42);

    // fade-in
    cs_CameraDoFade(1.0, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    // VO 1
    cs_SoundObjectPlay(0.5, oAud_VO1);
    cs_SpeakString(0.0, oCre_Narrator2, S_NARRATION_1);

    // VO 2
    cs_SoundObjectPlay(VO_LENGTH_1 + 0.5, oAud_VO2);
    cs_SpeakString(0.0, oCre_Narrator2, S_NARRATION_2);

    // Szazz effects
    fDelay = cs_GetDelay();

    //cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GHOST_SMOKE, oCre_Szazz1, 60.0, FALSE, FALSE);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GHOSTLY_VISAGE_NO_SOUND, oCre_Szazz1, 60.0, FALSE, FALSE);
    cs_RemoveVFXFromObject(0.1, oCre_Szazz1);

    cs_ApplyVFXToObject(1.9, DURATION_TYPE_PERMANENT, VFX_DUR_GHOSTLY_VISAGE_NO_SOUND, oCre_Szazz2, 0.0, FALSE, FALSE);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GHOSTLY_VISAGE_NO_SOUND, oPla_Szazz, 0.0, FALSE, FALSE);
    cs_RemoveVFXFromObject(0.1, oCre_Szazz2);
    cs_RemoveVFXFromObject(0.0, oPla_Szazz);
    //cs_ApplyVFXToObject(0.01, DURATION_TYPE_PERMANENT, VFX_DUR_GHOST_TRANSPARENT, oCre_Szazz2, 0.0, FALSE, FALSE);
    //cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GHOSTLY_PULSE, oCre_Szazz2, 0.0, FALSE, FALSE);
    //cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GHOST_TRANSPARENT, oPla_Szazz, 0.0, FALSE, FALSE);
    //cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GHOSTLY_PULSE, oPla_Szazz, 0.0, FALSE, FALSE);

    cs_DestroyObject(2.5, oCre_Szazz1);
    cs_DestroyObject(2.0, oCre_Szazz2);
    cs_DestroyObject(0.0, oPla_Szazz);
    cs_ResetDelay(-1.0, fDelay);


    // VO 3
    cs_SoundObjectPlay(VO_LENGTH_2 + 0.5, oAud_VO3);
    cs_SpeakString(0.0, oCre_Narrator2, S_NARRATION_3);

    // Elminster effects
    fDelay = cs_GetDelay();
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GHOSTLY_VISAGE_NO_SOUND, oCre_Elm1, 60.0, FALSE, FALSE);
    cs_RemoveVFXFromObject(0.1, oCre_Elm1);

    cs_ApplyVFXToObject(1.9, DURATION_TYPE_PERMANENT, VFX_DUR_GHOSTLY_VISAGE_NO_SOUND, oCre_Elm2, 60.0, FALSE, FALSE);
    //cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GHOSTLY_VISAGE_NO_SOUND, oPla_Elm1, 60.0, FALSE, FALSE);
    //cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GHOSTLY_VISAGE_NO_SOUND, oPla_Elm2, 60.0, FALSE, FALSE);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GHOSTLY_VISAGE_NO_SOUND, oPla_Elm3, 60.0, FALSE, FALSE);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GHOSTLY_VISAGE_NO_SOUND, oPla_Elm4, 60.0, FALSE, FALSE);
    cs_RemoveVFXFromObject(0.1, oCre_Elm2);
    cs_RemoveVFXFromObject(0.0, oPla_Elm1);
    cs_RemoveVFXFromObject(0.0, oPla_Elm2);
    cs_RemoveVFXFromObject(0.0, oPla_Elm3);
    cs_RemoveVFXFromObject(0.0, oPla_Elm4);
    cs_DestroyObject(2.5, oCre_Elm1);
    cs_DestroyObject(2.0, oCre_Elm2);
    cs_DestroyObject(0.0, oPla_Elm1);
    cs_DestroyObject(0.0, oPla_Elm2);
    cs_DestroyObject(0.0, oPla_Elm3);
    cs_DestroyObject(0.0, oPla_Elm4);
    cs_ResetDelay(-1.0, fDelay);


    // VO 4
    cs_SoundObjectPlay(VO_LENGTH_3 + 0.5, oAud_VO4);
    cs_SpeakString(0.0, oCre_Narrator2, S_NARRATION_4);

    // Bhaal effects
    fDelay = cs_GetDelay();
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GHOSTLY_VISAGE_NO_SOUND, oCre_Bhaal1, 60.0, FALSE, FALSE);
    cs_RemoveVFXFromObject(0.1, oCre_Bhaal1);

    cs_ApplyVFXToObject(1.9, DURATION_TYPE_PERMANENT, VFX_DUR_GHOSTLY_VISAGE_NO_SOUND, oCre_Bhaal2, 60.0, FALSE, FALSE);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GHOSTLY_VISAGE_NO_SOUND, oCre_Bhaal3, 60.0, FALSE, FALSE);
    cs_RemoveVFXFromObject(0.1, oCre_Bhaal2);
    cs_RemoveVFXFromObject(0.0, oCre_Bhaal3);
    cs_DestroyObject(2.5, oCre_Bhaal1);
    cs_DestroyObject(2.0, oCre_Bhaal2);
    cs_DestroyObject(0.0, oCre_Bhaal3);
    cs_ResetDelay(-1.0, fDelay);


    // VO 5
    cs_SoundObjectPlay(VO_LENGTH_4 + 0.5, oAud_VO5);
    cs_SpeakString(0.0, oCre_Narrator2, S_NARRATION_5);

    fDelay = cs_GetDelay();
    cs_ActionMoveToObject(1.5, oCre_Halaster, oWP_Halaster2, FALSE, 0.1);
    cs_DestroyObject(2.0, oCre_Halaster);
    cs_ResetDelay(-1.0, fDelay);

    // VO 6
    cs_SoundObjectPlay(VO_LENGTH_5, oAud_VO6);
    cs_SpeakString(0.0, oCre_Narrator2, S_NARRATION_6);


    // fade-out
    cs_CameraDoFade(VO_LENGTH_6, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);

    // clean-up
    cs_DestroyObject(1.0, oCre_Halaster);
    cs_DestroyObject(0.0, oCre_Szazz1);
    cs_DestroyObject(0.0, oCre_Szazz2);
    cs_DestroyObject(0.0, oPla_Szazz);
    cs_DestroyObject(0.0, oPla_Elm1);
    cs_DestroyObject(0.0, oPla_Elm2);
    cs_DestroyObject(0.0, oPla_Elm3);
    cs_DestroyObject(0.0, oPla_Elm4);
    cs_DestroyObject(0.0, oCre_Elm1);
    cs_DestroyObject(0.0, oCre_Elm2);
    cs_DestroyObject(0.0, oCre_Bhaal1);
    cs_DestroyObject(0.0, oCre_Bhaal2);
    cs_DestroyObject(0.0, oCre_Bhaal3);
    cs_DestroyObject(0.0, oCre_Narrator);
    cs_DestroyObject(0.0, oCre_Narrator2);

    cs_SoundObjectStop(0.0, oAud_VO1);
    cs_SoundObjectStop(0.0, oAud_VO2);
    cs_SoundObjectStop(0.0, oAud_VO3);
    cs_SoundObjectStop(0.0, oAud_VO4);
    cs_SoundObjectStop(0.0, oAud_VO5);
    cs_SoundObjectStop(0.0, oAud_VO6);

    // restore fog
    cs_SetFogColor(0.0, FOG_TYPE_MOON, nOriginalFogNight);
    cs_SetFogColor(0.0, FOG_TYPE_SUN, nOriginalFogDay);
    cs_SetFogAmount(0.0, FOG_TYPE_MOON, nOriginalFogAmountNight);
    cs_SetFogAmount(0.0, FOG_TYPE_SUN, nOriginalFogAmountDay);

    cs_EndCutscene(1.0, FALSE, TRUE);
}
