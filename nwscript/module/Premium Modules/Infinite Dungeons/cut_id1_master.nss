//::///////////////////////////////////////////////
//:: cut_id1_master
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Masterius boss battle intro cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 9, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"


// SPEAKSTRINGS
///////////////

const string S_MINION1 = "My king, intruders approach.";
const string S_MINION2 = "Adventurers, King Masterius. Maybe powerful.";

// CONSTANTS
//////////////

const int MUSIC_SCENE = TRACK_TEMPLEEVIL;
const int MUSIC_BATTLE = 76; // ID music

const string WP_MASTERIUS = "ID1_STATIC_WP_MASTERIUS";
const string WP_MINION1_1 = "ID1_STATIC_WP_CS_MINION1_1";
const string WP_MINION1_2 = "ID1_STATIC_WP_CS_MINION1_2";
const string WP_MINION2_1 = "ID1_STATIC_WP_CS_MINION2_1";
const string WP_MINION2_2 = "ID1_STATIC_WP_CS_MINION2_2";

const string TAG_MASTERIUS = "id1_cs_mst_mstrs";
const string TAG_MINION1 = "id1_cs_mst_min1";
const string TAG_MINION2 = "id1_cs_mst_min2";

void main()
{
    // using incremented delay type
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    // Object setup

    // waypoints
    object oWP_Masterius = GetObjectByTagInArea(WP_MASTERIUS);
    object oWP_Minion1_1 = GetObjectByTagInArea(WP_MINION1_1);
    object oWP_Minion1_2 = GetObjectByTagInArea(WP_MINION1_2);
    object oWP_Minion2_1 = GetObjectByTagInArea(WP_MINION2_1);
    object oWP_Minion2_2 = GetObjectByTagInArea(WP_MINION2_2);

    // creatures
    object oCre_Masterius = CreateObject(OBJECT_TYPE_CREATURE, TAG_MASTERIUS, GetLocation(oWP_Masterius));
    object oCre_Minion1 = CreateObject(OBJECT_TYPE_CREATURE, TAG_MINION1, GetLocation(oWP_Minion1_1));
    object oCre_Minion2 = CreateObject(OBJECT_TYPE_CREATURE, TAG_MINION2, GetLocation(oWP_Minion2_1));


   //==========================================================================

    // set music (both day & night, just to be sure)
    cs_MusicBackgroundChangeDay(0.0, MUSIC_SCENE);
    cs_MusicBackgroundChangeNight(0.0, MUSIC_SCENE);

    // initial camera
    cs_CameraUseCameraWaypoint(0.8, 1);

    // start minions walking
    cs_ActionMoveToObject(0.6, oCre_Minion1, oWP_Minion1_2, FALSE, 0.1);
    cs_ActionMoveToObject(0.0, oCre_Minion2, oWP_Minion2_2, FALSE, 0.1);

    // fade-in
    cs_CameraDoFade(0.2, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    // minion speaks
    cs_SpeakString(4.0, oCre_Minion2, S_MINION1);
    cs_SpeakString(2.0, oCre_Minion1, S_MINION2);

    // masterius laughs
    cs_PlayAnimation(2.5, oCre_Masterius, ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 3.0);
    cs_PlayVoiceChat(0.0, oCre_Masterius, VOICE_CHAT_LAUGH);

    cs_MusicBackgroundChangeDay(1.0, MUSIC_BATTLE);
    cs_MusicBackgroundChangeNight(0.0, MUSIC_BATTLE);

    // camera 2
    cs_CameraUseCameraWaypoint(1.0, 2);

    // minions walk away
    cs_ActionMoveToObject(0.5, oCre_Minion1, oWP_Minion1_1);
    cs_ActionMoveToObject(0.0, oCre_Minion2, oWP_Minion2_1);

    // start very slow zooom
    cs_CameraUseCameraWaypoint(0.5, 3);
    // start buffing
    cs_PlayAnimation(0.0, oCre_Masterius, ANIMATION_LOOPING_CONJURE1, 1.0, 10.0);
    cs_ApplyVFXToObject(1.0, DURATION_TYPE_TEMPORARY, VFX_DUR_PROT_EPIC_ARMOR, oCre_Masterius, 1.5);
    cs_ApplyVFXToObject(1.0, DURATION_TYPE_TEMPORARY, VFX_DUR_PROT_PREMONITION, oCre_Masterius, 1.5);
    cs_ApplyVFXToObject(1.0, DURATION_TYPE_TEMPORARY, VFX_DUR_ELEMENTAL_SHIELD, oCre_Masterius, 1.5);

    // fade-out
    cs_CameraDoFade(1.0, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);

    // clean-up
    cs_DestroyObject(2.5, oCre_Masterius);
    cs_DestroyObject(0.0, oCre_Minion1);
    cs_DestroyObject(0.0, oCre_Minion2);

    cs_EndCutscene(0.1, FALSE, TRUE, FADE_SPEED_FAST);
}
