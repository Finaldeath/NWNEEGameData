//::///////////////////////////////////////////////
//:: High-level cutscene function include file
//:: _inc_cut_level1.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is the include file for the high-level
    cutscene functions. It should not be directly
    included, include "_inc_cutscene" instead.

    These functions handle the storing of data
    for proper cutscene abort functionality. They
    then apply the given delay to the low-level
    function, which will carry out the actions.

    Direct includes:
      - _inc_cut_level2.nss: Low-level cutscene functions
    Indirect includes:
      - _inc_cut_misc: Miscellaneous cutscene functions
      - _inc_generic: Generic functions
      - _inc_array: Array functions
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Dec. 9, 2003
//:://////////////////////////////////////////////
#include "_inc_cut_level2"

void cs_ActionJumpToLocation(float fDelay, object oCreature, location lLoc, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_ActionJumpToObject(float fDelay, object oCreature, object oObject, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_JumpToLocation(float fDelay, object oCreature, location lLoc, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_JumpToObject(float fDelay, object oCreature, object oObject, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_ActionMoveToLocation(float fDelay, object oCreature, location lLoc, int bRun=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_ActionMoveToObject(float fDelay, object oCreature, object oObject, int bRun=FALSE, float fRange=1.0f, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_ClearAllActions(float fDelay, object oCreature, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_ActionAttack(float fDelay, object oCreature, object oAttackee, int bPassive, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_ActionCastFakeSpellAtLocation(float fDelay, object oCreature, int nSpell, location lTarget, int nProjectilePathType=PROJECTILE_PATH_TYPE_DEFAULT, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_ActionCastFakeSpellAtObject(float fDelay, object oCreature, int nSpell, object oTarget, int nProjectilePathType=PROJECTILE_PATH_TYPE_DEFAULT, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_ActionCastSpellAtLocation(float fDelay, object oCreature, int nSpell, location lTargetLocation, int nMetaMagic=METAMAGIC_ANY, int bCheat=FALSE, int nProjectilePathType=PROJECTILE_PATH_TYPE_DEFAULT, int bInstantSpell=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_ActionCastSpellAtObject(float fDelay, object oCreature, int nSpell, object oTarget, int nMetaMagic=METAMAGIC_ANY, int bCheat=FALSE, int nDomainLevel=0, int nProjectilePathType=PROJECTILE_PATH_TYPE_DEFAULT, int bInstantSpell=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_ActionSpeakString(float fDelay, object oCreature, string sStringToSpeak, int nTalkVolume=TALKVOLUME_TALK, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_ActionSpeakStringByStrRef(float fDelay, object oCreature, int nStrRef, int nTalkVolume=TALKVOLUME_TALK, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_SpeakString(float fDelay, object oCreature, string sStringToSpeak, int nTalkVolume=TALKVOLUME_TALK, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_SpeakStringByStrRef(float fDelay, object oCreature, int nStrRef, int nTalkVolume=TALKVOLUME_TALK, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_FloatingTextStringOnCreature(float fDelay, string sString, object oCreature, int bBroadcastToFactionOnly=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_FloatingTextStrRefOnCreature(float fDelay, int nStrRef, object oCreature, int bBroadcastToFactionOnly=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_SetFacing(float fDelay, object oCreature, float fDirection, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_SetFacingPoint(float fDelay, object oCreature, vector vTarget, object oArea=OBJECT_SELF, int nCutNumber=-1);
// Same as cs_SetFacing, but assigns the facing as an action
void cs_ActionSetFacing(float fDelay, object oCreature, float fDirection, object oArea=OBJECT_SELF, int nCutNumber=-1);
// Same as cs_SetFacingPoint, but assigns the facing as an action
void cs_ActionSetFacingPoint(float fDelay, object oCreature, vector vTarget, object oArea=OBJECT_SELF, int nCutNumber=-1);
// Notes: - If the creature has to move to do the door to do the action, it is best to give them
//          a move action first, to ensure their proper position if the cutscene is aborted.
//        - If you wish to have the door open itself, simply pass in the door object for both
//          oCreature and oDoor.
void cs_ActionCloseDoor(float fDelay, object oCreature, object oDoor, object oArea=OBJECT_SELF, int nCutNumber=-1);
// Notes: - If the creature has to move to do the door to do the action, it is best to give them
//          a move action first, to ensure their proper position if the cutscene is aborted.
//        - This function assumes the door will actually open (is not locked). If it is locked,
//          the position of the door may not be accurate if the cutscene is aborted.
//        - If you wish to have the door open itself, simply pass in the door object for both
//          oCreature and oDoor.
void cs_ActionOpenDoor(float fDelay, object oCreature, object oDoor, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_SetLocked(float fDelay, object oTarget, int bLocked, object oArea=OBJECT_SELF, int nCutNumber=-1);
// bDestroyOnCSEnd: If TRUE, the effect will be destroyed when the cutscene ends OR is aborted.
//                Does nothing if the cutscene is aborted before fDelay.
//                Useful for making sure duration effects go away like intended.
// If you intend a duration effect to remain after the end of a cutscene, you may run into a
// problem when the cutscene is aborted before fDelay, and the effect has not yet been applied.
// For this scenario, I suggest setting bDestroyOnEnd to TRUE, and then re-applying the effect
// in the sEndScript that is specified in cs_StartCutscene().
void cs_ApplyEffectAtLocation(float fDelay, int nDurationType, effect eEffect, location lLocation, float fDuration=0.0f, int bDestroyOnCSEnd=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1);
// bDestroyOnCSEnd: If TRUE, **ALL EFFECTS** on the object will be destroyed when the cutscene
//                ends OR is aborted. Does nothing if the cutscene is aborted before fDelay.
//                Useful for making sure duration effects go away like intended.
// ** If you are applying a vfx, and you only want that one effect to be removed **
// ** from the object on cutscene end/abort, use cs_ApplyVFXToObject();          **
// If you intend a duration effect to remain after the end of a cutscene, you may run into a
// problem when the cutscene is aborted before fDelay, and the effect has not yet been applied.
// For this scenario, I suggest setting bDestroyOnEnd to TRUE, and then re-applying the effect
// in the sEndScript that is specified in cs_StartCutscene().
void cs_ApplyEffectToObject(float fDelay, int nDurationType, effect eEffect, object oTarget, float fDuration=0.0f, int bDestroyOnCSEnd=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_ApplyVFXToObject(float fDelay, int nDurationType, int nVisualEffectId, object oTarget, float fDuration=0.0f, int nMissEffect=FALSE, int bDestroyOnCSEnd=TRUE, object oArea=OBJECT_SELF, int nCutNumber=-1);
// Removes all VFX from oObject
// bAllVFX: If TRUE, removes all visual effects from the object.
//          If FALSE, only removes visual effects that were applied with cs_ApplyVFXToObject,
//          and were given the bDestroyOnCSEnd=TRUE parameter.
void cs_RemoveVFXFromObject(float fDelay, object oObject, int bAllVFX=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1);
// bApplyOnAbort: If TRUE, and the cutscene is aborted before fDelay, the animation will be
//                applied to oObject in the abort script. Useful for looping animations
//                that you intend to keep playing after the end of a cutscene.
// Note: bApplyOnAbort should only be used ONCE per object, and usually only applies if the
//       animation is the last thing you want the object to do in the cutscene.
void cs_ActionPlayAnimation(float fDelay, object oObject, int nAnimation, float fSpeed=1.0, float fDuration=0.0, int bApplyOnAbort=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1);
// bApplyOnAbort: If TRUE, and the cutscene is aborted before fDelay, the animation will be
//                applied to oObject in the abort script. Useful for looping animations
//                that you intend to keep playing after the end of a cutscene.
// Note: bApplyOnAbort should only be used ONCE per object, and usually only applies if the
//       animation is the last thing you want the object to do in the cutscene.
void cs_PlayAnimation(float fDelay, object oObject, int nAnimation, float fSpeed=1.0, float fDuration=0.0, int bApplyOnAbort=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_PlaySound(float fDelay, object oObject, string sSoundName, object oArea=OBJECT_SELF, int nCutNumber=-1);
// bRunAsAction: FALSE = play instantly
void cs_PlaySoundByStrRef(float fDelay, object oObject, int nStrRef, int bRunAsAction=TRUE, object oArea=OBJECT_SELF, int nCutNumber=-1);
// nVoiceChatID: VOICE_CHAT_*
void cs_PlayVoiceChat(float fDelay, object oCreature, int nVoiceChatID, object oArea=OBJECT_SELF, int nCutNumber=-1);
// Warning: Anything done off of scripts within the conversation (ie. the setting of variables)
// will not be handled by the default abort script. The cutscene should either be set as
// non-abortable, or appropriate defaults should be first set.
// Another option would be to end the cutscene completely, start the conversation, and then
// start the next part as a whole new cutscene.
void cs_ActionStartConversation(float fDelay, object oObjectToInitiate, object oObjectToConverseWith, string sDialogResRef="", int bPrivateConversation=FALSE, int bPlayHello=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1);
// Intended use: Specify an NPC for oFireEventOn, and specify a PC object for
// oObjectToTalkTo. The NPC will require a special OnConversation script. This function will
// set the following local variables on the NPC just prior to firing the event.
//  SetLocalObject(oFireEventOn, "cs_oObjectToTalkTo", oObjectToTalkTo);
//  SetLocalString(oFireEventOn, "cs_sResRef", sResRef);
//  SetLocalInt(oFireEventOn, "cs_bTriggeredByCutscene", TRUE);
void cs_FireConversationEvent(float fDelay, object oFireEventOn, object oObjectToTalkTo, string sResRef="", object oArea=OBJECT_SELF, int nCutNumber=-1);
// Triggers the user-defined event on oObject.
// bTriggerEventOnAbort: If TRUE, the event will be triggered if the user aborts the cutscene
//                       before fDelay.
//     Note: Abort functionality currently only supported for creatures, placeables, and doors.
// Note: bApplyOnAbort should only be used ONCE per object, and usually only applies if the
//       event is the last event you want the object to do in the cutscene.
void cs_UsedDefinedEvent(float fDelay, object oObject, int nUserDefinedEventNumber, int bApplyOnAbort=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1);

// Note: bApplyOnAbort should only be used ONCE per object, and usually only applies if this
//       is the last thing you want this sound object to do.
void cs_SoundObjectPlay(float fDelay, object oSound, int bApplyOnAbort=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_SoundObjectSetPosition(float fDelay, object oSound, vector vPosition, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_SoundObjectSetVolume(float fDelay, object oSound, int nVolume, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_SoundObjectStop(float fDelay, object oSound, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_AmbientSoundChangeDay(float fDelay, int nTrack, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_AmbientSoundChangeNight(float fDelay, int nTrack, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_AmbientSoundPlay(float fDelay, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_AmbientSoundStop(float fDelay, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_AmbientSoundSetDayVolume(float fDelay, int nVolume, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_AmbientSoundSetNightVolume(float fDelay, int nVolume, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_MusicBackgroundChangeDay(float fDelay, int nTrack, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_MusicBackgroundChangeNight(float fDelay, int nTrack, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_MusicBackgroundPlay(float fDelay, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_MusicBackgroundStop(float fDelay, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_MusicBattleChange(float fDelay, int nTrack, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_MusicBattlePlay(float fDelay, object oArea=OBJECT_SELF, int nCutNumber=-1);
void cs_MusicBattleStop(float fDelay, object oArea=OBJECT_SELF, int nCutNumber=-1);

// Jumps the cutscene camera to the specified location (immediate, skips action queue)
void cs_CameraJumpToLocation(float fDelay, location lLoc, object oArea=OBJECT_SELF, int nCutNumber=-1);
// Jumps the cutscene camera to the specified object (immediate, skips action queue)
void cs_CameraJumpToObject(float fDelay, object oObject, object oArea=OBJECT_SELF, int nCutNumber=-1);
// Jumps the cutscene camera to the specified location (adds to end of action queue)
void cs_CameraActionJumpToLocation(float fDelay, location lLoc, object oArea=OBJECT_SELF, int nCutNumber=-1);
// Jumps the cutscene camera to the specified object (adds to end of action queue)
void cs_CameraActionJumpToObject(float fDelay, object oObject=OBJECT_INVALID, object oArea=OBJECT_SELF, int nCutNumber=-1);

// Moves the camera to the specified location
// I advise leaving the bRun parameter alone, and use
// cs_CameraSetMovementRate to adjust the camera speed instead
void cs_CameraActionMoveToLocation(float fDelay, location lLoc, int bRun=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1);
// Moves the camera to the specified object
// I advise leaving the bRun parameter alone, and use
// cs_CameraSetMovementRate to adjust the camera speed instead
void cs_CameraActionMoveToObject(float fDelay, object oMoveTo, int bRun=FALSE, float fRange=0.0f, object oArea=OBJECT_SELF, int nCutNumber=-1);

// Sets the current movement rate factor for the cutscene camera man.
// NOTE: You can only set values between 0.1, 2.0 (10%-200%)
void cs_CameraSetMovementRate(float fDelay, float fRate, object oArea=OBJECT_SELF, int nCutNumber=-1);

// Changes lighting to night settings.
// Note: DayToNight/NightToDay work on a per-player basis. If it is day, and you do DayToNight
//       on players in the area, players who enter after that point will have day lighting,
//       not night lighting. The cutscene system will take care of this for you during the
//       cutscene, after the cutscene ends you're on your own. Therefore, you should either
//       make sure to restore the lighting to its original state before ending the cutscene,
//       or keep track of it yourself and use the area OnEnter scripts to set the
//       lighting properly for players.
void cs_CameraDayToNight(float fDelay, float fTransitionTime=0.0, object oArea=OBJECT_SELF, int nCutNumber=-1);
// Changes lighting to day settings.
// Note: DayToNight/NightToDay work on a per-player basis. If it is day, and you do DayToNight
//       on players in the area, players who enter after that point will have day lighting,
//       not night lighting. The cutscene system will take care of this for you during the
//       cutscene, after the cutscene ends you're on your own. Therefore, you should either
//       make sure to restore the lighting to its original state before ending the cutscene,
//       or keep track of it yourself and use the area OnEnter scripts to set the
//       lighting properly for players.
void cs_CameraNightToDay(float fDelay, float fTransitionTime=0.0, object oArea=OBJECT_SELF, int nCutNumber=-1);

// - fDirection is expressed as anticlockwise degrees from Due East.
//   (0.0f=East, 90.0f=North, 180.0f=West, 270.0f=South)
// Distance 1-25
// Pitch 1-89
// -1.0f = ignore parameter
// To do: Add turn direction?
void cs_CameraSetFacing(float fDelay, float fDirection, float fDistance = -1.0f, float fPitch = -1.0f, int nTransitionType=CAMERA_TRANSITION_TYPE_SNAP, object oArea=OBJECT_SELF, int nCutNumber=-1);

// Forces the camera to be set to this height. Setting this value to zero will
// restore the camera to the racial default height.
void cs_CameraSetHeight(float fDelay, float fHeight=0.0f, object oArea=OBJECT_SELF, int nCutNumber=-1);

// Camera fades.
// nFadeType: CS_FADE_TYPE_NONE - immediately removes any fade/black screen.
//            CS_FADE_TYPE_BLACK - immediately sets a black screen.
//            CS_FADE_TYPE_FROM_BLACK - fades in at given speed.
//            CS_FADE_TYPE_TO_BLACK - fades out at given speed.
// fSpeed: FADE_SPEED_* constants. Ignored if using CS_FADE_TYPE_NONE or _BLACK.
void cs_CameraDoFade(float fDelay, int nFadeType, float fSpeed=FADE_SPEED_MEDIUM, object oArea=OBJECT_SELF, int nCutNumber=-1);

// Set the camera mode.
// nCameraMode: CAMERA_MODE_*
void cs_CameraSetCameraMode(float fDelay, int nCameraMode, object oArea=OBJECT_SELF, int nCutNumber=-1);

// Finds a waypoint with the following tags: cs_camera_pos_X
// where X is a number (ie. cs_camera_pos_1)
// Places camera at cs_camera_pos_X
// By default, it faces the camera the direction of cs_camera_pos_X.
// bUseFocusWP: If TRUE, does not use the facing of the position waypoint. Instead,
//              it faces the camera towards a second waypoint, with the tag: cs_camera_focus_X
// cs_camera_pos_X needs the following float variables:
//   fDistance, fPitch (as used in SetCameraFacing())
//   fHeight (as used in SetCameraHeight())
//   fMovementSpeed (as used in SetCutsceneCameraMoveRate() - 0.0 or less jumps the camera)
// and one integer variable:
//   nFacingSpeed (as used in SetCameraFacing())
// Values of -1 mean that variable will be ignored. Not placing the variable on the waypoint
// means a value of 0 will be assumed.
void cs_CameraUseCameraWaypoint(float fDelay, int nCameraNumber, int bUseFocusWP=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1);

void cs_DestroyObject(float fDelay, object oObject, object oArea=OBJECT_SELF, int nCutNumber=-1);

// Makes a copy of the PC, and returns the copied PC.
// NOTE: This function is NOT delayed, so it will appear at the beginning of the cutscene.
// If you do not want it to appear right away, try spawning it off-screen.
// lLoc: Location the creature will spawn in at.
// bPCLocation: Spawns creature at PC's location. Overrides lLoc.
// nPCNumber: The number of the PC to be copied. Goes in the order they joined the
//            cutscene starting at 0. An invalid number will return OBJECT_INVALID.
//            Use cs_GetPCNumber() to get a PC's number.
// sTag: Tag you wish to give the copied object (defaults to "pccopy")
// bDestroyOnCSEnd: If TRUE, the copy will be destroyed when the cutscene ends (normally or aborted)
object cs_CopyPC(location lLoc, int bPCLocation=FALSE, int nPCNumber=0, string sTag="pccopy", int bDestroyOnCSEnd=TRUE, object oArea=OBJECT_SELF, int nCutNumber=-1);

// nPCNumber: The number of the PC to be rendered visible. Goes in the order they joined the
//            cutscene starting at 0. An invalid number will default back to 0.
//            Use cs_GetPCNumber() to get a PC's number by their name.
// Note: Only 1 PC in a cutscene may be visible at a time. If a PC is already visible,
//       this function will do nothing.
//       If you wish other PC's to be visible, use cs_CopyPC() for them.
void cs_RenderPCVisible(float fDelay, int nPCNumber=0, object oArea=OBJECT_SELF, int nCutNumber=-1);

// If cs_RenderPCVisible was used to make a PC visible for the cutscene, this function will
// make them invisible again. Since only one PC may be visible, there is no need to specify
// which PC.
void cs_RenderPCInvisible(float fDelay, object oArea=OBJECT_SELF, int nCutNumber=-1);

// Returns the number of a PC for a cutscene
// oPC: The PC object. Specify OBJECT_INVALID if you would rather get the PC's
//      number by their name.
// sPCName: The name of the PC. Ignored if oPC is a valid object.
// Returns -1 if oPC is not in the cutscene, or if no PC with the name sPCName is in the cutscene.
int cs_GetPCNumber(object oPC=OBJECT_INVALID, string sPCName="", object oArea=OBJECT_SELF, int nCutNumber=-1);

// Delay values for cutscene commands can either be a total value or an incremented value.
// This changes which type the delay will be on a per-area basis.
// Use cs_ChangeDefaultDelayType() to change the default type globally.
// cs_ChangeDelayType() will always override the global default, for the specified area.
// NOTE: Intended for use at the very start of a cutscene script.
// nDelayType: CS_DELAY_TYPE_TOTAL - Start of the cutscene is 0.0 seconds. Delay parameters
//                                   for cutscene functions will be total time passed since
//                                   the start of the cutscene.
//             CS_DELAY_TYPE_INCREMENTED - Delay parameters for cutscene functions will be
//                                         time passed since the last cutscene function (or
//                                         start of the cutscene, if it is the first delayed
//                                         function of the cutscene.
void cs_SetDelayType(int nDelayType, object oArea=OBJECT_SELF);

// Delay values for cutscene commands can either be a total value or an incremented value.
// This changes which type the delay will be, as a global default.
// Use cs_ChangeDelayType() to change the delay type for a specific cutscene.
// cs_ChangeDelayType() will always override the global default, for the specified area.
// NOTE: Not intended for use in cutscene scripts (though acceptable at the very start
//       of a cutscenes script).
// nDelayType: CS_DELAY_TYPE_TOTAL - Start of the cutscene is 0.0 seconds. Delay parameters
//                                   for cutscene functions will be total time passed since
//                                   the start of the cutscene.
//             CS_DELAY_TYPE_INCREMENTED - Delay parameters for cutscene functions will be
//                                         time passed since the last cutscene function (or
//                                         start of the cutscene, if it is the first delayed
//                                         function of the cutscene.
void cs_SetDefaultDelayType(int nDelayType);

// Resets the total delay to fResetValueTo.
// Only applicable if using CS_DELAY_TYPE_INCREMENTED.
// fDelay: Works the same as fDelay for other cutscene functions, except that it is
//         completely ignored at the default value of -1.0.
// fResetValueTo: The value to reset it to (should almost always leave at default, 0.0)
//   The intended use for this function is when you need to split up a cutscene into more
//   than one script. Here is an example of where you would want to do this:
//   The cutscene starts off with some NPC's walking around and whatnot. Then at some point
//   you want a conversation to start with the player, but you want it to be within the
//   cutscene. The last function in the initial cutscene script should be the one to start
//   the conversation. The end of the conversation should then fire a new script, which is
//   the next part of the cutscene.
//   If you are using CS_DELAY_TYPE_TOTAL, then fDelay for the cutscene functions in this
//   script would simply be the delay from the start of that script, and this function is not
//   needed. But if you are using CS_DELAY_TYPE_INCREMENTED, you should use this funciton so
//   that you get the proper delays.
// Important: Currently, the abort scripting will not take into account if you split up
// scripts in this manner. This is because it can only deal with scripts that have fired -
// if the second script has not fired, and the player aborts in the first part, it can only
// deal with actions in that first part. You can either make the cutscene non-abortable, or
// put in custom abort scripting to deal with this.
void cs_ResetDelay(float fDelay=-1.0, float fResetValueTo=0.0, object oArea=OBJECT_SELF, int nCutNumber=-1);

// Returns the total delay that has accumulated.
// This is only useful when using CS_DELAY_TYPE_INCREMENTED.
float cs_GetDelay(object oArea=OBJECT_SELF);

// Intended for use in end-cutscene scripts, as specified in cs_StartCutscene.
// If the cutscene was aborted, this will return TRUE, otherwise FALSE (ended normally).
// nCutNumber: Defaults to -1, which means the last cutscene that was run in the area.
int cs_GetWasCutsceneAborted(object oArea=OBJECT_SELF, int nCutNumber=-1);

// Returns TRUE if the specified cutscene was ever started in the specified area,
// even if the cutscene has since ended - otherwise returns FALSE.
int cs_GetCutsceneStarted(int nCutNumber=1, object oArea=OBJECT_SELF);
// Returns TRUE if the specified cutscene in the specified area has ended.
// Otherwise returns FALSE.
int cs_GetCutsceneEnded(int nCutNumber=1, object oArea=OBJECT_SELF);
// Returns the number of the currently running cutscene, or FALSE if no cutscene is currently running.
int cs_GetCutsceneRunning(object oArea=OBJECT_SELF);

// Fades the screen for all players in the area. Intended for use before the cutscene proper
// starts. During the cutscene you should use cs_CameraDoFade().
// nFadeType: CS_FADE_TYPE_NONE - immediately removes any fade/black screen.
//            CS_FADE_TYPE_BLACK - immediately sets a black screen.
//            CS_FADE_TYPE_IN - fades in at given speed.
//            CS_FADE_TYPE_OUT - fades out at given speed.
// fSpeed: FADE_SPEED_* constants. Ignored if using CS_FADE_TYPE_NONE or _BLACK.
// oArea: If OBJECT_SELF is not an area, it will automatically try GetArea(OBJECT_SELF)
void cs_PreCutsceneFade(int nFadeType=CS_FADE_TYPE_TO_BLACK, float fSpeed=FADE_SPEED_MEDIUM, object oArea=OBJECT_SELF);

// Returns the PC object
object cs_GetPCObject(int nPCNumber=0, object oArea=OBJECT_SELF);

float cs_GetCameraWaypointFacing(int nCameraNumber, object oArea=OBJECT_SELF);
float cs_GetCameraWaypointHeight(int nCameraNumber, object oArea=OBJECT_SELF);
float cs_GetCameraWaypointPitch(int nCameraNumber, object oArea=OBJECT_SELF);
float cs_GetCameraWaypointDistance(int nCameraNumber, object oArea=OBJECT_SELF);

//================================================

void cs_ActionJumpToLocation(float fDelay, object oCreature, location lLoc, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_AddActor(oCreature, oArea);
    csm_SetFlag(CS_FLAG_POSITION, oCreature);
    SetLocalLocation(oCreature, "cs_lEndLoc", lLoc);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ActionJumpToLocation(oCreature, lLoc, nCutNumber, oArea));
}

void cs_ActionJumpToObject(float fDelay, object oCreature, object oObject, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    cs_ActionJumpToLocation(fDelay, oCreature, GetLocation(oObject), oArea, nCutNumber);
}

void cs_JumpToLocation(float fDelay, object oCreature, location lLoc, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_AddActor(oCreature, oArea);
    csm_SetFlag(CS_FLAG_POSITION, oCreature);
    SetLocalLocation(oCreature, "cs_lEndLoc", lLoc);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_JumpToLocation(oCreature, lLoc, nCutNumber, oArea));
}

void cs_JumpToObject(float fDelay, object oCreature, object oObject, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    cs_JumpToLocation(fDelay, oCreature, GetLocation(oObject), oArea, nCutNumber);
}

void cs_ActionMoveToLocation(float fDelay, object oCreature, location lLoc, int bRun=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_AddActor(oCreature, oArea);
    csm_SetFlag(CS_FLAG_POSITION, oCreature);
    SetLocalLocation(oCreature, "cs_lEndLoc", lLoc);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ActionMoveToLocation(oCreature, lLoc, bRun, nCutNumber, oArea));
}

void cs_ActionMoveToObject(float fDelay, object oCreature, object oObject, int bRun=FALSE, float fRange=1.0f, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_AddActor(oCreature, oArea);
    csm_SetFlag(CS_FLAG_POSITION, oCreature);
    SetLocalLocation(oCreature, "cs_lEndLoc", GetLocation(oObject));
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ActionMoveToObject(oCreature, oObject, bRun, fRange, nCutNumber, oArea));
}

void cs_ClearAllActions(float fDelay, object oCreature, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ClearAllActions(oCreature, nCutNumber, oArea));
}

// note: aborted scripts may not abort quite right if this is used
void cs_ActionAttack(float fDelay, object oCreature, object oAttackee, int bPassive, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ActionAttack(oCreature, oAttackee, bPassive, nCutNumber, oArea));
}

void cs_ActionCastFakeSpellAtLocation(float fDelay, object oCreature, int nSpell, location lTarget, int nProjectilePathType=PROJECTILE_PATH_TYPE_DEFAULT, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ActionCastFakeSpellAtLocation(oCreature, nSpell, lTarget, nProjectilePathType, nCutNumber, oArea));
}

void cs_ActionCastFakeSpellAtObject(float fDelay, object oCreature, int nSpell, object oTarget, int nProjectilePathType=PROJECTILE_PATH_TYPE_DEFAULT, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ActionCastFakeSpellAtObject(oCreature, nSpell, oTarget, nProjectilePathType, nCutNumber, oArea));
}

void cs_ActionCastSpellAtLocation(float fDelay, object oCreature, int nSpell, location lTargetLocation, int nMetaMagic=METAMAGIC_ANY, int bCheat=FALSE, int nProjectilePathType=PROJECTILE_PATH_TYPE_DEFAULT, int bInstantSpell=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ActionCastSpellAtLocation(oCreature, nSpell, lTargetLocation, nMetaMagic, bCheat, nProjectilePathType, bInstantSpell, nCutNumber, oArea));
}

void cs_ActionCastSpellAtObject(float fDelay, object oCreature, int nSpell, object oTarget, int nMetaMagic=METAMAGIC_ANY, int bCheat=FALSE, int nDomainLevel=0, int nProjectilePathType=PROJECTILE_PATH_TYPE_DEFAULT, int bInstantSpell=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ActionCastSpellAtObject(oCreature, nSpell, oTarget, nMetaMagic, bCheat, nDomainLevel, nProjectilePathType, bInstantSpell, nCutNumber, oArea));
}

void cs_ActionSpeakString(float fDelay, object oCreature, string sStringToSpeak, int nTalkVolume=TALKVOLUME_TALK, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ActionSpeakString(oCreature, sStringToSpeak, nTalkVolume, nCutNumber, oArea));
}

void cs_ActionSpeakStringByStrRef(float fDelay, object oCreature, int nStrRef, int nTalkVolume=TALKVOLUME_TALK, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ActionSpeakStringByStrRef(oCreature, nStrRef, nTalkVolume, nCutNumber, oArea));
}

void cs_SpeakString(float fDelay, object oCreature, string sStringToSpeak, int nTalkVolume=TALKVOLUME_TALK, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_SpeakString(oCreature, sStringToSpeak, nTalkVolume, nCutNumber, oArea));
}

void cs_SpeakStringByStrRef(float fDelay, object oCreature, int nStrRef, int nTalkVolume=TALKVOLUME_TALK, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_SpeakStringByStrRef(oCreature, nStrRef, nTalkVolume, nCutNumber, oArea));
}

void cs_FloatingTextStringOnCreature(float fDelay, string sString, object oCreature, int bBroadcastToFactionOnly=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_FloatingTextStringOnCreature(sString, oCreature, bBroadcastToFactionOnly, nCutNumber, oArea));
}

void cs_FloatingTextStrRefOnCreature(float fDelay, int nStrRef, object oCreature, int bBroadcastToFactionOnly=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_FloatingTextStrRefOnCreature(nStrRef, oCreature, bBroadcastToFactionOnly, nCutNumber, oArea));
}

void cs_SetFacing(float fDelay, object oCreature, float fDirection, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_AddActor(oCreature, oArea);
    csm_SetFlag(CS_FLAG_FACING, oCreature);
    SetLocalFloat(oCreature, "cs_fEndFacing", fDirection);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_SetFacing(oCreature, fDirection, nCutNumber, oArea));
}

void cs_SetFacingPoint(float fDelay, object oCreature, vector vTarget, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_AddActor(oCreature, oArea);
    csm_SetFlag(CS_FLAG_FACING, oCreature);
    float fDirection = VectorToAngle(vTarget - GetPosition(oCreature));
    SetLocalFloat(oCreature, "cs_fEndFacing", fDirection);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ActionSetFacingPoint(oCreature, vTarget, nCutNumber, oArea));
}

// Same as cs_SetFacing, but assigns the facing as an action
void cs_ActionSetFacing(float fDelay, object oCreature, float fDirection, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_AddActor(oCreature, oArea);
    csm_SetFlag(CS_FLAG_FACING, oCreature);
    SetLocalFloat(oCreature, "cs_fEndFacing", fDirection);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ActionSetFacing(oCreature, fDirection, nCutNumber, oArea));
}

// Same as cs_SetFacingPoint, but assigns the facing as an action
void cs_ActionSetFacingPoint(float fDelay, object oCreature, vector vTarget, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
/* this is no good, I want the facing point at the time of the facing...
    // calculate manually instead of using SetFacingPoint, because we need to store
    // the end facing as an angle anyway
    float fDirection = VectorToAngle(vTarget - GetPosition(oCreature));
    cs_ActionSetFacing(fDelay, oCreature, fDirection, nCutNumber, oArea);
*/
    csm_AddActor(oCreature, oArea);
    csm_SetFlag(CS_FLAG_FACING, oCreature);
    // still going to calculate the facing - it may sometimes be ok, so having the facing
    // right when aborting only sometimes is better than never.
    float fDirection = VectorToAngle(vTarget - GetPosition(oCreature));
    SetLocalFloat(oCreature, "cs_fEndFacing", fDirection);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ActionSetFacingPoint(oCreature, vTarget, nCutNumber, oArea));
}

// Notes: - If the creature has to move to do the door to do the action, it is best to give them
//          a move action first, to ensure their proper position if the cutscene is aborted.
//        - If you wish to have the door open itself, simply pass in the door object for both
//          oCreature and oDoor.
void cs_ActionCloseDoor(float fDelay, object oCreature, object oDoor, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_AddActor(oDoor, oArea);
    csm_SetFlag(CS_FLAG_DOOR_OPEN_STATE, oDoor);
    SetLocalInt(oDoor, "cs_nEndDoorOpenState", CS_DOOR_CLOSED);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ActionCloseDoor(oCreature, oDoor, nCutNumber, oArea));
}

// Notes: - If the creature has to move to do the door to do the action, it is best to give them
//          a move action first, to ensure their proper position if the cutscene is aborted.
//        - This function assumes the door will actually open (is not locked). If it is locked,
//          the position of the door may not be accurate if the cutscene is aborted.
//        - If you wish to have the door open itself, simply pass in the door object for both
//          oCreature and oDoor.
void cs_ActionOpenDoor(float fDelay, object oCreature, object oDoor, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_AddActor(oDoor, oArea);
    csm_SetFlag(CS_FLAG_DOOR_OPEN_STATE, oDoor);
    SetLocalInt(oDoor, "cs_nEndDoorOpenState", CS_DOOR_OPEN);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ActionOpenDoor(oCreature, oDoor, nCutNumber, oArea));
}

void cs_SetLocked(float fDelay, object oTarget, int bLocked, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_AddActor(oTarget, oArea);
    csm_SetFlag(CS_FLAG_OBJECT_LOCK_STATE, oTarget);
    if(bLocked) SetLocalInt(oTarget, "cs_nEndObjectLockState", CS_OBJECT_LOCKED);
    else SetLocalInt(oTarget, "cs_nEndObjectLockState", CS_OBJECT_UNLOCKED);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_SetLocked(oTarget, bLocked, nCutNumber, oArea));
}

// bDestroyOnCSEnd: If TRUE, the effect will be destroyed when the cutscene ends OR is aborted.
//                Does nothing if the cutscene is aborted before fDelay.
//                Useful for making sure duration effects go away like intended.
// If you intend a duration effect to remain after the end of a cutscene, you may run into a
// problem when the cutscene is aborted before fDelay, and the effect has not yet been applied.
// For this scenario, I suggest setting bDestroyOnEnd to TRUE, and then re-applying the effect
// in the sEndScript that is specified in cs_StartCutscene().
void cs_ApplyEffectAtLocation(float fDelay, int nDurationType, effect eEffect, location lLocation, float fDuration=0.0f, int bDestroyOnCSEnd=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ApplyEffectAtLocation(nDurationType, eEffect, lLocation, fDuration, bDestroyOnCSEnd, nCutNumber, oArea));
}

// bDestroyOnCSEnd: If TRUE, **ALL EFFECTS** on the object will be destroyed when the cutscene
//                ends OR is aborted. Does nothing if the cutscene is aborted before fDelay.
//                Useful for making sure duration effects go away like intended.
// ** If you are applying a vfx, and you only want that one effect to be removed **
// ** from the object on cutscene end/abort, use cs_ApplyVFXToObject();          **
// If you intend a duration effect to remain after the end of a cutscene, you may run into a
// problem when the cutscene is aborted before fDelay, and the effect has not yet been applied.
// For this scenario, I suggest setting bDestroyOnEnd to TRUE, and then re-applying the effect
// in the sEndScript that is specified in cs_StartCutscene().
void cs_ApplyEffectToObject(float fDelay, int nDurationType, effect eEffect, object oTarget, float fDuration=0.0f, int bDestroyOnCSEnd=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_AddActor(oTarget, oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ApplyEffectToObject(nDurationType, eEffect, oTarget, fDuration, bDestroyOnCSEnd, nCutNumber, oArea));
}

void cs_ApplyVFXToObject(float fDelay, int nDurationType, int nVisualEffectId, object oTarget, float fDuration=0.0f, int nMissEffect=FALSE, int bDestroyOnCSEnd=TRUE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_AddActor(oTarget, oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ApplyVFXToObject(nDurationType, nVisualEffectId, oTarget, fDuration, nMissEffect, bDestroyOnCSEnd, nCutNumber, oArea));
}

void cs_RemoveVFXFromObject(float fDelay, object oObject, int bAllVFX=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_RemoveVFXFromObject(oObject, bAllVFX, nCutNumber, oArea));
}

// bApplyOnAbort: If TRUE, and the cutscene is aborted before fDelay, the animation will be
//                applied to oObject in the abort script. Useful for looping animations
//                that you intend to keep playing after the end of a cutscene.
// Note: bApplyOnAbort should only be used ONCE per object, and usually only applies if the
//       animation is the last thing you want the object to do in the cutscene.
void cs_ActionPlayAnimation(float fDelay, object oObject, int nAnimation, float fSpeed=1.0, float fDuration=0.0, int bApplyOnAbort=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    if(bApplyOnAbort)
    {
        csm_AddActor(oObject, oArea);
        csm_SetFlag(CS_FLAG_ANIMATION, oObject);
        SetLocalInt(oObject, "cs_Anim_nAnimation", nAnimation);
        SetLocalFloat(oObject, "cs_Anim_fSpeed", fSpeed);
        SetLocalFloat(oObject, "cs_Anim_fDuration", fDuration);
    }
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ActionPlayAnimation(oObject, nAnimation, fSpeed, fDuration, nCutNumber, oArea));
}

// bApplyOnAbort: If TRUE, and the cutscene is aborted before fDelay, the animation will be
//                applied to oObject in the abort script. Useful for looping animations
//                that you intend to keep playing after the end of a cutscene.
// Note: bApplyOnAbort should only be used ONCE per object, and usually only applies if the
//       animation is the last thing you want the object to do in the cutscene.
void cs_PlayAnimation(float fDelay, object oObject, int nAnimation, float fSpeed=1.0, float fDuration=0.0, int bApplyOnAbort=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    if(bApplyOnAbort)
    {
        csm_AddActor(oObject, oArea);
        csm_SetFlag(CS_FLAG_ANIMATION, oObject);
        SetLocalInt(oObject, "cs_Anim_nAnimation", nAnimation);
        SetLocalFloat(oObject, "cs_Anim_fSpeed", fSpeed);
        SetLocalFloat(oObject, "cs_Anim_fDuration", fDuration);
    }
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_PlayAnimation(oObject, nAnimation, fSpeed, fDuration, nCutNumber, oArea));
}

void cs_PlaySound(float fDelay, object oObject, string sSoundName, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_PlaySound(oObject, sSoundName, nCutNumber, oArea));
}

// bRunAsAction: FALSE = play instantly
void cs_PlaySoundByStrRef(float fDelay, object oObject, int nStrRef, int bRunAsAction=TRUE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_PlaySoundByStrRef(oObject, nStrRef, bRunAsAction, nCutNumber, oArea));
}

// nVoiceChatID: VOICE_CHAT_*
void cs_PlayVoiceChat(float fDelay, object oCreature, int nVoiceChatID, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_PlayVoiceChat(oCreature, nVoiceChatID, nCutNumber, oArea));
}

void cs_ActionStartConversation(float fDelay, object oObjectToInitiate, object oObjectToConverseWith, string sDialogResRef="", int bPrivateConversation=FALSE, int bPlayHello=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ActionStartConversation(oObjectToInitiate, oObjectToConverseWith, sDialogResRef, bPrivateConversation, bPlayHello, nCutNumber, oArea));
}

// Intended use: Specify an NPC for oFireEventOn, and specify a PC object for
// oObjectToTalkTo. The NPC will require a special OnConversation script. This function will
// set the following local variables on the NPC just prior to firing the event.
//  SetLocalObject(oFireEventOn, "cs_oObjectToTalkTo", oObjectToTalkTo);
//  SetLocalString(oFireEventOn, "cs_sResRef", sResRef);
//  SetLocalInt(oFireEventOn, "cs_bTriggeredByCutscene", TRUE);
void cs_FireConversationEvent(float fDelay, object oFireEventOn, object oObjectToTalkTo, string sResRef="", object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_FireConversationEvent(oFireEventOn, oObjectToTalkTo, sResRef, nCutNumber, oArea));
}

// Note: bApplyOnAbort should only be used ONCE per object, and usually only applies if the
//       animation is the last thing you want the object to do in the cutscene.
void cs_UsedDefinedEvent(float fDelay, object oObject, int nUserDefinedEventNumber, int bApplyOnAbort=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    if(bApplyOnAbort)
    {
        csm_AddActor(oObject, oArea);
        csm_SetFlag(CS_FLAG_USER_DEFINED_EVENT, oObject);
        SetLocalInt(oObject, "cs_nUserDefinedEventNumber", nUserDefinedEventNumber);
    }
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_UserDefinedEvent(oObject, nUserDefinedEventNumber, nCutNumber, oArea));
}

// Note: bApplyOnAbort should only be used ONCE per object, and usually only applies if the
//       animation is the last thing you want the object to do in the cutscene.
void cs_SoundObjectPlay(float fDelay, object oSound, int bApplyOnAbort=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    if(bApplyOnAbort)
    {
        csm_AddActor(oSound, oArea);
        csm_SetFlag(CS_FLAG_SOUND, oSound);
        SetLocalInt(oSound, "cs_nPlay", CS_SOUND_PLAY);
    }
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_SoundObjectPlay(oSound, nCutNumber, oArea));
}

void cs_SoundObjectSetPosition(float fDelay, object oSound, vector vPosition, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_AddActor(oSound, oArea);
    csm_SetFlag(CS_FLAG_POSITION, oSound);
    SetLocalFloat(oSound, "cs_fEndLocX", vPosition.x);
    SetLocalFloat(oSound, "cs_fEndLocY", vPosition.y);
    SetLocalFloat(oSound, "cs_fEndLocZ", vPosition.z);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_SoundObjectSetPosition(oSound, vPosition, nCutNumber, oArea));
}
void cs_SoundObjectSetVolume(float fDelay, object oSound, int nVolume, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_AddActor(oSound, oArea);
    csm_SetFlag(CS_FLAG_SOUND_VOLUME, oSound);
    SetLocalInt(oSound, "cs_nSoundVolume", nVolume);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_SoundObjectSetVolume(oSound, nVolume, nCutNumber, oArea));
}
void cs_SoundObjectStop(float fDelay, object oSound, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_AddActor(oSound, oArea);
    csm_SetFlag(CS_FLAG_SOUND, oSound);
    SetLocalInt(oSound, "cs_nPlay", CS_SOUND_STOP);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_SoundObjectStop(oSound, nCutNumber, oArea));
}
void cs_AmbientSoundChangeDay(float fDelay, int nTrack, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_SetFlag(CS_AREA_FLAG_AMBIENT_SOUND_CHANGE_DAY, oArea);
    SetLocalInt(oArea, "cs_nAmbientSoundDay", nTrack);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_AmbientSoundChangeDay(nTrack, nCutNumber, oArea));
}

void cs_AmbientSoundChangeNight(float fDelay, int nTrack, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_SetFlag(CS_AREA_FLAG_AMBIENT_SOUND_CHANGE_NIGHT, oArea);
    SetLocalInt(oArea, "cs_nAmbientSoundNight", nTrack);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_AmbientSoundChangeNight(nTrack, nCutNumber, oArea));
}

void cs_AmbientSoundPlay(float fDelay, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_SetFlag(CS_AREA_FLAG_AMBIENT_SOUND_PLAY, oArea);
    SetLocalInt(oArea, "cs_nPlayAmbient", CS_SOUND_PLAY);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_AmbientSoundPlay(nCutNumber, oArea));
}

void cs_AmbientSoundStop(float fDelay, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_SetFlag(CS_AREA_FLAG_AMBIENT_SOUND_PLAY, oArea);
    SetLocalInt(oArea, "cs_nPlayAmbient", CS_SOUND_STOP);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_AmbientSoundStop(nCutNumber, oArea));
}

void cs_AmbientSoundSetDayVolume(float fDelay, int nVolume, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_SetFlag(CS_AREA_FLAG_AMBIENT_SOUND_VOLUME_DAY, oArea);
    SetLocalInt(oArea, "cs_nAmbientSoundVolumeDay", nVolume);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_AmbientSoundSetDayVolume(nVolume, nCutNumber, oArea));
}

void cs_AmbientSoundSetNightVolume(float fDelay, int nVolume, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_SetFlag(CS_AREA_FLAG_AMBIENT_SOUND_VOLUME_NIGHT, oArea);
    SetLocalInt(oArea, "cs_nAmbientSoundVolumeNight", nVolume);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_AmbientSoundSetNightVolume(nVolume, nCutNumber, oArea));
}

void cs_MusicBackgroundChangeDay(float fDelay, int nTrack, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_SetFlag(CS_AREA_FLAG_MUSIC_CHANGE_DAY, oArea);
    SetLocalInt(oArea, "cs_nMusicTrackDay", nTrack);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_MusicBackgroundChangeDay(nTrack, nCutNumber, oArea));
}

void cs_MusicBackgroundChangeNight(float fDelay, int nTrack, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_SetFlag(CS_AREA_FLAG_MUSIC_CHANGE_NIGHT, oArea);
    SetLocalInt(oArea, "cs_nMusicTrackNight", nTrack);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_MusicBackgroundChangeNight(nTrack, nCutNumber, oArea));
}

void cs_MusicBackgroundPlay(float fDelay, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_SetFlag(CS_AREA_FLAG_MUSIC_PLAY, oArea);
    SetLocalInt(oArea, "cs_nPlayMusic", CS_SOUND_PLAY);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_MusicBackgroundPlay(nCutNumber, oArea));
}

void cs_MusicBackgroundStop(float fDelay, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_SetFlag(CS_AREA_FLAG_MUSIC_PLAY, oArea);
    SetLocalInt(oArea, "cs_nPlayMusic", CS_SOUND_STOP);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_MusicBackgroundStop(nCutNumber, oArea));
}

void cs_MusicBattleChange(float fDelay, int nTrack, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_SetFlag(CS_AREA_FLAG_MUSIC_BATTLE_CHANGE, oArea);
    SetLocalInt(oArea, "cs_nMusicBattleTrack", nTrack);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_MusicBattleChange(nTrack, nCutNumber, oArea));
}

void cs_MusicBattlePlay(float fDelay, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_SetFlag(CS_AREA_FLAG_MUSIC_BATTLE_PLAY, oArea);
    SetLocalInt(oArea, "cs_nPlayBattle", CS_SOUND_PLAY);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_MusicBattlePlay(nCutNumber, oArea));
}

void cs_MusicBattleStop(float fDelay, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_SetFlag(CS_AREA_FLAG_MUSIC_BATTLE_PLAY, oArea);
    SetLocalInt(oArea, "cs_nPlayBattle", CS_SOUND_STOP);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_MusicBattleStop(nCutNumber, oArea));
}


// Jumps the cutscene camera to the specified location (immediate, skips action queue)
void cs_CameraJumpToLocation(float fDelay, location lLoc, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_CameraSetEndLocation(lLoc, oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_CameraJumpToLocation(lLoc, nCutNumber, oArea));
}

// Jumps the cutscene camera to the specified object (immediate, skips action queue)
void cs_CameraJumpToObject(float fDelay, object oObject, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    cs_CameraJumpToLocation(fDelay, GetLocation(oObject), oArea, nCutNumber);
}

// Jumps the cutscene camera to the specified location (adds to end of action queue)
void cs_CameraActionJumpToLocation(float fDelay, location lLoc, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_CameraSetEndLocation(lLoc, oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_CameraActionJumpToLocation(lLoc, nCutNumber, oArea));
}

// Jumps the cutscene camera to the specified object (adds to end of action queue)
void cs_CameraActionJumpToObject(float fDelay, object oObject, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    cs_CameraActionJumpToLocation(fDelay, GetLocation(oObject), oArea, nCutNumber);
}

// - fDirection is expressed as anticlockwise degrees from Due East.
//   (0.0f=East, 90.0f=North, 180.0f=West, 270.0f=South)
// Distance 1-25
// Pitch 1-89
// -1.0f = ignore parameter
void cs_CameraSetFacing(float fDelay, float fDirection, float fDistance = -1.0f, float fPitch = -1.0f, int nTransitionType=CAMERA_TRANSITION_TYPE_SNAP, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
//    csm_CameraSetEndFacing(fDirection, fDistance, fPitch, oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_CameraSetFacing(fDirection, fDistance, fPitch, nTransitionType, nCutNumber, oArea));
}

// Forces the camera to be set to this height. Setting this value to zero will
// restore the camera to the racial default height.
void cs_CameraSetHeight(float fDelay, float fHeight=0.0f, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
//    csm_CameraSetEndHeight(fHeight, oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_CameraSetHeight(fHeight, nCutNumber, oArea));
}

// Moves the camera to the specified location
// I advise leaving the bRun parameter alone, and use
// cs_CameraSetMovementRate to adjust the camera speed instead
void cs_CameraActionMoveToLocation(float fDelay, location lLoc, int bRun=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_CameraSetEndLocation(lLoc, oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_CameraActionMoveToLocation(lLoc, bRun, nCutNumber, oArea));
}

// Moves the camera to the specified object
// I advise leaving the bRun parameter alone, and use
// cs_CameraSetMovementRate to adjust the camera speed instead
void cs_CameraActionMoveToObject(float fDelay, object oMoveTo, int bRun=FALSE, float fRange=0.0f, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_CameraSetEndLocation(GetLocation(oMoveTo), oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_CameraActionMoveToObject(oMoveTo, bRun, fRange, nCutNumber, oArea));
}

// Sets the current movement rate factor for the cutscene camera man.
// NOTE: You can only set values between 0.1, 2.0 (10%-200%)
void cs_CameraSetMovementRate(float fDelay, float fRate, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_CameraSetMovementRate(fRate, nCutNumber, oArea));
}

void cs_CameraDayToNight(float fDelay, float fTransitionTime=0.0, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_CameraSetEndDayNightSetting(CS_DAYNIGHT_NIGHT, oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_CameraDayToNight(fTransitionTime, nCutNumber, oArea));
}

void cs_CameraNightToDay(float fDelay, float fTransitionTime=0.0, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_CameraSetEndDayNightSetting(CS_DAYNIGHT_DAY, oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_CameraNightToDay(fTransitionTime, nCutNumber, oArea));
}

// Camera fades.
// nFadeType: CS_FADE_TYPE_NONE - immediately removes any fade/black screen.
//            CS_FADE_TYPE_BLACK - immediately sets a black screen.
//            CS_FADE_TYPE_IN - fades in (from black) at given speed.
//            CS_FADE_TYPE_OUT - fades out (to black) at given speed.
// fSpeed: FADE_SPEED_* constants. Ignored if using CS_FADE_TYPE_NONE or _BLACK.
void cs_CameraDoFade(float fDelay, int nFadeType, float fSpeed=FADE_SPEED_MEDIUM, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_CameraSetEndFade(nFadeType, oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_CameraDoFade(nFadeType, fSpeed, nCutNumber, oArea));
}

void cs_CameraSetCameraMode(float fDelay, int nCameraMode, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_CameraSetCameraMode(nCameraMode, nCutNumber, oArea));
}

void cs_CameraUseCameraWaypoint(float fDelay, int nCameraNumber, int bUseFocusWP=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    object oCameraPosition = GetObjectByTagInArea(CS_CAMERA_TAG_POSITION+IntToString(nCameraNumber), oArea);
    float fFacing;
    if(bUseFocusWP)
    {
        object oCameraFocus = GetObjectByTagInArea(CS_CAMERA_TAG_FOCUS+IntToString(nCameraNumber), oArea);
        fFacing = GetFacingBetweenObjects(oCameraPosition, oCameraFocus);
    }
    else
    {
        fFacing = GetFacing(oCameraPosition);
    }
    float fHeight = GetLocalFloat(oCameraPosition, "fHeight");
    float fPitch = GetLocalFloat(oCameraPosition, "fPitch");
    float fDistance = GetLocalFloat(oCameraPosition, "fDistance");
    float fMovementSpeed = GetLocalFloat(oCameraPosition, "fMovementSpeed");
    int nFacingSpeed = GetLocalInt(oCameraPosition, "nFacingSpeed");

    // I'll be doing an unknown number of calls to other cutscene functions,
    // each which have to do csm_AdjustDelay. This would really screw things
    // up when using CS_DELAY_TYPE_INCREMENTED. So I get the adjusted delay
    // once here, switch to CS_DELAY_TYPE_TOTAL, and then back (if necessary).
    int bUsingIncremented = (GetLocalInt(oArea, "cs_DelayType")==CS_DELAY_TYPE_INCREMENTED);
    float fFullDelay = csm_AdjustDelay(fDelay, oArea);
    cs_SetDelayType(CS_DELAY_TYPE_TOTAL);

    if(fMovementSpeed<0.01)
    {
        cs_CameraJumpToObject(fFullDelay, oCameraPosition, oArea, nCutNumber);
    }
    else
    {
        cs_CameraSetMovementRate(fFullDelay, fMovementSpeed, oArea, nCutNumber);
        cs_CameraActionMoveToObject(fFullDelay, oCameraPosition, FALSE, 0.0, oArea, nCutNumber);
    }

    if(fHeight > -0.1)
    {
        cs_CameraSetHeight(fFullDelay, fHeight, oArea, nCutNumber);
    }

    cs_CameraSetFacing(fFullDelay+0.1, fFacing, fDistance, fPitch, nFacingSpeed, oArea, nCutNumber);

    if(bUsingIncremented) cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);
}

void cs_DestroyObject(float fDelay, object oObject, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    csm_AddActor(oObject, oArea);
    csm_SetFlag(CS_FLAG_DESTROYED, oObject);
    DestroyObject(oObject, csm_AdjustDelay(fDelay, oArea));
}

object cs_CopyPC(location lLoc, int bPCLocation=FALSE, int nPCNumber=0, string sTag="pccopy", int bDestroyOnCSEnd=TRUE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    object oPC = GetObjectArray(oArea, "cs_oPC", nPCNumber);
    if(!GetIsObjectValid(oPC)) return OBJECT_INVALID;

    if(bPCLocation) lLoc = GetLocation(oPC);

    object oCopy = CopyObject(oPC, lLoc, OBJECT_INVALID, sTag);
    if(bDestroyOnCSEnd) csm_SetFlag(CS_FLAG_DESTROYED, oCopy);
    ChangeToStandardFaction(oCopy, STANDARD_FACTION_COMMONER);
    csm_AddActor(oCopy, oArea);

    if(csm_GetOption(CS_OPTION_REMOVE_PC_POLYMORPH))
    {
        effect e = GetFirstEffect(oCopy);
        while(GetIsEffectValid(e))
        {
            if(GetEffectType(e)==EFFECT_TYPE_POLYMORPH)
            {
                DelayCommand(0.01, RemoveEffect(oCopy, e));
            }
            e = GetNextEffect(oCopy);
        }
    }

    return oCopy;
}

// nPCNumber: The number of the PC to be copied. Goes in the order they joined the
//            cutscene starting at 0. An invalid number will default back to 0.
//            Use cs_GetPCNumber() to get a PC's number by their name.
// Note: Only 1 PC in a cutscene may be visible at a time. If a PC is already visible,
//       this function will do nothing.
//       If you wish other PC's to be visible, use cs_CopyPC() for them.
void cs_RenderPCVisible(float fDelay, int nPCNumber=0, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_RenderPCVisible(nPCNumber, nCutNumber, oArea));
}

// If cs_RenderPCVisible was used to make a PC visible for the cutscene, this function will
// make them invisible again. Since only one PC may be visible, there is no need to specify
// which PC.
void cs_RenderPCInvisible(float fDelay, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_RenderPCInvisible(nCutNumber, oArea));
}

// Returns the number of a PC for a cutscene
// sPCName: The name of the PC.
// Returns -1 if no PC by that name is in that area's cutscene.
int cs_GetPCNumber(object oPC=OBJECT_INVALID, string sPCName="", object oArea=OBJECT_SELF, int nCutNumber=-1)
//int cs_GetPCNumber(string sPCName, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    int nNumPC = GetLocalInt(oArea, "cs_nNumPC");
    int x;
    object oPCCheck;
    if(GetIsObjectValid(oPC))
    {
        for(x=0;x<nNumPC;x++)
        {
            oPCCheck = GetObjectArray(oArea, "cs_oPC", x);
            if(oPCCheck == oPC) return x;
        }
    }
    else
    {
        for(x=0;x<nNumPC;x++)
        {
            oPCCheck = GetObjectArray(oArea, "cs_oPC", x);
            if(GetName(oPCCheck) == sPCName) return x;
        }
    }
    return -1;
}

// Delay values for cutscene commands can either be a total value or an incremented value.
// This changes which type the delay will be on a per-area basis.
// Use cs_ChangeDefaultDelayType() to change the default type globally.
// cs_ChangeDelayType() will always override the global default, for the specified area.
// NOTE: Intended for use at the very start of a cutscene script.
// nDelayType: CS_DELAY_TYPE_TOTAL - Start of the cutscene is 0.0 seconds. Delay parameters
//                                   for cutscene functions will be total time passed since
//                                   the start of the cutscene.
//             CS_DELAY_TYPE_INCREMENTED - Delay parameters for cutscene functions will be
//                                         time passed since the last cutscene function (or
//                                         start of the cutscene, if it is the first delayed
//                                         function of the cutscene.
void cs_SetDelayType(int nDelayType, object oArea=OBJECT_SELF)
{
    SetLocalInt(oArea, "cs_DelayType", nDelayType);
}

// Delay values for cutscene commands can either be a total value or an incremented value.
// This changes which type the delay will be, as a global default.
// Use cs_ChangeDelayType() to change the delay type for a specific cutscene.
// cs_ChangeDelayType() will always override the global default, for the specified area.
// NOTE: Not intended for use in cutscene scripts (though acceptable at the very start
//       of a cutscenes script).
// nDelayType: CS_DELAY_TYPE_TOTAL - Start of the cutscene is 0.0 seconds. Delay parameters
//                                   for cutscene functions will be total time passed since
//                                   the start of the cutscene.
//             CS_DELAY_TYPE_INCREMENTED - Delay parameters for cutscene functions will be
//                                         time passed since the last cutscene function (or
//                                         start of the cutscene, if it is the first delayed
//                                         function of the cutscene.
void cs_SetDefaultDelayType(int nDelayType)
{
    switch(nDelayType)
    {
        case CS_DELAY_TYPE_INCREMENTED:
            SetLocalInt(GetModule(), "cs_g_DelayType", CS_DELAY_TYPE_INCREMENTED);
            break;
        case CS_DELAY_TYPE_TOTAL:
            SetLocalInt(GetModule(), "cs_g_DelayType", CS_DELAY_TYPE_TOTAL);
            break;
        default:
            SetLocalInt(GetModule(), "cs_g_DelayType", CS_DELAY_TYPE_UNDEFINED);
    }
}

void cs_ResetDelay(float fDelay=-1.0, float fResetValueTo=0.0, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber = -1) nCutNumber = csm_GetLastCutsceneNumber(oArea);
    if(fDelay<0.0) csll_ResetDelay(fResetValueTo, nCutNumber, oArea);
    else DelayCommand(csm_AdjustDelay(fDelay, oArea), csll_ResetDelay(fResetValueTo, nCutNumber, oArea));
}

float cs_GetDelay(object oArea=OBJECT_SELF)
{
    return GetLocalFloat(oArea, "cs_fTotalDelay");
}

// Intended for use in end-cutscene scripts, as specified in cs_StartCutscene.
// If the cutscene was aborted, this will return TRUE, otherwise FALSE (ended normally).
// nCutNumber: Defaults to -1, which means the last cutscene that was run in the area.
int cs_GetWasCutsceneAborted(object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(nCutNumber == -1) nCutNumber = csm_GetLastCutsceneNumber();
    return GetLocalInt(oArea, "cs_bCutsceneAborted"+IntToString(nCutNumber));

}

// Fades the screen for all players in the area. Intended for use before the cutscene proper
// starts. During the cutscene you should use cs_CameraDoFade().
// nFadeType: CS_FADE_TYPE_NONE - immediately removes any fade/black screen.
//            CS_FADE_TYPE_BLACK - immediately sets a black screen.
//            CS_FADE_TYPE_IN - fades in at given speed.
//            CS_FADE_TYPE_OUT - fades out at given speed.
// fSpeed: FADE_SPEED_* constants. Ignored if using CS_FADE_TYPE_NONE or _BLACK.
// oArea: If OBJECT_SELF is not an area, it will automatically try GetArea(OBJECT_SELF)
void cs_PreCutsceneFade(int nFadeType=CS_FADE_TYPE_TO_BLACK, float fSpeed=FADE_SPEED_MEDIUM, object oArea=OBJECT_SELF)
{
    object oGetArea = GetArea(OBJECT_SELF);
    if(oArea!=oGetArea) oArea=oGetArea;

    if( (nFadeType==CS_FADE_TYPE_NONE) || (nFadeType==CS_FADE_TYPE_FROM_BLACK) )
        SetLocalInt(oArea, "cs_bFaded", FALSE);
    else SetLocalInt(oArea, "cs_bFaded", TRUE);

    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        if(GetArea(oPC)==oArea && !GetIsDM(oPC))
        {
            // Should we force PC's to unpossess their familiars?
            if(csm_GetOption(CS_OPTION_REMOVE_PC_FAMILIAR_POSSESSION)==1)
            {
                // This does nothing if the PC isn't possessing a familiar, so no
                // further checks are needed.
                UnpossessFamiliar(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC));
            }
            switch(nFadeType)
            {
                case CS_FADE_TYPE_NONE:
                    StopFade(oPC);
                    break;
                case CS_FADE_TYPE_BLACK:
                    BlackScreen(oPC);
                    break;
                case CS_FADE_TYPE_FROM_BLACK:
                    FadeFromBlack(oPC, fSpeed);
                    break;
                case CS_FADE_TYPE_TO_BLACK:
                    FadeToBlack(oPC, fSpeed);
                    break;
            }
        }
        oPC = GetNextPC();
    }
}

object cs_GetPCObject(int nPCNumber=0, object oArea=OBJECT_SELF)
{
    if(nPCNumber > GetLocalInt(oArea, "cs_nNumPC")) return OBJECT_INVALID;
    return GetObjectArray(oArea, "cs_oPC", nPCNumber);
}

int cs_GetCutsceneStarted(int nCutNumber=1, object oArea=OBJECT_SELF)
{
    return GetLocalInt(oArea, "cs_bCutsceneStarted"+IntToString(nCutNumber));
}

int cs_GetCutsceneEnded(int nCutNumber=1, object oArea=OBJECT_SELF)
{
    return GetLocalInt(oArea, "cs_bCutsceneEnded"+IntToString(nCutNumber));
}

int cs_GetCutsceneRunning(object oArea=OBJECT_SELF)
{
    int nCutNumber = GetLocalInt(oArea, "cs_nCutNumber");
    string sCutNumber = IntToString(nCutNumber);
    int nStarted = GetLocalInt(oArea, "cs_bCutsceneStarted"+sCutNumber);
    int nEnded = GetLocalInt(oArea, "cs_bCutsceneEnded"+sCutNumber);
    if(nStarted && !nEnded) return nCutNumber;
    return FALSE;
}

float cs_GetCameraWaypointFacing(int nCameraNumber, object oArea=OBJECT_SELF)
{
    object oCameraPosition = GetObjectByTagInArea(CS_CAMERA_TAG_POSITION+IntToString(nCameraNumber), oArea);
    object oCameraFocus = GetObjectByTagInArea(CS_CAMERA_TAG_FOCUS+IntToString(nCameraNumber), oArea);
    float fFacing = GetFacingBetweenObjects(oCameraPosition, oCameraFocus);
    return fFacing;
}

float cs_GetCameraWaypointHeight(int nCameraNumber, object oArea=OBJECT_SELF)
{
    object oCameraPosition = GetObjectByTagInArea(CS_CAMERA_TAG_POSITION+IntToString(nCameraNumber), oArea);
    float fHeight = GetLocalFloat(oCameraPosition, "fHeight");
    return fHeight;
}

float cs_GetCameraWaypointPitch(int nCameraNumber, object oArea=OBJECT_SELF)
{
    object oCameraPosition = GetObjectByTagInArea(CS_CAMERA_TAG_POSITION+IntToString(nCameraNumber), oArea);
    float fPitch = GetLocalFloat(oCameraPosition, "fPitch");
    return fPitch;
}

float cs_GetCameraWaypointDistance(int nCameraNumber, object oArea=OBJECT_SELF)
{
    object oCameraPosition = GetObjectByTagInArea(CS_CAMERA_TAG_POSITION+IntToString(nCameraNumber), oArea);
    float fDistance = GetLocalFloat(oCameraPosition, "fDistance");
    return fDistance;
}

//functions to add
/*
SetPlaceableIllumination

ActionEquipItem
ActionUnequipItem

ActionForceFollowObject
ActionForceMoveToLocation
ActionForceMoveToObject

ActionPickUpItem
ActionPutDownItem

ActionSit

ActionWait

CreateObject

MusicBackgroundChangeDay
MusicBackgroundChangeNight
MusicBackgroundPlay
MusicBackgroundStop
MusicBattleChange
MusicBattlePlay
MusicBattleStop

AmbientSoundChangeDay
AmbientSoundChangeNight
AmbientSoundPlay
AmbientSoundSetDayVolume
AmbientSoundSetNightVolume
AmbientSoundStop

SoundObjectPlay
SoundObjectSetPosition
SoundObjectSetVolume
SoundObjectStop

SetCreatureAppearanceType

SetWeather

SignalEvent
*/
