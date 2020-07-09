//::///////////////////////////////////////////////
//:: cut_intro_act1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is the cut scene for the intro pan
    cutscene for act 1.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

#include "_inc_cutscene"

// oVO1: "Aye, 'tis true, I died that day an' this tale be but a hauntin'..."
// oVO2: "but there be those what lived an' drifted in to shore,"
// oVO3: "bruised an' battered, burnt up by the salt an' sun."
// oVO4: "Marooned in paradise, they were, for all the good it did them..."
const float f_VO_LENGTH_1 = 6.78; // 6.18 + pause -- pp1_allendry018
const float f_VO_LENGTH_2 = 3.39; // pp1_allendry019
const float f_VO_LENGTH_3 = 4.2; // 3.83 + pause -- pp1_allendry020
const float f_VO_LENGTH_4 = 4.59; // pp1_allendry021

//const string STRING = "PLACEHOLDER.PLACEHOLDER.PLACEHOLDER.";

void main()
{
    object oPC1 = cs_GetPCObject(0);
    object oPC2 = cs_GetPCObject(1);
    object oPC3 = cs_GetPCObject(2);
    object oPC4 = cs_GetPCObject(3);

    object oPoly = GetObjectByTag("a1_poly");
    object oWP_Poly = GetWaypointByTag("WP_WASHEDUP_POLY");
    location lPloy = GetLocation(oWP_Poly);

    object oWP_Clone1 = GetWaypointByTag("WP_WASHEDUP1");
    object oWP_Clone2 = GetWaypointByTag("WP_WASHEDUP2");
    object oWP_Clone3 = GetWaypointByTag("WP_WASHEDUP3");
    object oWP_Clone4 = GetWaypointByTag("WP_WASHEDUP4");

    object oWP_PCcam = GetWaypointByTag("WP_CAMERA");

    location lPCCopy1 = GetLocation(oWP_Clone1);
    location lPCCopy2 = GetLocation(oWP_Clone2);
    location lPCCopy3 = GetLocation(oWP_Clone3);
    location lPCCopy4 = GetLocation(oWP_Clone4);

    object oPCCopy1 = cs_CopyPC(lPCCopy1, FALSE, 0);
    object oPCCopy2 = cs_CopyPC(lPCCopy2, FALSE, 1);
    object oPCCopy3 = cs_CopyPC(lPCCopy3, FALSE, 2);
    object oPCCopy4 = cs_CopyPC(lPCCopy4, FALSE, 3);

    object oVO1 = GetObjectByTag("pp1_allendry018");
    object oVO2 = GetObjectByTag("pp1_allendry019");
    object oVO3 = GetObjectByTag("pp1_allendry020");
    object oVO4 = GetObjectByTag("pp1_allendry021");

    object oAreaSound1 = GetObjectByTagInArea("HawkCry");
    object oAreaSound2 = GetObjectByTagInArea("SeagullCries");
    object oAreaSound3 = GetObjectByTagInArea("WindGustSoft");

    effect eFlyInPoly = EffectDisappearAppear(lPloy);

//------------------------------------------------------------------------------

    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    cs_MusicBackgroundStop(0.0);
    // need to disable all other area-wide sounds to ensure dialog plays
    cs_SoundObjectStop(0.0, oAreaSound1);
    cs_SoundObjectStop(0.0, oAreaSound2);
    cs_SoundObjectStop(0.0, oAreaSound3);

    cs_CameraUseCameraWaypoint(0.0, 1);
    cs_CameraDoFade(0.0f, CS_FADE_TYPE_FROM_BLACK);

    // poly flys in as the PC awakes
    cs_ApplyEffectToObject(0.0f, DURATION_TYPE_TEMPORARY, eFlyInPoly, oPoly, 9.0f);

    cs_ActionPlayAnimation(0.0f, oPCCopy1, ANIMATION_LOOPING_DEAD_BACK, 1.0f, 10.0f);
    cs_ActionPlayAnimation(0.0f, oPCCopy2, ANIMATION_LOOPING_DEAD_BACK, 1.0f, 11.0f);
    cs_ActionPlayAnimation(0.0f, oPCCopy3, ANIMATION_LOOPING_DEAD_BACK, 1.0f, 11.5f);
    cs_ActionPlayAnimation(0.0f, oPCCopy4, ANIMATION_LOOPING_DEAD_BACK, 1.0f, 12.0f);

    cs_CameraSetFacing(0.5f, 270.0f, 6.0f, 80.0f, CAMERA_TRANSITION_TYPE_SLOW);

    cs_SoundObjectPlay(1.0, oVO1);
    cs_SoundObjectPlay(f_VO_LENGTH_1, oVO2);
    cs_SoundObjectPlay(f_VO_LENGTH_2, oVO3);
    cs_SoundObjectPlay(f_VO_LENGTH_3, oVO4);

    cs_CameraSetFacing(f_VO_LENGTH_4/2, 360.0f, 12.0f, 1.0f, CAMERA_TRANSITION_TYPE_MEDIUM);

    cs_CameraDoFade(f_VO_LENGTH_4/2, CS_FADE_TYPE_TO_BLACK);

    cs_DestroyObject(0.5f, oPCCopy1);
    cs_DestroyObject(0.0f, oPCCopy2);
    cs_DestroyObject(0.0f, oPCCopy3);
    cs_DestroyObject(0.0f, oPCCopy4);

    cs_SoundObjectStop(1.5, oVO1);
    cs_SoundObjectStop(0.0, oVO2);
    cs_SoundObjectStop(0.0, oVO3);
    cs_SoundObjectStop(0.0, oVO4);

    cs_MusicBackgroundPlay(0.0);
    cs_SoundObjectPlay(0.0, oAreaSound1, TRUE);
    cs_SoundObjectPlay(0.0, oAreaSound2, TRUE);
    cs_SoundObjectPlay(0.0, oAreaSound3, TRUE);

    cs_EndCutscene(0.1f, FALSE, TRUE);
}
