//::///////////////////////////////////////////////
//:: X-treme Pirate Makeover
//:: cut_a2_xpm.nss
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    X-treme Pirate Makeover cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Mar 16/05
//:://////////////////////////////////////////////
#include "inc_global"

const float SND_TIME_CHISEL = 2.54;
const float SND_TIME_ELECTRIC = 2.77;
const float SND_TIME_HAMMER = 3.37;
const float SND_TIME_MINEPICK1 = 2.26;
const float SND_TIME_MINEPICK2 = 3.10;
const float SND_TIME_ROPEPULLY = 3.65;
const float SND_TIME_SAWING1 = 3.88;
const float SND_TIME_SAWING2 = 4.35;
const float SND_TIME_SAWING3 = 5.23;
const float SND_TIME_WHISTLE1 = 2.4;
const float SND_TIME_WHISTLE2 = 1.99;
const float SND_TIME_CLAYBREAK = 2.45;
const float SND_TIME_PAIN1 = 2.87;
const float SND_TIME_PAIN2 = 5.09;
const float SND_TIME_PAIN3 = 3.74;
const float SND_TIME_PAIN4 = 3.24;
const float SND_TIME_PAIN5 = 1.01;
const float SND_TIME_PAIN6 = 2.45;
const float SND_TIME_PAIN7 = 3.93;
const float SND_TIME_PAIN8 = 3.37;
const float SND_TIME_PAIN9 = 6.52;

void main()
{
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    // waypoints
    object oWP_Executioner1 = GetObjectByTagInArea(a2w_Manor_XPM_Executioner_1);
    object oWP_Executioner2 = GetObjectByTagInArea(a2w_Manor_XPM_Executioner_2);
    object oWP_Governor1 = GetObjectByTagInArea(a2w_Manor_XPM_Governor_1);
    object oWP_Langer1 = GetObjectByTagInArea(a2w_Manor_XPM_Langer_1);
    object oWP_Langer2 = GetObjectByTagInArea(a2w_Manor_XPM_Langer_2);
    object oWP_Tattooist1 = GetObjectByTagInArea(a2w_Manor_XPM_Tattooist_1);
    object oWP_Tattooist2 = GetObjectByTagInArea(a2w_Manor_XPM_Tattooist_2);
    object oWP_Guard1 = GetObjectByTagInArea(a2w_Manor_XPM_Guard_1);
    object oWP_Guard_End = GetObjectByTagInArea(a2w_Manor_XPM_Guard_End);
    object oWP_Garm = GetObjectByTagInArea(a2w_Manor_XPM_Garm);
    object oWP_Nisar = GetObjectByTagInArea(a2w_Manor_XPM_Nisar);

    object oWP_PC1_1 = GetObjectByTagInArea("cs_wp_pc1_1");

    object oWP_Midpoint = GetObjectByTagInArea("cs_wp_midpoint");
    object oWP_Cell = GetObjectByTagInArea("A2_LANGERCEL");

    effect eCutGhost = EffectCutsceneGhost();
    // creatures
    object oExecutioner = CopyObject(GetObjectByTag(a2c_tag_Executioner), GetLocation(oWP_Executioner1), OBJECT_INVALID, "cut_executioner");
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oExecutioner);
    object oGovernor = CopyObject(GetObjectByTag(a2c_tag_Governor), GetLocation(oWP_Governor1), OBJECT_INVALID, "cut_governor");
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oGovernor);
    object oTattooist = CopyObject(GetObjectByTag(a2c_tag_Tattooist), GetLocation(oWP_Tattooist1), OBJECT_INVALID, "cut_tattooist");
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oTattooist);
    object oGuard = GetObjectByTagInArea("a2_guard");
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oGuard, 60.0, TRUE);

    object oRealGarm = GetObjectByTagInArea(a1c_tag_Garm);
    object oRealNisar = GetObjectByTagInArea(a2c_tag_Nisar);
    object oFakeGarm = CopyObject(oRealGarm, GetLocation(oWP_Garm), OBJECT_INVALID, "xpm_fakegarm");
    object oFakeNisar = CopyObject(oRealNisar, GetLocation(oWP_Nisar), OBJECT_INVALID, "xpm_fakenisar");
    AssignCommand(oFakeGarm, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oFakeNisar, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oFakeGarm,ChangeToStandardFaction(oFakeGarm,STANDARD_FACTION_COMMONER));
    AssignCommand(oFakeNisar,ChangeToStandardFaction(oFakeNisar,STANDARD_FACTION_COMMONER));


    //Langer
    object oLanger1 = GetObjectByTag(a2c_tag_Langer1);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oLanger1);
    object oLanger2 = CreateObject(OBJECT_TYPE_CREATURE, a2c_res_Langer2, GetLocation(oWP_Cell));
    // make Langer2 invisible for now
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oLanger2);

    object oPCCopy1 = cs_CopyPC(GetLocation(oWP_PC1_1));

    // make sure door is unlocked and open
    object oDoor = GetObjectByTagInArea("a2_door_langer");
    SetLocked(oDoor, FALSE);
    AssignCommand(oDoor, ActionOpenDoor(oDoor));

    // sounds
    object oSnd_Chisel = GetObjectByTag("xpm_chisel");
    object oSnd_Electric = GetObjectByTag("xpm_electric");
    object oSnd_Hammer = GetObjectByTag("xpm_hammer");
    object oSnd_Minepick1 = GetObjectByTag("xpm_minepick1");
    object oSnd_Minepick2 = GetObjectByTag("xpm_minepick2");
    object oSnd_Pain1 = GetObjectByTag("xpm_pain01");
    object oSnd_Pain2 = GetObjectByTag("xpm_pain02");
    object oSnd_Pain3 = GetObjectByTag("xpm_pain03");
    object oSnd_Pain4 = GetObjectByTag("xpm_pain04");
    object oSnd_Pain5 = GetObjectByTag("xpm_pain05");
    object oSnd_Pain6 = GetObjectByTag("xpm_pain06");
    object oSnd_Pain7 = GetObjectByTag("xpm_pain07");
    object oSnd_Pain8 = GetObjectByTag("xpm_pain08");
    object oSnd_Pain9 = GetObjectByTag("xpm_pain09");
    object oSnd_Ropepully = GetObjectByTag("xpm_ropepully");
    object oSnd_Sawing1 = GetObjectByTag("xpm_sawing1");
    object oSnd_Sawing2 = GetObjectByTag("xpm_sawing2");
    object oSnd_Sawing3 = GetObjectByTag("xpm_sawing3");
    object oSnd_Whistle1 = GetObjectByTag("xpm_whistle1");
    object oSnd_Whistle2 = GetObjectByTag("xpm_whistle2");
    object oSnd_Claybreak = GetObjectByTag("xpm_claybreak");

    // placeables
    object oVFX = GetObjectByTag("xpm_vfx");

    float fDelay;
//------------------------------------------------------------------------------
    // stop music for this cutscene
    cs_MusicBackgroundStop(0.0);

    // initial camera
    cs_CameraUseCameraWaypoint(0.5, 1);

    // actors in start positions
    cs_JumpToObject(0.0, oExecutioner, oWP_Executioner1);
    cs_JumpToObject(0.0, oGovernor, oWP_Governor1);
    cs_JumpToObject(0.0, oLanger1, oWP_Langer1);
    cs_JumpToObject(0.0, oTattooist, oWP_Tattooist1);
    cs_JumpToObject(0.0, oGuard, oWP_Guard1);

    // fade in
    cs_CameraDoFade(1.0, CS_FADE_TYPE_FROM_BLACK);

    // langer goes into cell, tattooist follows
    cs_ActionMoveToObject(1.8, oLanger1, oWP_Midpoint, FALSE, 0.2);
    cs_ActionMoveToObject(0.1, oLanger1, oWP_Cell, FALSE, 0.2);
    cs_SetFacingPoint(0.2, oTattooist, GetPosition(oWP_Midpoint));
    cs_ActionMoveToObject(0.8, oTattooist, oWP_Midpoint, FALSE, 0.2);
    cs_ActionMoveToObject(0.1, oTattooist, oWP_Cell, FALSE, 0.2);

    // Langer1 goes away, made-over version (Langer2) pops in
    cs_DestroyObject(6.5, oLanger1);
    cs_RemoveVFXFromObject(0.0, oLanger2);

    //some sounds/vfx
    fDelay = cs_GetDelay();
    cs_SoundObjectPlay(0.0, oSnd_Sawing1);
    cs_SoundObjectPlay(SND_TIME_SAWING1, oSnd_Minepick1);
    cs_SoundObjectPlay(0.0, oSnd_Whistle1);
    cs_SoundObjectPlay(SND_TIME_MINEPICK1, oSnd_Sawing3);
    cs_SoundObjectPlay(SND_TIME_SAWING3 + 1.5, oSnd_Ropepully);
    cs_SoundObjectPlay(SND_TIME_ROPEPULLY, oSnd_Claybreak);
    cs_ApplyVFXToObject(0.1, DURATION_TYPE_INSTANT, VFX_COM_CHUNK_RED_LARGE, oVFX);
    float fExecutionerFallTime = cs_GetDelay();
    cs_SoundObjectPlay(SND_TIME_CLAYBREAK + 0.7, oSnd_Electric);
    cs_SoundObjectPlay(SND_TIME_ELECTRIC + 0.5, oSnd_Hammer);
    //executioner stuff
    cs_ResetDelay(-1.0, fDelay);
    cs_SetFacingPoint(5.0, oExecutioner, GetPosition(oWP_Executioner2));
    cs_ActionMoveToObject(4.0, oExecutioner, oWP_Executioner2, FALSE, 0.2);
    cs_ResetDelay(-1.0, fExecutionerFallTime);
    cs_ActionPlayAnimation(0.0, oExecutioner, ANIMATION_LOOPING_DEAD_BACK, 1.0, 2.0);
    cs_ActionMoveToObject(3.0, oExecutioner, oWP_Executioner1, FALSE, 0.2);
    cs_ActionSetFacing(0.1, oExecutioner, GetFacing(oWP_Executioner1));
    //governor & guard stuff
    cs_ResetDelay(-1.0, fDelay);
    cs_SetFacingPoint(3.0, oGovernor, GetPosition(oWP_Midpoint));
    cs_ActionPlayAnimation(4.5, oGovernor, ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);
    cs_SetFacingPoint(1.8, oGuard, GetPosition(oWP_Midpoint));
    cs_ResetDelay(-1.0, fExecutionerFallTime);
    cs_ActionPlayAnimation(1.0, oGuard, ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 4.0);
    cs_SetFacing(1.0, oGovernor, GetFacing(oWP_Governor1));


    //pain sounds
    cs_ResetDelay(-1.0, fDelay);
    cs_SoundObjectPlay(1.2, oSnd_Pain4);
    cs_SoundObjectPlay(8.5, oSnd_Pain7);
    cs_SoundObjectPlay(8.8, oSnd_Pain2);

    // new langer comes out with tatooist
    cs_ActionMoveToObject(4.2, oLanger2, oWP_Midpoint, FALSE, 0.2);
    cs_ActionMoveToObject(0.1, oLanger2, oWP_Langer2, FALSE, 0.2);
    cs_ActionPlayAnimation(0.1, oLanger2, ANIMATION_FIREFORGET_VICTORY1);
    cs_ActionMoveToObject(0.9, oTattooist, oWP_Midpoint, FALSE, 0.2);
    cs_ActionMoveToObject(0.1, oTattooist, oWP_Tattooist2, FALSE, 0.2);

    // zoom in
    cs_CameraUseCameraWaypoint(1.5, 2);

    cs_ActionPlayAnimation(1.5, oExecutioner, ANIMATION_FIREFORGET_VICTORY1);
    cs_PlayVoiceChat(0.0, oExecutioner, VOICE_CHAT_CHEER);
    cs_ActionPlayAnimation(0.4, oPCCopy1, ANIMATION_FIREFORGET_VICTORY2);
    //don't think the player needs to VOICE_CHAT_CHEER, we have enough
    //cs_PlayVoiceChat(0.0, oPCCopy1, VOICE_CHAT_CHEER);
    cs_ActionPlayAnimation(0.1, oFakeGarm, ANIMATION_FIREFORGET_VICTORY3);
    cs_ActionPlayAnimation(0.1, oFakeNisar, ANIMATION_FIREFORGET_VICTORY1);
    cs_ActionPlayAnimation(0.1, oGovernor, ANIMATION_FIREFORGET_VICTORY3);
    cs_PlayVoiceChat(0.0, oGovernor, VOICE_CHAT_CHEER);
    cs_ActionPlayAnimation(0.4, oGuard, ANIMATION_FIREFORGET_VICTORY2);
    cs_PlayVoiceChat(0.0, oGuard, VOICE_CHAT_CHEER);

    // end
    cs_CameraDoFade(3.8, CS_FADE_TYPE_TO_BLACK);
    cs_DestroyObject(1.2, oGovernor);
    cs_DestroyObject(0.0, oTattooist);
    cs_DestroyObject(0.0, oExecutioner);
    cs_DestroyObject(0.0, oVFX);
    cs_DestroyObject(0.0, oPCCopy1);
    cs_DestroyObject(0.0, oFakeGarm);
    cs_DestroyObject(0.0, oFakeNisar);
    cs_SoundObjectStop(0.0, oSnd_Chisel);
    cs_SoundObjectStop(0.0, oSnd_Claybreak);
    cs_SoundObjectStop(0.0, oSnd_Electric);
    cs_SoundObjectStop(0.0, oSnd_Hammer);
    cs_SoundObjectStop(0.0, oSnd_Minepick1);
    cs_SoundObjectStop(0.0, oSnd_Minepick2);
    cs_SoundObjectStop(0.0, oSnd_Pain1);
    cs_SoundObjectStop(0.0, oSnd_Pain2);
    cs_SoundObjectStop(0.0, oSnd_Pain3);
    cs_SoundObjectStop(0.0, oSnd_Pain4);
    cs_SoundObjectStop(0.0, oSnd_Pain5);
    cs_SoundObjectStop(0.0, oSnd_Pain6);
    cs_SoundObjectStop(0.0, oSnd_Pain7);
    cs_SoundObjectStop(0.0, oSnd_Pain8);
    cs_SoundObjectStop(0.0, oSnd_Pain9);
    cs_SoundObjectStop(0.0, oSnd_Ropepully);
    cs_SoundObjectStop(0.0, oSnd_Sawing1);
    cs_SoundObjectStop(0.0, oSnd_Sawing2);
    cs_SoundObjectStop(0.0, oSnd_Sawing3);
    cs_SoundObjectStop(0.0, oSnd_Whistle1);
    cs_SoundObjectStop(0.0, oSnd_Whistle2);
    cs_ActionJumpToObject(0.0, oGuard, oWP_Guard_End);
    cs_ClearAllActions(0.0, oRealGarm);
    cs_ClearAllActions(0.0, oRealNisar);
    cs_ActionJumpToObject(0.1, oRealGarm, oWP_Garm);
    cs_ActionJumpToObject(0.0, oRealNisar, oWP_Nisar);

    cs_MusicBackgroundPlay(1.6);
    cs_CameraJumpToObject(0.0, oWP_PC1_1);
    cs_EndCutscene(0.1, FALSE, TRUE);
}
