//::///////////////////////////////////////////////
//:: cut_id1_hlstr
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Halaster boss battle intro cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 9, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"


// CONSTANTS
//////////////

const int MUSIC_SCENE = 0;
const int MUSIC_BATTLE = 76; // ID music

const string WP_HALASTER0 = "ID1_STATIC_CS_HALASTER0";
const string WP_HALASTER1 = "ID1_STATIC_CS_HALASTER1";
const string WP_HALASTER2 = "ID1_STATIC_CS_HALASTER2";
const string WP_HALASTER3 = "ID1_STATIC_CS_HALASTER3";
const string WP_PORTAL1 = "ID1_STATIC_CS_PORTAL1";
const string WP_PORTAL2 = "ID1_STATIC_CS_PORTAL2";
const string WP_PORTAL3 = "ID1_STATIC_CS_PORTAL3";
const string WP_PORTAL4 = "ID1_STATIC_CS_PORTAL4";
const string WP_PORTAL5 = "ID1_STATIC_CS_PORTAL5";
const string WP_PORTAL6 = "ID1_STATIC_CS_PORTAL6";
const string WP_PORTAL7 = "ID1_STATIC_CS_PORTAL7";
const string WP_PORTAL8 = "ID1_STATIC_CS_PORTAL8";
const string WP_PENGUIN1 = "ID1_STATIC_CS_PENGUIN1";

const string TAG_HALASTER = "id1_cs_halaster";
const string TAG_PENGUIN = "id1_cs_hls_peng";
const string TAG_PORTAL = "plc_portal";
const string TAG_AUDIO_LAUGH1 = "ID1_STATIC_halaster1";
const string TAG_AUDIO_LAUGH2 = "ID1_STATIC_halaster2";
const string TAG_AUDIO_LAUGH3 = "ID1_STATIC_halaster3";

//const string VO_FILENAME_1 = "id1_hal105";
//const string VO_FILENAME_2 = "id1_hal102";
//const string VO_FILENAME_3 = "id1_hal104";

// custom vfx - removed screen shake
const int VFX_FNF_FIRESTORM_NO_SHAKE = 580;
const int VFX_FNF_SUMMON_MONSTER_3_NO_SHAKE = 581;

void main()
{
    // using incremented delay type
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    // Object setup

    // waypoints
    object oWP_Halaster0 = GetObjectByTagInArea(WP_HALASTER0);
    object oWP_Halaster1 = GetObjectByTagInArea(WP_HALASTER1);
    object oWP_Halaster2 = GetObjectByTagInArea(WP_HALASTER2);
    object oWP_Halaster3 = GetObjectByTagInArea(WP_HALASTER3);
    object oWP_Portal1 = GetObjectByTagInArea(WP_PORTAL1);
    object oWP_Portal2 = GetObjectByTagInArea(WP_PORTAL2);
    object oWP_Portal3 = GetObjectByTagInArea(WP_PORTAL3);
    object oWP_Portal4 = GetObjectByTagInArea(WP_PORTAL4);
    object oWP_Portal5 = GetObjectByTagInArea(WP_PORTAL5);
    object oWP_Portal6 = GetObjectByTagInArea(WP_PORTAL6);
    object oWP_Portal7 = GetObjectByTagInArea(WP_PORTAL7);
    object oWP_Portal8 = GetObjectByTagInArea(WP_PORTAL8);
    object oWP_Penguin1 = GetObjectByTagInArea(WP_PENGUIN1);

    // creatures
    object oCre_Halaster = CreateObject(OBJECT_TYPE_CREATURE, TAG_HALASTER, GetLocation(oWP_Halaster0));
    object oCre_Penguin = CreateObject(OBJECT_TYPE_CREATURE, TAG_PENGUIN, GetLocation(oWP_Portal1));
    // both are invisible to start
    //cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Halaster);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Penguin);

    // placeables
    object oPla_Portal1 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_PORTAL, GetLocation(oWP_Portal1));
    object oPla_Portal2 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_PORTAL, GetLocation(oWP_Portal2));
    object oPla_Portal3 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_PORTAL, GetLocation(oWP_Portal3));
    object oPla_Portal4 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_PORTAL, GetLocation(oWP_Portal4));
    object oPla_Portal5 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_PORTAL, GetLocation(oWP_Portal5));
    object oPla_Portal6 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_PORTAL, GetLocation(oWP_Portal6));
    object oPla_Portal7 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_PORTAL, GetLocation(oWP_Portal7));
    object oPla_Portal8 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_PORTAL, GetLocation(oWP_Portal8));

    // sounds
    object oAud_Laugh1 = GetObjectByTagInArea(TAG_AUDIO_LAUGH1);
    object oAud_Laugh2 = GetObjectByTagInArea(TAG_AUDIO_LAUGH2);
    object oAud_Laugh3 = GetObjectByTagInArea(TAG_AUDIO_LAUGH3);

    //==========================================================================

    // set music (both day & night, just to be sure)
    cs_MusicBackgroundChangeDay(0.0, MUSIC_SCENE);
    cs_MusicBackgroundChangeNight(0.0, MUSIC_SCENE);

    // initial camera
    cs_CameraUseCameraWaypoint(1.0, 1);

    // start halaster moving
    cs_ActionMoveToObject(0.0, oCre_Halaster, oWP_Halaster1, FALSE, 0.0);

    // start camera 2
    cs_CameraUseCameraWaypoint(0.9, 2);

    // fade-in
    cs_CameraDoFade(0.1, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    // portal shields go up
    cs_ApplyVFXToObject(1.5, DURATION_TYPE_PERMANENT, VFX_DUR_GLOBE_INVULNERABILITY, oPla_Portal1);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GLOBE_INVULNERABILITY, oPla_Portal2);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GLOBE_INVULNERABILITY, oPla_Portal3);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GLOBE_INVULNERABILITY, oPla_Portal4);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GLOBE_INVULNERABILITY, oPla_Portal5);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GLOBE_INVULNERABILITY, oPla_Portal6);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GLOBE_INVULNERABILITY, oPla_Portal7);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_GLOBE_INVULNERABILITY, oPla_Portal8);

    // camera 3
    cs_CameraUseCameraWaypoint(2.0, 3);

    cs_MusicBackgroundChangeDay(2.0, MUSIC_BATTLE);
    cs_MusicBackgroundChangeNight(0.0, MUSIC_BATTLE);

    // laugh, turn, point
    cs_PlayAnimation(2.5, oCre_Halaster, ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 2.0);
    //cs_PlaySound(0.0, oCre_Halaster, VO_FILENAME_1);
    cs_SoundObjectPlay(0.0, oAud_Laugh1);
    cs_SetFacing(1.0, oCre_Halaster, GetFacingBetweenObjects(oWP_Halaster1, oPla_Portal1));
    cs_PlayAnimation(0.0, oCre_Halaster, ANIMATION_LOOPING_TALK_FORCEFUL, 2.1, 2.0);

    // camera 4 - show penguin spawn
    cs_CameraUseCameraWaypoint(1.0, 4);

    cs_ApplyVFXToObject(0.2, DURATION_TYPE_INSTANT, VFX_FNF_SUMMON_MONSTER_3_NO_SHAKE, oPla_Portal1, 0.0, FALSE, FALSE);
    cs_RemoveVFXFromObject(0.5, oCre_Penguin, TRUE);
    cs_RemoveVFXFromObject(0.3, oPla_Portal1);

    // go penguin go
    cs_ActionMoveToObject(0.3, oCre_Penguin, oWP_Penguin1, TRUE);
    //cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, EffectMovementSpeedIncrease(90), oCre_Penguin);

    // camera 5
    cs_CameraUseCameraWaypoint(1.5, 5);

    // laugh, turn, point
    cs_PlayAnimation(1.0, oCre_Halaster, ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 2.0);
    //cs_PlaySound(0.0, oCre_Halaster, VO_FILENAME_2);
    cs_SoundObjectPlay(0.0, oAud_Laugh2);
    cs_SetFacing(0.5, oCre_Halaster, GetFacingBetweenObjects(oWP_Halaster1, oWP_Halaster2));
    cs_PlayAnimation(0.5, oCre_Halaster, ANIMATION_LOOPING_TALK_FORCEFUL, 2.1, 2.0);

    // penguin go boom
    cs_ApplyVFXToObject(0.5, DURATION_TYPE_INSTANT, VFX_FNF_FIRESTORM_NO_SHAKE, oCre_Penguin);
    // just to make sure he's killable
    cs_SetPlotFlag(0.0, oCre_Penguin, FALSE);
    cs_SetImmortal(0.0, oCre_Penguin, FALSE);
    cs_ApplyEffectToObject(0.7, DURATION_TYPE_INSTANT, EffectDeath(FALSE, FALSE), oCre_Penguin);

    // laugh, turn, point
    cs_PlayAnimation(0.8, oCre_Halaster, ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 2.0);
    //cs_PlaySound(0.0, oCre_Halaster, VO_FILENAME_3);
    cs_SoundObjectPlay(0.0, oAud_Laugh3);
    cs_SetFacing(1.0, oCre_Halaster, GetFacingBetweenObjects(oWP_Halaster1, oWP_Halaster3));
    cs_PlayAnimation(0.0, oCre_Halaster, ANIMATION_LOOPING_TALK_FORCEFUL, 2.0, 2.0);

    // set last camera
    cs_CameraUseCameraWaypoint(0.0, 6);

    // black-out
    cs_CameraDoFade(1.2, CS_FADE_TYPE_BLACK);

    // clean-up
    cs_DestroyObject(2.0, oCre_Halaster);
    cs_DestroyObject(0.0, oCre_Penguin);
    cs_DestroyObject(0.0, oPla_Portal1);
    cs_DestroyObject(0.0, oPla_Portal2);
    cs_DestroyObject(0.0, oPla_Portal3);
    cs_DestroyObject(0.0, oPla_Portal4);
    cs_DestroyObject(0.0, oPla_Portal5);
    cs_DestroyObject(0.0, oPla_Portal6);
    cs_DestroyObject(0.0, oPla_Portal7);
    cs_DestroyObject(0.0, oPla_Portal8);

    cs_SoundObjectStop(0.0, oAud_Laugh1);
    cs_SoundObjectStop(0.0, oAud_Laugh2);
    cs_SoundObjectStop(0.0, oAud_Laugh3);

    cs_EndCutscene(1.5, FALSE, TRUE, FADE_SPEED_FAST);
}
