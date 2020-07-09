//::///////////////////////////////////////////////
//:: Cutscene - South to Calimshan
//:: cut_a0_atsea.nss
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: April 6, 2005
//:://////////////////////////////////////////////
#include "inc_global"

// oVO1: "And thus the Midnight Rose embarked for the fabled port o' Calimshan."
// oVO2: "For days the tradewinds filled our sails an' bore us south"
// oVO3: "'til we reached our halfway point amidst the tropical isles o' Nelanther."
// oVO4: "'Twas there that the tempers o' our guests began to fray"
// oVO5: "'an 'twas there that I saw fit to bring them both into my quarters"
// oVO6: "where they could settle their disputes away from pryin' eyes an' ears..."
const float f_VO_LENGTH_1 = 6.0; // pp1_allendry012
const float f_VO_LENGTH_2 = 4.78; // pp1_allendry013
const float f_VO_LENGTH_3 = 5.49; // pp1_allendry014
const float f_VO_LENGTH_4 = 4.42; // pp1_allendry015
const float f_VO_LENGTH_5 = 5.24; // pp1_allendry016
const float f_VO_LENGTH_6 = 5.37; // pp1_allendry017

void main()
{
    //waypoints
    object oWP_Nisar1 = GetObjectByTagInArea("cs_wp_nisar1");
    object oWP_Nisar2 = GetObjectByTagInArea("cs_wp_nisar2");
    object oWP_Sailor1 = GetObjectByTagInArea("cs_wp_sailor1");
    object oWP_Sailor2 = GetObjectByTagInArea("cs_wp_sailor2");
    object oWP_Helmsman_Facing = GetObjectByTagInArea("cs_wp_helmsman_facing");
    object oWP_Sailor_Facing = GetObjectByTagInArea("cs_wp_sailor_facing");
    object oWP_Walk_Off = GetObjectByTagInArea("cs_wp_walk_off");
    object oWP_Walk_Off2 = GetObjectByTagInArea("cs_wp_walk_off2");

    object oWP_Allendry = GetObjectByTagInArea("cs_wp_allendry");
    object oWP_Tasina = GetObjectByTagInArea("cs_wp_tasina");
    object oWP_Rahman = GetObjectByTagInArea("cs_wp_rahman");

    //Sound
    object oVO1 = GetObjectByTagInArea("pp1_allendry012");
    object oVO2 = GetObjectByTagInArea("pp1_allendry013");
    object oVO3 = GetObjectByTagInArea("pp1_allendry014");
    object oVO4 = GetObjectByTagInArea("pp1_allendry015");
    object oVO5 = GetObjectByTagInArea("pp1_allendry016");
    object oVO6 = GetObjectByTagInArea("pp1_allendry017");

    //creatures
    effect eCutGhost = EffectCutsceneGhost();
    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);

    object oAllendry = CreateObject(OBJECT_TYPE_CREATURE, "a0_allendrycut", GetLocation(oWP_Allendry));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oAllendry);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oAllendry);

    object oTasina = CreateObject(OBJECT_TYPE_CREATURE, "a0_tasinacut", GetLocation(oWP_Tasina));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oTasina);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oTasina);

    object oRahman = CreateObject(OBJECT_TYPE_CREATURE, "a0_rahmancut", GetLocation(oWP_Rahman));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oRahman);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oRahman);

    object oNisar = GetObjectByTagInArea("a0_NisarCUT");
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oNisar, 0.0, TRUE);
    object oHelmsman = GetObjectByTagInArea("a0_Sailor1");
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oHelmsman, 0.0, TRUE);
    object oSailor2 = GetObjectByTagInArea("a0_elfsailor");
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oSailor2, 0.0, TRUE);
    object oSailor3 = GetObjectByTagInArea("a0_Sailor3");
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oSailor3, 0.0, TRUE);
    object oSailor4 = GetObjectByTagInArea("a0_dwrfsailor");
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oSailor4, 0.0, TRUE);

/*---------------------------------------------------------------------------*/

    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    cs_SoundObjectPlay(2.5, oVO1);
    cs_SoundObjectPlay(f_VO_LENGTH_1, oVO2);
    cs_SoundObjectPlay(f_VO_LENGTH_2, oVO3);

    cs_ResetDelay();
    cs_SoundObjectPlay(19.5, oVO4);
    cs_SoundObjectPlay(f_VO_LENGTH_4, oVO5);
    cs_SoundObjectPlay(f_VO_LENGTH_5, oVO6);

    cs_ResetDelay();

    cs_CameraUseCameraWaypoint(0.5, 1);
    cs_CameraDoFade(0.5, CS_FADE_TYPE_FROM_BLACK);

    // Nisar talking to helmsman
    cs_PlayAnimation(0.0, oNisar, ANIMATION_LOOPING_TALK_NORMAL, 1.0, 60.0);

    // Nisar stops talking, walks down to main deck. Helmsman turns forward.
    cs_ClearAllActions(1.2, oNisar);
    cs_ActionMoveToObject(0.9, oNisar, oWP_Nisar1, FALSE, 0.0);
    cs_CameraUseCameraWaypoint(0.2, 2);
    cs_SetFacingPoint(0.3, oHelmsman, GetPosition(oWP_Helmsman_Facing));
    cs_CameraUseCameraWaypoint(2.0, 4);

    // sailors on deck face Nisar as he walks towards them
    cs_SetFacingPoint(1.8, oSailor2, GetPosition(oWP_Sailor_Facing));
    cs_SetFacingPoint(0.0, oSailor3, GetPosition(oWP_Sailor_Facing));

    // they quit talking and get to work
    cs_ActionMoveToObject(2.4, oSailor2, oWP_Sailor1, FALSE, 0.0);
    cs_ActionMoveToObject(1.3, oSailor3, oWP_Sailor2, FALSE, 0.0);
    cs_ActionMoveToObject(0.9, oNisar, oWP_Nisar2, FALSE, 0.0);

    cs_ActionPlayAnimation(1.0, oSailor2, ANIMATION_LOOPING_GET_LOW, 1.0, 3.0);
    cs_ActionPlayAnimation(0.0, oSailor4, ANIMATION_LOOPING_LOOK_FAR, 1.0, 2.5);

    // fade out, start argument scene
    cs_CameraDoFade(5.0, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);
    cs_CameraUseCameraWaypoint(1.0, 3);
    cs_RemoveVFXFromObject(0.0, oRahman, TRUE);
    cs_RemoveVFXFromObject(0.0, oTasina, TRUE);
    cs_RemoveVFXFromObject(0.0, oAllendry, TRUE);
    cs_PlayAnimation(0.0, oRahman, ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 60.0);
    cs_PlayAnimation(0.0, oTasina, ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 60.0);
    cs_PlayAnimation(0.0, oAllendry, ANIMATION_LOOPING_TALK_PLEADING, 1.0, 60.0);
    // fade back in
    cs_CameraDoFade(1.3, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    cs_PlayAnimation(2.0, oAllendry, ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 60.0);

    cs_PlayAnimation(3.0, oAllendry, ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 60.0);
    cs_ClearAllActions(0.2, oRahman);
    cs_PlayAnimation(0.1, oRahman, ANIMATION_FIREFORGET_HEAD_TURN_RIGHT);
    cs_ClearAllActions(0.2, oTasina);
    cs_PlayAnimation(0.1, oTasina, ANIMATION_FIREFORGET_HEAD_TURN_LEFT);
    cs_ClearAllActions(1.3, oAllendry);
    cs_PlayAnimation(0.1, oAllendry, ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);

    cs_ActionMoveToObject(1.2, oAllendry, oWP_Walk_Off2, FALSE, 0.0);
    cs_ActionMoveToObject(2.0, oRahman, oWP_Walk_Off, FALSE, 0.0);
    cs_ActionMoveToObject(0.4, oTasina, oWP_Walk_Off, FALSE, 0.0);

    cs_CameraDoFade(2.0, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_MEDIUM);
    cs_DestroyObject(0.0, oAllendry);
    cs_DestroyObject(0.0, oTasina);
    cs_DestroyObject(0.0, oRahman);
    cs_SoundObjectStop(3.0, oVO1);
    cs_SoundObjectStop(0.0, oVO2);
    cs_SoundObjectStop(0.0, oVO3);
    cs_SoundObjectStop(0.0, oVO4);
    cs_SoundObjectStop(0.0, oVO5);
    cs_SoundObjectStop(0.0, oVO6);
    cs_EndCutscene(0.1, FALSE, TRUE, FADE_SPEED_FAST);
}
