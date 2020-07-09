//::///////////////////////////////////////////////
//:: cut_id1_narr01
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    First narrator cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 9, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"
#include "inc_id1_debug"
#include "x2_inc_toollib"

// SPEAKSTRINGS
///////////////

const string S_NARRATION_1 = "Some souls are born, they live their little lives, and then they die. But I was never one of those.";
const string S_NARRATION_2 = "You see, dark deals are struck in the alleys of Waterdeep but the darkest deeds occur in a place called Undermountain, far below.";
const string S_NARRATION_3 = "Plots are hatched, coins change hands, dark doors are opened.";
const string S_NARRATION_4 = "Many heroes have entered this ever-changing labyrinth, intent on destroying its madness...";
const string S_NARRATION_5 = "but they were too weak!";
const string S_NARRATION_6 = "But I am a patient soul, and someday one will come who can unravel the secrets of Undermountain.";

const float VO_LENGTH_1 = 7.16;
const float VO_LENGTH_2 = 9.92;
const float VO_LENGTH_3 = 6.31;
const float VO_LENGTH_4 = 6.22;
const float VO_LENGTH_5 = 2.65;
const float VO_LENGTH_6 = 6.01;

const string TAG_AUDIO_VO_1 = "ID1_STATIC_narr1_1";
const string TAG_AUDIO_VO_2 = "ID1_STATIC_narr1_2";
const string TAG_AUDIO_VO_3 = "ID1_STATIC_narr1_3";
const string TAG_AUDIO_VO_4 = "ID1_STATIC_narr1_4";
const string TAG_AUDIO_VO_5 = "ID1_STATIC_narr1_5";
const string TAG_AUDIO_VO_6 = "ID1_STATIC_narr1_6";

// CONSTANTS
//////////////

const int MUSIC_SCENE = TRACK_HOTU_HELLFROZEOVER;

//const string WP_ADVENTURER0 = "ID1_CS_ADVN0";
const string WP_ADVENTURER1 = "ID1_CS_ADVN1";
const string WP_ADVENTURER2 = "ID1_CS_ADVN2";
//const string WP_ADVENTURER3 = "ID1_CS_ADVN3";
//const string WP_ADVENTURER4 = "ID1_CS_ADVN4";
const string WP_ADVENTURER5 = "ID1_CS_ADVN5";
const string WP_ADVENTURER6 = "ID1_CS_ADVN6";
const string WP_OGRE1_1 = "ID1_CS_OGRE1_1";
const string WP_OGRE1_2 = "ID1_CS_OGRE1_2";
const string WP_OGRE2_1 = "ID1_CS_OGRE2_1";
const string WP_OGRE2_2 = "ID1_CS_OGRE2_2";
const string WP_MAP = "ID1_CS_MAP";
const string WP_LIGHT = "ID1_CS_LIGHT";
const string WP_NARR1 = "ID1_CS_NARR1";
const string WP_TIMMY = "ID1_CS_TIMMY";
const string WP_HALASTER1 = "ID1_CS_HALASTER1";
const string WP_HALASTER2 = "ID1_CS_HALASTER2";

const string TAG_NARRATOR = "id1_cs_narrator";
const string TAG_REALTIMMY = "id1_littletimmy";
const string TAG_TIMMY = "id1_cs_nar5_tim";
const string TAG_ADVENTURER = "id1_cs_nar1_advn";
const string TAG_OGRE = "id1_cs_nar1_ogre";
const string TAG_BLOODSTAIN = "plc_bloodstain";
const string TAG_LIGHT = "plc_flamesmall";
const string TAG_HALASTER = "id1_cs_halaster";

const string TILE01_RESREF = "tile01";
const string TILE02_RESREF = "tile02";
const string TILE03_RESREF = "tile03";
const string TILE04_RESREF = "tile04";
const string TILE05_RESREF = "tile05";
const string TILE06_RESREF = "tile06";
const string TILE07_RESREF = "tile07";
const string TILE08_RESREF = "tile08";
const string TILE09_RESREF = "tile09";
const string TILE10_RESREF = "tile10";
const string TILE11_RESREF = "tile11";
const string TILE12_RESREF = "tile12";

// FUNCTION DECLARATIONS
////////////////////////

void CreateFakeDungeonMap(object oCreator);
void cs_TLChangeAreaGroundTiles(object oArea, int nGroundTileConst, float fZOffset, int nCutNumber);
void cs_TLResetAreaGroundTiles(int nCutNumber);

void main()
{
    // using incremented delay type
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    int nCutNumber = cs_GetCutsceneRunning();
    // fog  - store current settings
    int nOriginalFogDay = GetFogColor(FOG_TYPE_SUN, OBJECT_SELF);
    int nOriginalFogNight = GetFogColor(FOG_TYPE_MOON, OBJECT_SELF);
    int nOriginalFogAmountDay = GetFogAmount(FOG_TYPE_SUN, OBJECT_SELF);
    int nOriginalFogAmountNight = GetFogAmount(FOG_TYPE_MOON, OBJECT_SELF);
    // get current music track settings
    int nMusicDay = MusicBackgroundGetDayTrack(OBJECT_SELF);
    int nMusicNight = MusicBackgroundGetNightTrack(OBJECT_SELF);

    float fDelay;

    // Object setup

    // waypoints
    //object oWP_Adventurer0 = GetObjectByTagInArea(WP_ADVENTURER0);
    object oWP_Adventurer1 = GetObjectByTagInArea(WP_ADVENTURER1);
    object oWP_Adventurer2 = GetObjectByTagInArea(WP_ADVENTURER2);
    //object oWP_Adventurer3 = GetObjectByTagInArea(WP_ADVENTURER3);
    //object oWP_Adventurer4 = GetObjectByTagInArea(WP_ADVENTURER4);
    object oWP_Adventurer5 = GetObjectByTagInArea(WP_ADVENTURER5);
    object oWP_Adventurer6 = GetObjectByTagInArea(WP_ADVENTURER6);
    object oWP_Ogre1_1 = GetObjectByTagInArea(WP_OGRE1_1);
    object oWP_Ogre1_2 = GetObjectByTagInArea(WP_OGRE1_2);
    object oWP_Ogre2_1 = GetObjectByTagInArea(WP_OGRE2_1);
    object oWP_Ogre2_2 = GetObjectByTagInArea(WP_OGRE2_2);
    object oWP_Map = GetObjectByTagInArea(WP_MAP);
    object oWP_Light = GetObjectByTagInArea(WP_LIGHT);
    object oWP_Narr1 = GetObjectByTagInArea(WP_NARR1);
    object oWP_Timmy = GetObjectByTagInArea(WP_TIMMY);
    object oWP_Halaster1 = GetObjectByTagInArea(WP_HALASTER1);
    object oWP_Halaster2 = GetObjectByTagInArea(WP_HALASTER2);

    // creatures
    object oCre_Narrator = CreateObject(OBJECT_TYPE_CREATURE, TAG_NARRATOR, cs_GetCameraWaypointLocation(1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Narrator);
    object oCre_Narrator2 = CreateObject(OBJECT_TYPE_CREATURE, TAG_NARRATOR, GetLocation(oWP_Narr1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Narrator);

    object oCre_RealTimmy = GetObjectByTagInArea(TAG_REALTIMMY);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_RealTimmy);

    object oCre_Adventurer = CreateObject(OBJECT_TYPE_CREATURE, TAG_ADVENTURER, GetLocation(oWP_Adventurer2));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Adventurer);

    object oCre_Timmy = CreateObject(OBJECT_TYPE_CREATURE, TAG_TIMMY, GetLocation(oWP_Timmy));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Timmy);

    object oCre_Ogre1 = CreateObject(OBJECT_TYPE_CREATURE, TAG_OGRE, GetLocation(oWP_Ogre1_1));
    object oCre_Ogre2 = CreateObject(OBJECT_TYPE_CREATURE, TAG_OGRE, GetLocation(oWP_Ogre2_1));
    // cutscene-ghost so they don't bump each other
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Ogre1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Ogre2);

    object oCre_Halaster = CreateObject(OBJECT_TYPE_CREATURE, TAG_HALASTER, GetLocation(oWP_Halaster1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Halaster);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectMovementSpeedDecrease(15), oCre_Halaster);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Halaster);


    // placeables
    // offsetting the position of the bloodstain
    vector vPos = GetPosition(oWP_Adventurer6);
    vPos = Vector(vPos.x + 0.2, vPos.y - 0.1, vPos.z + 0.04);
    location lLoc = Location(OBJECT_SELF, vPos, 0.0);
    object oPla_Bloodstain = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_BLOODSTAIN, lLoc);
    // making bloostain invisible for now
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oPla_Bloodstain);

    // this placeable is just to provide light from offscreen in the first shot
    object oPla_Light = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_LIGHT, GetLocation(oWP_Light));

    // sounds
    object oAud_VO1 = GetObjectByTagInArea(TAG_AUDIO_VO_1);
    object oAud_VO2 = GetObjectByTagInArea(TAG_AUDIO_VO_2);
    object oAud_VO3 = GetObjectByTagInArea(TAG_AUDIO_VO_3);
    object oAud_VO4 = GetObjectByTagInArea(TAG_AUDIO_VO_4);
    object oAud_VO5 = GetObjectByTagInArea(TAG_AUDIO_VO_5);
    object oAud_VO6 = GetObjectByTagInArea(TAG_AUDIO_VO_6);

    // create the map
    CreateFakeDungeonMap(oWP_Map);

// PART 1 =====================================================================

    cs_MusicBackgroundChangeDay(0.0, MUSIC_SCENE);
    cs_MusicBackgroundChangeNight(0.0, MUSIC_SCENE);

    // initial camera
    cs_CameraUseCameraWaypoint(0.8, 1);

    // set thick fog, it looks neat
    cs_SetFogAmount(0.0, FOG_TYPE_SUN, 100);

    // fade-in
    cs_CameraDoFade(0.9, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

// VO START
    fDelay = cs_GetDelay();

    cs_SoundObjectPlay(2.0, oAud_VO1);
    cs_SpeakString(0.0, oCre_Narrator2, S_NARRATION_1);

    cs_SoundObjectPlay(VO_LENGTH_1, oAud_VO2);
    cs_SpeakString(0.0, oCre_Narrator2, S_NARRATION_2);

    cs_SoundObjectPlay(VO_LENGTH_2, oAud_VO3);
    cs_SpeakString(0.0, oCre_Narrator2, S_NARRATION_3);

    cs_ResetDelay(-1.0, fDelay);
// VO END

    // start camera 2 (slow zoom out)
    cs_CameraUseCameraWaypoint(2.0, 2);

    // This section should be ~23 seconds. I'll get the delay now and use it
    // (plus 23 seconds) for ending part 1. I can mess with the timings on
    // the rest of the actions in part 1 without affecting the overall timing.
    fDelay = cs_GetDelay();

    // start Timmy talking - otherwise he likes to turn his head because of the speakstrings
    cs_PlayAnimation(0.0, oCre_Timmy, ANIMATION_LOOPING_TALK_NORMAL, 1.0, 20.0);

    // adventurer walks in from stage right
    //cs_ActionMoveToObject(8.0, oCre_Adventurer, oWP_Adventurer2, FALSE, 0.1);
    //cs_ActionSetFacing(0.1, oCre_Adventurer, GetFacingBetweenObjects(oWP_Adventurer2, oCre_Timmy));

    // Timmy & adventurer talking
    //cs_PlayAnimation(0.5, oCre_Timmy, ANIMATION_LOOPING_TALK_NORMAL, 1.0, 10.0);
    cs_PlayAnimation(8.5, oCre_Timmy, ANIMATION_LOOPING_TALK_NORMAL, 1.0, 10.0);
    cs_PlayAnimation(2.5, oCre_Adventurer, ANIMATION_LOOPING_TALK_NORMAL, 1.0, 10.0);
    cs_PlayAnimation(4.0, oCre_Timmy, ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0);
    cs_PlayAnimation(3.0, oCre_Adventurer, ANIMATION_LOOPING_TALK_PLEADING, 1.0, 3.0);
    cs_PlayAnimation(1.5, oCre_Timmy, ANIMATION_LOOPING_TALK_NORMAL, 1.0, 10.0);
    cs_PlayAnimation(1.2, oCre_Adventurer, ANIMATION_LOOPING_TALK_NORMAL, 1.0, 10.0);

    // fade-out
    cs_ResetDelay(-1.0, fDelay);
    cs_CameraDoFade(22.0, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);

// PART 2 =====================================================================

    // move adventurer over to other room
    cs_ClearAllActions(1.5, oCre_Adventurer);
    cs_ActionJumpToObject(0.1, oCre_Adventurer, oWP_Adventurer5);

    // camera 5, looking over adventurer and map
    cs_CameraUseCameraWaypoint(0.0, 5);
    cs_ActionJumpToLocation(0.0, oCre_Narrator, cs_GetCameraWaypointLocation(5));

    // reset fog
    cs_SetFogAmount(0.0, FOG_TYPE_SUN, nOriginalFogAmountNight);

    // get rid of extra light in part 1, so it's gone in case I use that
    // part of the area in part 3
    cs_DestroyObject(0.0, oPla_Light);

    // fade-in
    cs_CameraDoFade(1.3, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_MEDIUM);

    // VO
    cs_SoundObjectPlay(0.0, oAud_VO4);
    cs_SpeakString(0.0, oCre_Narrator, S_NARRATION_4);

    // adventurer doing something with map
    cs_PlayAnimation(0.0, oCre_Adventurer, ANIMATION_LOOPING_GET_LOW, 1.0, 5.0);

    // move camera back, lower angle
    cs_CameraUseCameraWaypoint(1.0, 6);

    // ogres run up
    cs_ActionMoveToObject(2.5, oCre_Ogre1, oWP_Ogre1_2, TRUE);
    cs_ActionMoveToObject(0.0, oCre_Ogre2, oWP_Ogre2_2, TRUE);

    // black-out just as they're reaching him
    cs_CameraDoFade(3.3, CS_FADE_TYPE_BLACK);
    // clear adventurer's actions, just to be safe
    cs_ClearAllActions(0.1, oCre_Adventurer);
    // bye-bye ogres
    cs_DestroyObject(0.0, oCre_Ogre1);
    cs_DestroyObject(0.0, oCre_Ogre2);

    // apply black tile trick
    DelayCommand(cs_GetDelay(), cs_TLChangeAreaGroundTiles(OBJECT_SELF, 506, 2.43, nCutNumber));

    // make bloodstain visible
    cs_RemoveVFXFromObject(0.0, oPla_Bloodstain, TRUE);

    // move adventurer, then kill him
    cs_JumpToObject(0.1, oCre_Adventurer, oWP_Adventurer6);
    cs_PlayAnimation(0.2, oCre_Adventurer, ANIMATION_LOOPING_DEAD_FRONT, 1.0, 20.0);
    cs_PlayVoiceChat(0.0, oCre_Adventurer, VOICE_CHAT_DEATH);

    // set camera 7 (dead guy on ground)
    cs_CameraUseCameraWaypoint(0.0, 7);
    cs_ActionJumpToLocation(0.0, oCre_Narrator, cs_GetCameraWaypointLocation(7));

    // speakstring to clear popup text from last one
    cs_SpeakString(0.0, oCre_Narrator, " ");

    // fade-in
    cs_CameraDoFade(1.5, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    // slow zoom
    cs_CameraUseCameraWaypoint(0.0, 8);

    // VO
    cs_SoundObjectPlay(1.0, oAud_VO5);
    cs_SpeakString(0.0, oCre_Narrator, S_NARRATION_5);

    // fade-out
    cs_CameraDoFade(3.0, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);

    // last camera
    cs_CameraUseCameraWaypoint(1.5, 3);
    cs_ActionJumpToLocation(0.0, oCre_Narrator, cs_GetCameraWaypointLocation(3));

// PART 3 =====================================================================

    // remove Halaster's invisibility
    cs_RemoveVFXFromObject(0.0, oCre_Halaster, TRUE);

    // make adventurer invisible - not sure if he'll be seen anyway, but just in case
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Adventurer);

    // more fog again
    //cs_SetFogAmount(0.0, FOG_TYPE_SUN, 20);

    // remove black tile effect
    DelayCommand(cs_GetDelay(), cs_TLResetAreaGroundTiles(nCutNumber));

    // start very slight zoom-out
    cs_CameraUseCameraWaypoint(0.8, 4);

    // fade-in
    cs_CameraDoFade(0.2, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    // VO
    cs_SoundObjectPlay(1.0, oAud_VO6);
    cs_SpeakString(0.0, oCre_Narrator, S_NARRATION_6);

    // start Halaster walking
    cs_ActionMoveToObject(1.0, oCre_Halaster, oWP_Halaster2);

    // fade-out
    cs_CameraDoFade(6.0, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);

    // clean-up
    cs_DestroyObject(1.5, oCre_Adventurer);
    cs_DestroyObject(0.0, oCre_Ogre1);
    cs_DestroyObject(0.0, oCre_Ogre2);
    cs_DestroyObject(0.0, oPla_Bloodstain);
    cs_DestroyObject(0.0, oPla_Light);
    cs_DestroyObject(0.0, oCre_Narrator);
    cs_DestroyObject(0.0, oCre_Narrator2);
    cs_DestroyObject(0.0, oCre_Halaster);
    cs_DestroyObject(0.0, oCre_Timmy);

    cs_SoundObjectStop(0.0, oAud_VO1);
    cs_SoundObjectStop(0.0, oAud_VO2);
    cs_SoundObjectStop(0.0, oAud_VO3);
    cs_SoundObjectStop(0.0, oAud_VO4);
    cs_SoundObjectStop(0.0, oAud_VO5);
    cs_SoundObjectStop(0.0, oAud_VO6);

    cs_MusicBackgroundChangeDay(0.0, nMusicDay);
    cs_MusicBackgroundChangeNight(0.0, nMusicNight);

    // restore fog
    cs_SetFogColor(0.0, FOG_TYPE_MOON, nOriginalFogNight);
    cs_SetFogColor(0.0, FOG_TYPE_SUN, nOriginalFogDay);
    cs_SetFogAmount(0.0, FOG_TYPE_MOON, nOriginalFogAmountNight);
    cs_SetFogAmount(0.0, FOG_TYPE_SUN, nOriginalFogAmountDay);

    cs_EndCutscene(1.5, FALSE, TRUE);
}

// cs_-style wrapper for TLChangeAreaGroundTiles
void cs_TLChangeAreaGroundTiles(object oArea, int nGroundTileConst, float fZOffset, int nCutNumber)
{
    if(csm_CutsceneAborted(nCutNumber, OBJECT_SELF)) return;

    //TLChangeAreaGroundTiles(oArea, nGroundTileConst, nColumns, nRows, fZOffset);
    TLChangeAreaGroundTilesEx(oArea, nGroundTileConst, fZOffset);
}

// cs_-style wrapper for TLResetAreaGroundTiles
void cs_TLResetAreaGroundTiles(int nCutNumber)
{
    if(csm_CutsceneAborted(nCutNumber, OBJECT_SELF)) return;

    //TLResetAreaGroundTiles(OBJECT_SELF, 0, 0);
    TLResetAreaGroundTilesEx(OBJECT_SELF);
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateFakeDungeonMap
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Jan 27, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreateFakeDungeonMap(object oCreator)
{
    // Determine the location from which to start building the map.
    vector vPos = GetPosition(oCreator);
    object oArea = GetArea(oCreator);

    float fX1 = vPos.x;
    float fY1 = vPos.y;
    float fZ1 = vPos.z;
    float fOrnt1 = 90.0;

    // Calculated variables.
    float fX, fY, fOrnt;
    location lLoc;
    string sFeature1, sFeature2, sShape, sResref;

    int i = 0;
    int j = 0;
    int nTile = 1;

    // Create the map 1 node at a time.
    while (i < 3)
    {
        while (j < 3)
        {
            // Determine room shape, feature icons and orientation.
            switch (nTile)
            {
                case 1:
                {
                    fOrnt = 180.0;
                    sFeature1 = "";
                    sFeature2 = "";
                    sShape = "00";
                    break;
                }
                case 2:
                {
                    fOrnt = 270.0;
                    sFeature1 = "11";
                    sFeature2 = "12";
                    sShape = "01";
                    break;
                }
                case 3:
                {
                    fOrnt = 90.0;
                    sFeature1 = "10";
                    sFeature2 = "";
                    sShape = "00";
                    break;
                }
                case 4:
                {
                    fOrnt = 270.0;
                    sFeature1 = "08";
                    sFeature2 = "";
                    sShape = "02";
                    break;
                }
                case 5:
                {
                    fOrnt = 0.0;
                    sFeature1 = "";
                    sFeature2 = "";
                    sShape = "02";
                    break;
                }
                case 6:
                {
                    fOrnt = 90.0;
                    sFeature1 = "06";
                    sFeature2 = "";
                    sShape = "00";
                    break;
                }
                case 7:
                {
                    fOrnt = 0.0;
                    sFeature1 = "";
                    sFeature2 = "";
                    sShape = "01";
                    break;
                }
                case 8:
                {
                    fOrnt = 90.0;
                    sFeature1 = "09";
                    sFeature2 = "";
                    sShape = "04";
                    break;
                }
                case 9:
                {
                    fOrnt = 90.0;
                    sFeature1 = "07";
                    sFeature2 = "";
                    sShape = "00";
                    break;
                }
                default:
                {
                    DebugMessage("cut_id1_narr01::CreateFakeDungeonMap - Loop overflow.");
                    break;
                }
            } // end switch.

            // Location.
            fX = fX1 - IntToFloat(j);
            fY = fY1 + IntToFloat(i);

            vPos = Vector(fX, fY, fZ1);

            // Bottom Layer.
            lLoc = Location(oArea, vPos, fOrnt1);

            DB_CreateObject(OBJECT_TYPE_PLACEABLE, TILE05_RESREF, lLoc);

            // Feature icons.
            if (sFeature1 != "")
            {
                sResref = "tile" + sFeature1;

                DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResref, lLoc);
            }

            if (sFeature2 != "")
            {
                sResref = "tile" + sFeature2;

                DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResref, lLoc);
            }

            // Room shape icon.
            lLoc = Location(oArea, vPos, fOrnt + fOrnt1);
            sResref = "tile" + sShape;

            DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResref, lLoc);

            j++;
            nTile++;
        }

        j = 0;
        i++;
    }
}
