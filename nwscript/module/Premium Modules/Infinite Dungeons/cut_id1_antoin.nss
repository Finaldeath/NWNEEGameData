//::///////////////////////////////////////////////
//:: cut_id1_antoin
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Antoine boss battle intro cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 9, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"

// SPEAKSTRINGS
///////////////

const string S_ANTOINE = "Tonight, we feast!";

// CONSTANTS
//////////////

const int MUSIC_SCENE = TRACK_FORESTDAY1;
const int MUSIC_BATTLE = 76; // ID music

const string TAG_ANTOINE_HUMAN = "id1_cs_ant_ant1";
const string TAG_ANTOINE_BOAR = "id1_cs_ant_ant2";
const string TAG_BOAR = "id1_cs_ant_boar";
const string TAG_NPC1 = "id1_cs_ant_npc1";
const string TAG_NPC2 = "id1_cs_ant_npc2";
const string TAG_NPC3 = "id1_cs_ant_npc3";
const string TAG_NPC4 = "id1_cs_ant_npc4";
const string TAG_NPC5 = "id1_cs_ant_npc5";

const string WP_BOAR1_1 = "ID1_STATIC_WP_CS_BOAR1_1";
const string WP_BOAR2_1 = "ID1_STATIC_WP_CS_BOAR2_1";
const string WP_BOAR3_1 = "ID1_STATIC_WP_CS_BOAR3_1";
const string WP_BOAR4_1 = "ID1_STATIC_WP_CS_BOAR4_1";
const string WP_BOAR2_2 = "ID1_STATIC_WP_CS_BOAR2_2";
const string WP_BOAR3_2 = "ID1_STATIC_WP_CS_BOAR3_2";
const string WP_BOAR4_2 = "ID1_STATIC_WP_CS_BOAR4_2";
const string WP_BOAR2_3 = "ID1_STATIC_WP_CS_BOAR2_3";
const string WP_BOAR3_3 = "ID1_STATIC_WP_CS_BOAR3_3";
const string WP_BOAR4_3 = "ID1_STATIC_WP_CS_BOAR4_3";
const string WP_ANTOINE_1 = "ID1_STATIC_WP_CS_ANT_1";
const string WP_NPC1_1 = "ID1_STATIC_WP_CS_NPC1_1";
const string WP_NPC2_1 = "ID1_STATIC_WP_CS_NPC2_1";
const string WP_NPC3_1 = "ID1_STATIC_WP_CS_NPC3_1";
const string WP_NPC4_1 = "ID1_STATIC_WP_CS_NPC4_1";
const string WP_NPC5_1 = "ID1_STATIC_WP_CS_NPC5_1";
const string WP_ANTOINE_2 = "ID1_STATIC_WP_CS_ANT_2";
const string WP_NPC1_2 = "ID1_STATIC_WP_CS_NPC1_2";
const string WP_NPC2_2 = "ID1_STATIC_WP_CS_NPC2_2";
const string WP_NPC3_2 = "ID1_STATIC_WP_CS_NPC3_2";
const string WP_NPC4_2 = "ID1_STATIC_WP_CS_NPC4_2";
const string WP_NPC5_2 = "ID1_STATIC_WP_CS_NPC5_2";

const int APPEARANCE_TYPE_ANTOINE = 997;
const int APPEARANCE_TYPE_WEREBOAR = 996;

void main()
{
    // using incremented delay type
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    // Object setup

    // waypoints
    object oWP_Boar1_1 = GetObjectByTagInArea(WP_BOAR1_1);
    object oWP_Boar2_1 = GetObjectByTagInArea(WP_BOAR2_1);
    object oWP_Boar3_1 = GetObjectByTagInArea(WP_BOAR3_1);
    object oWP_Boar4_1 = GetObjectByTagInArea(WP_BOAR4_1);
    object oWP_Boar2_2 = GetObjectByTagInArea(WP_BOAR2_2);
    object oWP_Boar3_2 = GetObjectByTagInArea(WP_BOAR3_2);
    object oWP_Boar4_2 = GetObjectByTagInArea(WP_BOAR4_2);
    object oWP_Boar2_3 = GetObjectByTagInArea(WP_BOAR2_3);
    object oWP_Boar3_3 = GetObjectByTagInArea(WP_BOAR3_3);
    object oWP_Boar4_3 = GetObjectByTagInArea(WP_BOAR4_3);
    object oWP_Antoine_1 = GetObjectByTagInArea(WP_ANTOINE_1);
    object oWP_NPC1_1 = GetObjectByTagInArea(WP_NPC1_1);
    object oWP_NPC2_1 = GetObjectByTagInArea(WP_NPC2_1);
    object oWP_NPC3_1 = GetObjectByTagInArea(WP_NPC3_1);
    object oWP_NPC4_1 = GetObjectByTagInArea(WP_NPC4_1);
    object oWP_NPC5_1 = GetObjectByTagInArea(WP_NPC5_1);
    object oWP_Antoine_2 = GetObjectByTagInArea(WP_ANTOINE_2);
    object oWP_NPC1_2 = GetObjectByTagInArea(WP_NPC1_2);
    object oWP_NPC2_2 = GetObjectByTagInArea(WP_NPC2_2);
    object oWP_NPC3_2 = GetObjectByTagInArea(WP_NPC3_2);
    object oWP_NPC4_2 = GetObjectByTagInArea(WP_NPC4_2);
    object oWP_NPC5_2 = GetObjectByTagInArea(WP_NPC5_2);

    // creatures
    object oCre_Boar1 = CreateObject(OBJECT_TYPE_CREATURE, TAG_BOAR, GetLocation(oWP_Boar1_1));
    object oCre_Boar2 = CreateObject(OBJECT_TYPE_CREATURE, TAG_BOAR, GetLocation(oWP_Boar2_1));
    object oCre_Boar3 = CreateObject(OBJECT_TYPE_CREATURE, TAG_BOAR, GetLocation(oWP_Boar3_1));
    object oCre_Boar4 = CreateObject(OBJECT_TYPE_CREATURE, TAG_BOAR, GetLocation(oWP_Boar4_1));
    object oCre_Antoine = CreateObject(OBJECT_TYPE_CREATURE, TAG_ANTOINE_HUMAN, GetLocation(oWP_Antoine_1));
    object oCre_NPC1 = CreateObject(OBJECT_TYPE_CREATURE, TAG_NPC1, GetLocation(oWP_NPC1_1));
    object oCre_NPC2 = CreateObject(OBJECT_TYPE_CREATURE, TAG_NPC2, GetLocation(oWP_NPC2_1));
    object oCre_NPC3 = CreateObject(OBJECT_TYPE_CREATURE, TAG_NPC3, GetLocation(oWP_NPC3_1));
    object oCre_NPC4 = CreateObject(OBJECT_TYPE_CREATURE, TAG_NPC4, GetLocation(oWP_NPC4_1));
    object oCre_NPC5 = CreateObject(OBJECT_TYPE_CREATURE, TAG_NPC5, GetLocation(oWP_NPC5_1));

    // placeables

    //==========================================================================

    // set music (both day & night, just to be sure)
    cs_MusicBackgroundChangeDay(0.0, MUSIC_SCENE);
    cs_MusicBackgroundChangeNight(0.0, MUSIC_SCENE);

    // initial camera
    cs_CameraUseCameraWaypoint(0.8, 1);

    // set Antoine to were forms, so the model is cached for later
    cs_SetCreatureAppearanceType(0.0, oCre_Antoine, APPEARANCE_TYPE_WEREBOAR);
    // and back again
    cs_SetCreatureAppearanceType(1.0, oCre_Antoine, APPEARANCE_TYPE_ANTOINE);

    // some boar movements
    cs_ActionMoveToObject(0.2, oCre_Boar3, oWP_Boar3_2, FALSE, 0.1);
    cs_ActionMoveToObject(0.0, oCre_Boar4, oWP_Boar4_2, FALSE, 0.1);

    // start camera turn
    cs_CameraUseCameraWaypoint(0.5, 2);

    // fade-in
    cs_CameraDoFade(0.4, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    // make a boar do a head turn, then walk up
    cs_PlayAnimation(0.4, oCre_Boar2, ANIMATION_FIREFORGET_HEAD_TURN_RIGHT);
    cs_ActionMoveToObject(2.0, oCre_Boar2, oWP_Boar2_2, FALSE, 0.1);

    // boar does a head turn
    cs_PlayAnimation(1.3, oCre_Boar1, ANIMATION_FIREFORGET_HEAD_TURN_LEFT);

    // boar gets shot, others run away
    // make 3 of the party attack the boar. chances are at least one will hit
    cs_ActionAttack(1.5, oCre_NPC1, oCre_Boar1);
    cs_ActionAttack(0.0, oCre_NPC2, oCre_Boar1);
    cs_ActionAttack(0.0, oCre_NPC4, oCre_Boar1);

    cs_ActionMoveToObject(0.5, oCre_Boar2, oWP_Boar2_3, TRUE, 0.1);
    cs_ActionMoveToObject(0.2, oCre_Boar3, oWP_Boar3_3, TRUE, 0.1);
    cs_ActionMoveToObject(0.1, oCre_Boar4, oWP_Boar4_3, TRUE, 0.1);

    // just in case they all rolled a 1 and missed
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_INSTANT, EffectDeath(FALSE, FALSE), oCre_Boar1);

    // stop attack
    cs_ClearAllActions(0.7, oCre_NPC1);
    cs_ClearAllActions(0.0, oCre_NPC2);
    cs_ClearAllActions(0.0, oCre_NPC4);

    // start moving hunting party
    cs_ActionMoveToObject(0.0, oCre_Antoine, oWP_Antoine_2, FALSE, 0.1);
    cs_ActionMoveToObject(0.5, oCre_NPC1, oWP_NPC1_2, FALSE, 0.1);
    cs_ActionMoveToObject(0.0, oCre_NPC2, oWP_NPC2_2, FALSE, 0.1);
    cs_ActionMoveToObject(0.0, oCre_NPC3, oWP_NPC3_2, FALSE, 0.1);
    cs_ActionMoveToObject(0.0, oCre_NPC4, oWP_NPC4_2, FALSE, 0.1);
    cs_ActionMoveToObject(0.0, oCre_NPC5, oWP_NPC5_2, FALSE, 0.1);

    // turn camera to hunting party, dead boar in foreground
    cs_CameraUseCameraWaypoint(0.5, 3);

    // party gets close, go to close-up shot
    cs_CameraUseCameraWaypoint(2.5, 4);

    // victory animation and text
    cs_PlayAnimation(1.5, oCre_Antoine, ANIMATION_FIREFORGET_VICTORY1);
    cs_SpeakString(0.2, oCre_Antoine, S_ANTOINE);

    // vfx for wereboar transformation
    cs_ApplyVFXToObject(1.0, DURATION_TYPE_INSTANT, VFX_IMP_POLYMORPH, oCre_Antoine);

    cs_MusicBackgroundChangeDay(0.0, MUSIC_BATTLE);
    cs_MusicBackgroundChangeNight(0.0, MUSIC_BATTLE);

    cs_PlayAnimation(1.0, oCre_NPC1, ANIMATION_FIREFORGET_VICTORY3);

    // slight zoom
    cs_CameraUseCameraWaypoint(0.0, 5);

    // change to wereboar appearance
    cs_SetCreatureAppearanceType(0.0, oCre_Antoine, APPEARANCE_TYPE_WEREBOAR);

    cs_PlayAnimation(1.0, oCre_NPC3, ANIMATION_FIREFORGET_VICTORY1);
    cs_PlayAnimation(1.0, oCre_NPC4, ANIMATION_FIREFORGET_VICTORY2);

    cs_ApplyVFXToObject(0.0, DURATION_TYPE_INSTANT, VFX_IMP_POLYMORPH, oCre_NPC2);
    cs_ApplyVFXToObject(0.6, DURATION_TYPE_INSTANT, VFX_IMP_POLYMORPH, oCre_NPC5);
    cs_SetCreatureAppearanceType(0.4, oCre_NPC2, APPEARANCE_TYPE_WERECAT);
    // fade-out
    cs_CameraDoFade(0.4, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);

    // clean-up
    cs_DestroyObject(1.0, oCre_Antoine);
    cs_DestroyObject(0.0, oCre_Boar1);
    cs_DestroyObject(0.0, oCre_Boar2);
    cs_DestroyObject(0.0, oCre_Boar3);
    cs_DestroyObject(0.0, oCre_Boar4);
    cs_DestroyObject(0.0, oCre_NPC1);
    cs_DestroyObject(0.0, oCre_NPC2);
    cs_DestroyObject(0.0, oCre_NPC3);
    cs_DestroyObject(0.0, oCre_NPC4);
    cs_DestroyObject(0.0, oCre_NPC5);

    cs_EndCutscene(1.5, FALSE, TRUE, FADE_SPEED_FAST);
}
