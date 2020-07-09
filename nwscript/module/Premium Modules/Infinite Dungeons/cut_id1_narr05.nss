//::///////////////////////////////////////////////
//:: cut_id1_narr05
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Fifth narrator cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 9, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"

// SPEAKSTRINGS
///////////////

const string S_NARRATION_1 = "I have always enjoyed my time in Undermountain. I think, from the moment of my birth, I was destined for this.";
const string S_NARRATION_2 = "I was born, wasn't I? I had a mother and a father? It's funny - I don't actually remember them.";
const string S_NARRATION_3 = "If not me, who does rule in Undermountain?";

const float VO_LENGTH_1 = 9.73;
const float VO_LENGTH_2 = 9.96;
const float VO_LENGTH_3 = 5.78;

const string TAG_AUDIO_VO_1 = "ID1_STATIC_narr5_1";
const string TAG_AUDIO_VO_2 = "ID1_STATIC_narr5_2";
const string TAG_AUDIO_VO_3 = "ID1_STATIC_narr5_3";

// CONSTANTS
//////////////

const string WP_HALASTER1 = "ID1_STATIC_CS_HALASTER51";
const string WP_TIMMY1 = "ID1_STATIC_CS_TIMMY51";
const string WP_VFX1_1 = "ID1_STATIC_WP_VFX51_1";
const string WP_VFX1_2 = "ID1_STATIC_WP_VFX51_2";

//const string TAG_HALASTER = "id1_cs_halaster";
const string TAG_TIMMY = "id1_cs_nar5_tim";
//const string TAG_NARRATOR = "id1_cs_narrator";
const string TAG_NARRATOR2 = "id1_cs_narrator2";
const string RESREF_VFX_OBJECT = "plc_invisobj";

void main()
{
    float fDelay;

    // fog  - store current settings
    int nOriginalFogDay = GetFogColor(FOG_TYPE_SUN, OBJECT_SELF);
    int nOriginalFogNight = GetFogColor(FOG_TYPE_MOON, OBJECT_SELF);
    int nOriginalFogAmountDay = GetFogAmount(FOG_TYPE_SUN, OBJECT_SELF);
    int nOriginalFogAmountNight = GetFogAmount(FOG_TYPE_MOON, OBJECT_SELF);

    // using incremented delay type
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    // Object setup

    // waypoints
    object oWP_Halaster1 = GetObjectByTagInArea(WP_HALASTER1);
    object oWP_Timmy1 = GetObjectByTagInArea(WP_TIMMY1);
    object oWP_VFX1_1 = GetObjectByTagInArea(WP_VFX1_1);
    object oWP_VFX1_2 = GetObjectByTagInArea(WP_VFX1_2);

    // creatures
    //object oCre_Halaster = CreateObject(OBJECT_TYPE_CREATURE, TAG_HALASTER, GetLocation(oWP_Halaster1));
    //ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Halaster);
    //cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GHOST_TRANSPARENT, oCre_Halaster);

    object oCre_Timmy = CreateObject(OBJECT_TYPE_CREATURE, TAG_TIMMY, GetLocation(oWP_Timmy1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Timmy);

    //object oCre_Narrator = CreateObject(OBJECT_TYPE_CREATURE, TAG_NARRATOR, cs_GetCameraWaypointLocation(51));
    object oCre_Narrator = CreateObject(OBJECT_TYPE_CREATURE, TAG_NARRATOR2, GetLocation(oWP_Halaster1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Narrator);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GHOST_TRANSPARENT, oCre_Narrator);

    // placeables
    object oPla_VFX1 = CreateObject(OBJECT_TYPE_PLACEABLE, RESREF_VFX_OBJECT, GetLocation(oWP_VFX1_1));
    object oPla_VFX2 = CreateObject(OBJECT_TYPE_PLACEABLE, RESREF_VFX_OBJECT, GetLocation(oWP_VFX1_2));

    // sounds
    object oAud_VO1 = GetObjectByTagInArea(TAG_AUDIO_VO_1);
    object oAud_VO2 = GetObjectByTagInArea(TAG_AUDIO_VO_2);
    object oAud_VO3 = GetObjectByTagInArea(TAG_AUDIO_VO_3);

    //==========================================================================

    // set fog
    cs_SetFogColor(0.0, FOG_TYPE_ALL, FOG_COLOR_BLACK);
    cs_SetFogAmount(0.0, FOG_TYPE_ALL, 50);

    // initial camera
    cs_CameraUseCameraWaypoint(1.0, 51);

    // start camera movement
    cs_CameraUseCameraWaypoint(0.8, 52);
    fDelay = cs_GetDelay();
    cs_CameraUseCameraWaypoint(10.0, 53);
    cs_ResetDelay(-1.0, fDelay);

    // fade-in
    cs_CameraDoFade(0.2, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    // VO
    cs_SoundObjectPlay(0.5, oAud_VO1);
    cs_SpeakString(0.0, oCre_Narrator, S_NARRATION_1);

    cs_SoundObjectPlay(VO_LENGTH_1, oAud_VO2);
    cs_SpeakString(0.0, oCre_Narrator, S_NARRATION_2);

    cs_SoundObjectPlay(VO_LENGTH_2, oAud_VO3);
    cs_SpeakString(0.0, oCre_Narrator, S_NARRATION_3);

    // whee, flying tile
    cs_ActionCastFakeSpellAtObject(2.2, oPla_VFX1, 755, oPla_VFX2, PROJECTILE_PATH_TYPE_DEFAULT);

    // fade-out
    cs_CameraDoFade(VO_LENGTH_3 - 2.2, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);

    // clean-up
    //cs_DestroyObject(1.5, oCre_Halaster);
    cs_DestroyObject(1.5, oCre_Timmy);
    cs_DestroyObject(0.0, oCre_Narrator);
    cs_DestroyObject(0.0, oPla_VFX1);
    cs_DestroyObject(0.0, oPla_VFX2);

    cs_SoundObjectStop(0.0, oAud_VO1);
    cs_SoundObjectStop(0.0, oAud_VO2);
    cs_SoundObjectStop(0.0, oAud_VO3);

    // restore fog
    cs_SetFogColor(0.0, FOG_TYPE_MOON, nOriginalFogNight);
    cs_SetFogColor(0.0, FOG_TYPE_SUN, nOriginalFogDay);
    cs_SetFogAmount(0.0, FOG_TYPE_MOON, nOriginalFogAmountNight);
    cs_SetFogAmount(0.0, FOG_TYPE_SUN, nOriginalFogAmountDay);

    cs_EndCutscene(1.0, FALSE, TRUE);
}

/*
753 = city exterior, plaza 1
754 = city exterior, slum house 2
755 = dungeon, pillar 3
765 = forest, big tree
766 = crypt, treasure 2
*/

