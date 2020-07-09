//::///////////////////////////////////////////////
//:: cut_id1_hlsd
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Halaster surrender cutscene.

    Note: this cutscene is NOT abortable because
    of the delayed things I'm doing. Which isn't
    really the right way to do it, but it works
    as long as the scene isn't abortable. And
    aborting this scene would actually be really
    awkward anyway.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 9, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"

// SPEAKSTRINGS
/////////////////

const string S_DIALOG_1 = "Stop! I yield to you. (I can't believe I am defeated by this nobody. I wonder what the cook is preparing for supper? Some manticore soup would hit the spot about now.)";
const string S_DIALOG_2 = "This shouldn't be happening. You should never have made it past the magical protections I put on all the entrances into Undermountain!";
const string S_DIALOG_3 = "Undermountain is not meant to be closed! It was never meant to be closed! And you would know that, just like you would have known about some of my secret entrances into Undermountain, if you were the real Halaster! (I'm getting so hungry.)";

const float VO_LENGTH_1 = 11.98;
const float VO_LENGTH_2 = 9.19;
const float VO_LENGTH_3 = 13.5;

const string TAG_AUDIO_VO_1 = "ID1_STATIC_hlst_sur1";
const string TAG_AUDIO_VO_2 = "ID1_STATIC_hlst_sur2";
const string TAG_AUDIO_VO_3 = "ID1_STATIC_hlst_sur3";

// CONSTANTS
//////////////

const int MUSIC_SCENE = TRACK_HOTU_HELLFROZEOVER;

const string WP_HALASTER1_1 = "ID1_STATIC_CS_HALASTER1_11";
const string WP_HALASTER2_1 = "ID1_STATIC_CS_HALASTER2_11";
const string WP_HALASTER2_2 = "ID1_STATIC_CS_HALASTER2_12";

// 1st Halaster = one player just defeated
// 2nd Halaster = one little Timmy turns into
// 3rd Halaster = invisible one used for placement of text
const string TAG_HALASTER1 = "id1_halaster";
const string RESREF_HALASTER2 = "id1_halaster_clo";
const string RESREF_TIMMY = "id1_cuttimmy";
const string RESREF_HALASTER3 = "id1_cs_halaster";

void cs_CreateHalaster2(object oLoc, int nCutNumber);

void main()
{
    int nCutNumber = cs_GetCutsceneRunning();

    // using incremented delay type
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    // Object setup

    // waypoints
    object oWP_Halaster1_1 = GetObjectByTagInArea(WP_HALASTER1_1);
    object oWP_Halaster2_1 = GetObjectByTagInArea(WP_HALASTER2_1);
    object oWP_Halaster2_2 = GetObjectByTagInArea(WP_HALASTER2_2);

    // creatures
    object oCre_Halaster1 = GetObjectByTagInArea(TAG_HALASTER1);
    cs_RemoveVFXFromObject(0.0, oCre_Halaster1, TRUE);

    object oCre_Halaster3 = CreateObject(OBJECT_TYPE_CREATURE, RESREF_HALASTER3, GetLocation(oWP_Halaster2_2));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Halaster3);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Halaster3, 0.0, FALSE, FALSE);

    object oCre_Timmy = CreateObject(OBJECT_TYPE_CREATURE, RESREF_TIMMY, GetLocation(oWP_Halaster2_1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Timmy);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectMovementSpeedDecrease(10), oCre_Timmy);

    // sounds
    object oAud_Dialog1 = GetObjectByTagInArea(TAG_AUDIO_VO_1);
    object oAud_Dialog2 = GetObjectByTagInArea(TAG_AUDIO_VO_2);
    object oAud_Dialog3 = GetObjectByTagInArea(TAG_AUDIO_VO_3);

    //==========================================================================

    // set music (both day & night, just to be sure)
    cs_MusicBackgroundChangeDay(0.0, MUSIC_SCENE);
    cs_MusicBackgroundChangeNight(0.0, MUSIC_SCENE);

    // initial camera
    cs_CameraUseCameraWaypoint(0.5, 11);

    // move Halaster1
    cs_ClearAllActions(0.0, oCre_Halaster1);
    cs_ActionJumpToLocation(0.1, oCre_Halaster1, GetLocation(oWP_Halaster1_1));

    // start camera 2
    cs_CameraUseCameraWaypoint(0.4, 12);

    // fade-in
    cs_CameraDoFade(0.2, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    // start little timmy walking
    cs_ActionMoveToObject(0.0, oCre_Timmy, oWP_Halaster2_2, FALSE, 0.0);

    // dialog
    cs_SpeakString(1.0, oCre_Halaster1, S_DIALOG_1);
    cs_SoundObjectPlay(0.0, oAud_Dialog1);
    cs_PlayAnimation(0.0, oCre_Halaster1, ANIMATION_LOOPING_TALK_NORMAL, 1.0, VO_LENGTH_1 - 1.0);

    cs_SetFacingPoint(VO_LENGTH_1, oCre_Halaster1, GetPosition(oWP_Halaster2_2));
    cs_SpeakString(2.0, oCre_Halaster1, S_DIALOG_2);
    cs_SoundObjectPlay(0.0, oAud_Dialog2);
    cs_PlayAnimation(0.0, oCre_Halaster1, ANIMATION_LOOPING_TALK_NORMAL, 1.0, VO_LENGTH_2);

    // camera 3
    cs_CameraUseCameraWaypoint(0.0, 13);

    cs_SpeakString(VO_LENGTH_2, oCre_Halaster3, S_DIALOG_3);
    cs_SoundObjectPlay(0.0, oAud_Dialog3);

    DelayCommand(cs_GetDelay()+2.0, cs_CreateHalaster2(oCre_Timmy, nCutNumber));
    cs_DestroyObject(2.5, oCre_Timmy);

    // clean-up
    cs_SoundObjectStop(VO_LENGTH_3 - 1.5, oAud_Dialog1);
    cs_SoundObjectStop(0.0, oAud_Dialog2);
    cs_SoundObjectStop(0.0, oAud_Dialog3);

    cs_DestroyObject(0.0, oCre_Halaster3);

    cs_EndCutscene(0.2);
}

void cs_CreateHalaster2(object oLoc, int nCutNumber)
{
    if(csm_CutsceneAborted(nCutNumber, OBJECT_SELF)) return;

    object oHalaster2 = CreateObject(OBJECT_TYPE_CREATURE, RESREF_HALASTER2, GetLocation(oLoc));
    //ChangeToStandardFaction(oHalaster2, STANDARD_FACTION_COMMONER);
    DelayCommand(0.5, AssignCommand(oHalaster2, PlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 2.5)));
    DelayCommand(3.0, AssignCommand(oHalaster2, PlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, VO_LENGTH_3 - 3.0)));
}
