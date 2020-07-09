//::///////////////////////////////////////////////
//:: cut_a0_psc_intro
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is the cutscene for the intro to
    Pirates of the Sword Coast
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: April 18, 2005
//:://////////////////////////////////////////////
#include "_inc_cutscene"

// oVO1:  "There be somethin' 'bout a ship that sings o' freedom."
// oVO2:  "Salt winds an' clear waters..."
// oVO3:  "There was a time when I was captain o' the Midnight Rose,"
// oVO4:  "one o' many she has known..."
// oVO5:  "I plied the seas from port to port,"
// oVO6:  "found my share o' treasures and reburied them,"
// oVO7:  "an' lived an' died on her fair deck."
// oVO8:  "But it was not here that this tale began..."
// oVO9:  "No, 'twas on the planks o' a northern dock"
// oVO10: "in the free city o' Neverwinter"
// oVO11: "where we took on supplies for a journey south."
const float f_VO_LENGTH_1 = 4.3; // 4.01 + pause -- pp1_allendry001
const float f_VO_LENGTH_2 = 3.3; // 2.91 + pause -- pp1_allendry002
const float f_VO_LENGTH_3 = 3.9; // 3.83 + pause -- pp1_allendry003
const float f_VO_LENGTH_4 = 2.5; // 1.81 + pause -- pp1_allendry004
const float f_VO_LENGTH_5 = 2.86; // pp1_allendry005
const float f_VO_LENGTH_6 = 3.51; // pp1_allendry006
const float f_VO_LENGTH_7 = 5.0; // 3.57 + pause -- pp1_allendry007
const float f_VO_LENGTH_8 = 3.4; // 2.8 + pause -- pp1_allendry008
const float f_VO_LENGTH_9 = 3.4; // pp1_allendry009
const float f_VO_LENGTH_10 = 2.54; // pp1_allendry010
const float f_VO_LENGTH_11 = 3.65; // pp1_allendry011

void main()
{
    object oTrog1 = GetObjectByTag("a0_psccut_trg01");
    object oTrog2 = GetObjectByTag("a0_psccut_trg02");
    object oTrog3 = GetObjectByTag("a0_psccut_trg03");

    object oTrogArcher1 = GetObjectByTag("a0_psccut_trg04", 0);
    object oTrogArcher2 = GetObjectByTag("a0_psccut_trg04", 1);
    object oTrogArcher3 = GetObjectByTag("a0_psccut_trg04", 2);

    object oPirate1 = GetObjectByTag("a0_psccut_prt01");
    object oPirate2 = GetObjectByTag("a0_psccut_prt02");
    object oPirate3 = GetObjectByTag("a0_psccut_prt03");
    vector vPirate1 = GetPosition(oPirate1);
    vector vPirate2 = GetPosition(oPirate2);
    vector vPirate3 = GetPosition(oPirate3);

    object oAlledry = GetObjectByTag("a0_psccut_alldry");
    object oCrew1 = GetObjectByTag("a0_psccut_crw01");
    object oCrew2 = GetObjectByTag("a0_psccut_crw02");
    object oCrew3 = GetObjectByTag("a0_psccut_crw03");
    object oCrew4 = GetObjectByTag("a0_psccut_crw04");
    object oCrew5 = GetObjectByTag("a0_psccut_crw05");
    object oCrew6 = GetObjectByTag("a0_psccut_crw06");

    object oFlyGull1 = GetObjectByTag("a0_psccut_flgll", 0);
    object oFlyGull2 = GetObjectByTag("a0_psccut_flgll", 1);
    object oFlyGull3 = GetObjectByTag("a0_psccut_flgll", 2);
    object oFlyGull4 = GetObjectByTag("a0_psccut_flgll", 3);
    object oFlyGull5 = GetObjectByTag("a0_psccut_flgll", 4);

    object oWalkGull1 = GetObjectByTag("a0_psccut_wkgll", 0);
    object oWalkGull2 = GetObjectByTag("a0_psccut_wkgll", 1);
    object oWalkGull3 = GetObjectByTag("a0_psccut_wkgll", 2);
    object oWalkGull4 = GetObjectByTag("a0_psccut_wkgll", 3);

    object oChest = GetObjectByTag("a0_potsc_cutchest");

    object oWP_PrtFlee1 = GetWaypointByTag("A0_POTSCINTRO_PIRATEFLEE1");
    object oWP_PrtFlee2 = GetWaypointByTag("A0_POTSCINTRO_PIRATEFLEE2");
    object oWP_PrtFlee3 = GetWaypointByTag("A0_POTSCINTRO_PIRATEFLEE3");

    object oWP_Trog1 = GetWaypointByTag("A0_INTRO_TROG1_1");
    object oWP_Trog2 = GetWaypointByTag("A0_INTRO_TROG2_1");
    object oWP_Trog3 = GetWaypointByTag("A0_INTRO_TROG3_1");
    object oWP_Trog4 = GetWaypointByTag("A0_INTRO_TROG4_1");
    object oWP_Trog5 = GetWaypointByTag("A0_INTRO_TROG5_1");
    object oWP_Trog6 = GetWaypointByTag("A0_INTRO_TROG6_1");

    object oWP_FlyGull1_1 = GetObjectByTag("A0_POTSCINTRO_GULL1_1");
    object oWP_FlyGull2_1 = GetObjectByTag("A0_POTSCINTRO_GULL2_1");
    object oWP_FlyGull3_1 = GetObjectByTag("A0_POTSCINTRO_GULL3_1");
    object oWP_FlyGull4_1 = GetObjectByTag("A0_POTSCINTRO_GULL4_1");
    object oWP_FlyGull5_1 = GetObjectByTag("A0_POTSCINTRO_GULL5_1");

    object oWP1 = GetObjectByTagInArea("cs_wp1");
    object oWP2 = GetObjectByTagInArea("cs_wp2");
    object oWP3 = GetObjectByTagInArea("cs_wp3");
    object oWP4 = GetObjectByTagInArea("cs_wp4");
    object oWP5 = GetObjectByTagInArea("cs_wp5");
    object oWP6 = GetObjectByTagInArea("cs_wp6");
    object oWP7 = GetObjectByTagInArea("cs_wp7");

    object oWP_Allendry_End = GetObjectByTagInArea("cs_wp_allendry_end");
    object oWP_Crew1_End1 = GetObjectByTagInArea("cs_wp_e1_1");
    object oWP_Crew1_End2 = GetObjectByTagInArea("cs_wp_e1_2");
    object oWP_Crew1_End3 = GetObjectByTagInArea("cs_wp_e1_3");
    object oWP_Crew2_End1 = GetObjectByTagInArea("cs_wp_e2_1");
    object oWP_Crew2_End2 = GetObjectByTagInArea("cs_wp_e2_2");
    object oWP_Crew5_End1 = GetObjectByTagInArea("cs_wp_e5_1");

    object oTarget01 = GetObjectByTag("A0_CUTTARG_1");
    object oTarget02 = GetObjectByTag("A0_CUTTARG_2");
    object oTarget03 = GetObjectByTag("A0_CUTTARG_3");

    object oVO1 = GetObjectByTag("pp1_allendry001");
    object oVO2 = GetObjectByTag("pp1_allendry002");
    object oVO3 = GetObjectByTag("pp1_allendry003");
    object oVO4 = GetObjectByTag("pp1_allendry004");
    object oVO5 = GetObjectByTag("pp1_allendry005");
    object oVO6 = GetObjectByTag("pp1_allendry006");
    object oVO7 = GetObjectByTag("pp1_allendry007");
    object oVO8 = GetObjectByTag("pp1_allendry008");
    object oVO9 = GetObjectByTag("pp1_allendry009");
    object oVO10 = GetObjectByTag("pp1_allendry010");
    object oVO11 = GetObjectByTag("pp1_allendry011");

    effect eGhost = EffectCutsceneGhost();

    // ghost the actors to prevent weirdness with bumping
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oAlledry);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oCrew1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oCrew2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oCrew3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oCrew4);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oCrew5);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oCrew6);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oFlyGull1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oFlyGull2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oFlyGull3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oFlyGull4);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oFlyGull5);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPirate1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPirate2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPirate3);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oTrog1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oTrog2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oTrog3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oTrogArcher1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oTrogArcher2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oTrogArcher3);

//------------------------------------------------------------------------------
    float fDelay;

    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    // moving to this camera loads up the creatures on the shore, should help
    // prevent a hitch later in the cutscene - which I try to hide, but I don't
    // want to make that black screen too long
    cs_CameraUseCameraWaypoint(0.5, 10);
    // first "real" camera, on the ship
    cs_CameraUseCameraWaypoint(0.5, 1);
    cs_CameraUseCameraWaypoint(1.7, 2);
    cs_CameraDoFade(0.0, CS_FADE_TYPE_FROM_BLACK);

    // make crew do stuff
    fDelay = cs_GetDelay();
    cs_PlayAnimation(0.0, oCrew5, ANIMATION_LOOPING_SIT_CROSS, 1.0, 60.0);
    cs_ActionMoveToObject(0.0, oCrew1, oWP1, FALSE, 0.3);
    cs_ActionMoveToObject(0.01, oCrew1, oWP2, FALSE, 0.3);
    cs_ActionMoveToObject(0.01, oCrew1, oWP3, FALSE, 0.3);

    cs_ActionMoveToObject(3.0, oCrew4, oWP4, FALSE, 0.3);
    cs_ActionMoveToObject(0.01, oCrew4, oWP6, FALSE, 0.3);
    cs_ActionPlayAnimation(0.01, oCrew4, ANIMATION_LOOPING_GET_LOW, 1.0, 5.0);
    cs_ResetDelay(-1.0, cs_GetDelay() - 1.0);

    cs_ActionMoveToObject(2.0, oCrew3, oWP7, FALSE, 0.2);
    cs_SetFacingPoint(3.0, oCrew2, GetPosition(oWP7));
    cs_SetFacingPoint(0.0, oCrew6, GetPosition(oWP7));
    cs_ActionMoveToObject(2.0, oCrew6, oWP5, FALSE, 0.2);
    cs_SetFacingPoint(0.0, oCrew3, GetPosition(oCrew2));
    cs_ActionPlayAnimation(0.01, oCrew6, ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 1.5);
    cs_ClearAllActions(4.5, oCrew5);
    cs_ActionMoveToObject(1.0, oCrew5, oWP1);
    cs_ResetDelay(-1.0, fDelay);


    cs_SoundObjectPlay(1.5, oVO1);
    cs_SoundObjectPlay(f_VO_LENGTH_1, oVO2);

    // fade-out, fade-in with 2nd ship camera
    cs_CameraDoFade(f_VO_LENGTH_2, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FASTEST);
    cs_CameraUseCameraWaypoint(0.4, 3);
    cs_CameraUseCameraWaypoint(0.3, 4);
    cs_CameraDoFade(0.0, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FASTEST);

    cs_SoundObjectPlay(0.5, oVO3);
    cs_SoundObjectPlay(f_VO_LENGTH_3, oVO4);

    cs_CameraDoFade(f_VO_LENGTH_4, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);

    // cut to shore, pirates opening chest
    cs_CameraUseCameraWaypoint(0.9, 10);
    cs_PlayAnimation(0.0, oPirate2, ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.5);
    cs_PlayAnimation(0.0, oPirate1, ANIMATION_LOOPING_GET_LOW, 1.0f, 13.0f);
    cs_PlayAnimation(0.0, oPirate3, ANIMATION_LOOPING_LOOK_FAR, 1.0f, 15.0f);
    cs_CameraDoFade(0.9, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    // vo for shore part
    fDelay = cs_GetDelay();
    cs_SoundObjectPlay(2.5, oVO5);
    cs_SoundObjectPlay(f_VO_LENGTH_5, oVO6);
    cs_SoundObjectPlay(f_VO_LENGTH_6, oVO7);
    cs_ResetDelay(-1.0, fDelay);

    // start seagulls moving
    cs_ActionMoveToObject(0.0, oFlyGull1, oWP_FlyGull1_1, TRUE, 0.0f);
    cs_ActionMoveToObject(0.0, oFlyGull3, oWP_FlyGull3_1, TRUE, 0.0f);
    cs_ActionMoveToObject(0.0, oFlyGull2, oWP_FlyGull2_1, TRUE, 0.0f);
    cs_ActionMoveToObject(0.0, oFlyGull4, oWP_FlyGull4_1, TRUE, 0.0f);
    cs_ActionMoveToObject(0.0, oFlyGull5, oWP_FlyGull5_1, TRUE, 0.0f);

    // Pirates open a chest and start cheering
    cs_PlayAnimation(2.3, oChest, ANIMATION_PLACEABLE_OPEN);
    cs_ClearAllActions(0.3, oPirate1);
    cs_PlayAnimation(0.2, oPirate1, ANIMATION_FIREFORGET_VICTORY1);

    cs_ClearAllActions(0.0, oPirate2);
    cs_ClearAllActions(0.0, oPirate3);
    cs_SetFacingPoint(0.5, oPirate2, vPirate1);
    cs_SetFacingPoint(0.1, oPirate3, vPirate1);

    cs_PlayAnimation(0.5, oPirate1, ANIMATION_LOOPING_TALK_LAUGHING);
    cs_PlayAnimation(0.5, oPirate2, ANIMATION_FIREFORGET_VICTORY2);
    cs_PlayAnimation(0.0, oPirate2, ANIMATION_FIREFORGET_VICTORY3);
    cs_SetFacingPoint(0.0, oPirate1, vPirate2);

    // moving Allendry and a couple crewmembers to the other ship early
    cs_ClearAllActions(0.0, oAlledry);
    cs_ClearAllActions(0.0, oCrew1);
    cs_ClearAllActions(0.0, oCrew2);
    cs_ClearAllActions(0.0, oCrew5);
    cs_ActionJumpToObject(0.01, oAlledry, oWP_Allendry_End);
    cs_ActionJumpToObject(0.0, oCrew1, oWP_Crew1_End1);
    cs_ActionJumpToObject(0.0, oCrew2, oWP_Crew2_End1);
    cs_ActionJumpToObject(0.0, oCrew5, oWP_Crew5_End1);
    cs_ActionPlayAnimation(0.01, oCrew5, ANIMATION_LOOPING_SIT_CROSS, 1.0, 60.0);

    // The pirates are underseige by the trogolodytes and chased away
    cs_ActionAttack(2.5, oTrogArcher1, oTarget02, TRUE);
    cs_ActionAttack(0.0, oTrogArcher2, oTarget03, TRUE);
    cs_ActionAttack(0.0, oTrogArcher3, oTarget01, TRUE);

    cs_ActionSetFacingPoint(0.9, oPirate1, GetPosition(oWP_Trog1));
    cs_ActionSetFacingPoint(0.1, oPirate2, GetPosition(oWP_Trog2));
    cs_ActionSetFacingPoint(0.1, oPirate3, GetPosition(oWP_Trog3));

    cs_CameraUseCameraWaypoint(0.5, 11);

    cs_ActionMoveToObject(0.5, oPirate3, oWP_PrtFlee3, TRUE);
    cs_ActionPlayAnimation(1.1, oPirate1, ANIMATION_FIREFORGET_TAUNT, 0.75f);
    cs_ActionMoveToObject(0.8, oPirate2, oWP_PrtFlee2, TRUE);

    cs_ActionMoveToObject(1.5, oTrog1, oWP_Trog1, TRUE, 0.0f);
    cs_ActionMoveToObject(0.0, oTrog2, oWP_Trog2, TRUE, 0.0f);
    cs_ActionMoveToObject(0.0, oTrog3, oWP_Trog3, TRUE, 0.0f);

    cs_ActionPlayAnimation(1.0, oTrog1, ANIMATION_LOOPING_TALK_FORCEFUL, 0.75f);

    cs_ClearAllActions(0.0, oTrogArcher1);
    cs_ClearAllActions(0.0, oTrogArcher2);
    cs_ClearAllActions(0.0, oTrogArcher3);

    cs_ActionMoveToObject(0.5, oTrogArcher1, oWP_Trog4, TRUE, 0.0f);
    cs_ActionMoveToObject(0.0, oTrogArcher2, oWP_Trog5, TRUE, 0.0f);
    cs_ActionMoveToObject(0.0, oTrogArcher3, oWP_Trog6, TRUE, 0.0f);

    cs_ActionSetFacingPoint(0.0, oPirate1, vPirate2);
    cs_ActionSetFacingPoint(0.7, oPirate1, vPirate3);
    cs_ActionSetFacingPoint(0.8, oPirate1, GetPosition(oTrog1));

    cs_ActionMoveToObject(0.5, oPirate1, oWP_PrtFlee1, TRUE);

    cs_ActionMoveToObject(0.5, oTrog1, oPirate1, TRUE, 0.0f);
    cs_ActionMoveToObject(0.2, oTrog2, oPirate1, TRUE, 0.0f);
    cs_ActionMoveToObject(0.1, oTrog3, oPirate1, TRUE, 0.0f);

    cs_ActionMoveToObject(0.2, oTrogArcher1, oPirate1, TRUE, 0.0f);
    cs_ActionMoveToObject(0.0, oTrogArcher2, oPirate1, TRUE, 0.0f);
    cs_ActionMoveToObject(0.0, oTrogArcher3, oPirate1, TRUE, 0.0f);


    // back on the ship
    fDelay = cs_GetDelay();
    cs_CameraDoFade(0.5, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);
    cs_CameraUseCameraWaypoint(0.8, 20);
    cs_CameraDayToNight(0.1);
    // this is NOT the proper way to do this, but I can get away with it here.
    // I need to add the proper functions to the cutscene system at some point
    DelayCommand(cs_GetDelay(), SetFogAmount(FOG_TYPE_MOON, 50, OBJECT_SELF));

    cs_CameraDoFade(0.5, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);
    cs_ActionMoveToObject(0.0, oCrew1, oWP_Crew1_End2, FALSE, 0.2);
    cs_ActionMoveToObject(0.01, oCrew1, oWP_Crew1_End3, FALSE, 0.2);
    cs_ActionMoveToObject(0.0, oCrew2, oWP_Crew2_End2, TRUE, 0.2);
    cs_ResetDelay(-1.0, fDelay);

    cs_SoundObjectPlay(0.0, oVO8);
    cs_SoundObjectPlay(f_VO_LENGTH_8, oVO9);
    cs_SoundObjectPlay(f_VO_LENGTH_9, oVO10);
    cs_SoundObjectPlay(f_VO_LENGTH_10, oVO11);


    // end cutscene
    cs_SoundObjectStop(f_VO_LENGTH_11+1.0, oVO1);
    cs_SoundObjectStop(0.0, oVO2);
    cs_SoundObjectStop(0.0, oVO3);
    cs_SoundObjectStop(0.0, oVO4);
    cs_SoundObjectStop(0.0, oVO5);
    cs_SoundObjectStop(0.0, oVO6);
    cs_SoundObjectStop(0.0, oVO7);
    cs_SoundObjectStop(0.0, oVO8);
    cs_SoundObjectStop(0.0, oVO9);
    cs_SoundObjectStop(0.0, oVO10);
    cs_SoundObjectStop(0.0, oVO11);
    cs_EndCutscene(0.1, FALSE, TRUE, FADE_SPEED_SLOW);
}
