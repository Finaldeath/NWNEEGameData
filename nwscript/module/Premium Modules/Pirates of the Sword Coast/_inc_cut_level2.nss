//::///////////////////////////////////////////////
//:: Low-level cutscene function include file
//:: _inc_cut_level2.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is the include file for the low-level
    cutscene functions. It should not be directly
    included, include "_inc_cutscene" instead.

    These functions are delayed by the high-level
    functions. When the low-level function is executed
    it first checks to see if the cutscene has been
    aborted. If not, it will carry out the action.

    Direct includes:
      - _inc_cut_misc: Miscellaneous cutscene functions
    Indirect includes:
      - _inc_generic: Generic functions
      - _inc_array: Array functions
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Dec. 9, 2003
//:://////////////////////////////////////////////
//:: Modified By: Keith Hayward
//:: Modified On: May 18, 2005
//:://////////////////////////////////////////////
//:: Added an effect remove check to prevent PCs
//:: Forced into cutscene while crafting from
//:: breaking.
//:://////////////////////////////////////////////

#include "_inc_cut_misc"

// low-level cutscene function, do not use
void csll_ActionJumpToLocation(object oCreature, location lLoc, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_JumpToLocation(object oCreature, location lLoc, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ActionMoveToLocation(object oCreature, location lLoc, int bRun, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ActionMoveToObject(object oCreature, object oObject, int bRun, float fRange, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ClearAllActions(object oCreature, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ActionAttack(object oCreature, object oAttackee, int bPassive, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ActionCastFakeSpellAtLocation(object oCreature, int nSpell, location lTarget, int nProjectiltePathType, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ActionCastFakeSpellAtObject(object oCreature, int nSpell, object oTarget, int nProjectilePathType, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ActionCastSpellAtLocation(object oCreature, int nSpell, location lTargetLocation, int nMetaMagic, int bCheat, int nProjectilePathType, int bInstantSpell, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ActionCastSpellAtObject(object oCreature, int nSpell, object oTarget, int nMetaMagic, int bCheat, int nDomainLevel, int nProjectilePathType, int bInstantSpell, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ActionSpeakString(object oCreature, string sStringToSpeak, int nTalkVolume, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ActionSpeakStringByStrRef(object oCreature, int nStrRef, int nTalkVolume, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_SpeakString(object oCreature, string sStringToSpeak, int nTalkVolume, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_SpeakStringByStrRef(object oCreature, int nStrRef, int nTalkVolume, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_FloatingTextStringOnCreature(string sString, object oCreature, int bBroadcastToFactionOnly, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_FloatingTextStrRefOnCreature(int nStrRef, object oCreature, int bBroadcastToFactionOnly, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_SetFacing(object oCreature, float fDirection, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_SetFacingPoint(object oCreature, vector vTarget, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ActionSetFacing(object oCreature, float fDirection, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ActionSetFacingPoint(object oCreature, vector vTarget, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ActionCloseDoor(object oCreature, object oDoor, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ActionOpenDoor(object oCreature, object oDoor, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_SetLocked(object oTarget, int bLocked, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ApplyEffectAtLocation(int nDurationType, effect eEffect, location lLocation, float fDuration, int bDestroyOnCSEnd, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ApplyEffectToObject(int nDurationType, effect eEffect, object oTarget, float fDuration, int bDestroyOnCSEnd, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ApplyVFXToObject(int nDurationType, int nVisualEffectId, object oTarget, float fDuration, int nMissEffect, int bDestroyOnCSEnd, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_RemoveVFXFromObject(object oObject, int bAllVFX, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ActionPlayAnimation(object oObject, int nAnimation, float fSpeed, float fDuration, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_PlayAnimation(object oObject, int nAnimation, float fSpeed, float fDuration, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_RenderPCVisible(int nPCNumber, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_RenderPCInvisible(int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_PlaySound(object oObject, string sSoundName, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_PlaySoundByStrRef(object oObject, int nStrRef, int bRunAsAction, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_PlayVoiceChat(object oCreature, int nVoiceChatID, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_ActionStartConversation(object oObjectToInitiate, object oObjectToConverseWith, string sDialogResRef, int bPrivateConversation, int bPlayHello, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_FireConversationEvent(object oFireEventOn, object oObjectToTalkTo, string sResRef, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_UserDefinedEvent(object oObject, int nUserDefinedEventNumber, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_SoundObjectPlay(object oSound, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_SoundObjectSetPosition(object oSound, vector vPosition, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_SoundObjectSetVolume(object oSound, int nVolume, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_SoundObjectStop(object oSound, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_AmbientSoundChangeDay(int nTrack, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_AmbientSoundChangeNight(int nTrack, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_AmbientSoundPlay(int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_AmbientSoundStop(int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_AmbientSoundSetDayVolume(int nVolume, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_AmbientSoundSetNightVolume(int nVolume, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_MusicBackgroundChangeDay(int nTrack, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_MusicBackgroundChangeNight(int nTrack, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_MusicBackgroundPlay(int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_MusicBackgroundStop(int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_MusicBattleChange(int nTrack, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_MusicBattlePlay(int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_MusicBattleStop(int nCutNumber, object oArea);


// low-level cutscene function, do not use
void csll_CameraJumpToLocation(location lLoc, int nCutNumber=1, object oArea=OBJECT_SELF);

// low-level cutscene function, do not use
void csll_CameraSetFacing(float fDirection, float fDistance = -1.0f, float fPitch = -1.0f, int nTransitionType=CAMERA_TRANSITION_TYPE_SNAP, int nCutNumber=1, object oArea=OBJECT_SELF);

// low-level cutscene function, do not use
void csll_CameraDoFade(int nFadeType, float fSpeed, int nCutNumber, object oArea);

// low-level cutscene function, do not use
void csll_CameraSetCameraMode(int nCameraMode, int nCutNumber, object oArea);

// low-level cutscene function, do not use
void csll_CameraActionMoveToLocation(location lLoc, int bRun=FALSE, int nCutNumber=1, object oArea=OBJECT_SELF);
// low-level cutscene function, do not use
void csll_CameraActionMoveToObject(object oMoveTo, int bRun=FALSE, float fRange=0.0f, int nCutNumber=1, object oArea=OBJECT_SELF);
// low-level cutscene function, do not use
void csll_CameraSetMovementRate(float fRate, int nCutNumber=1, object oArea=OBJECT_SELF);

// low-level cutscene function, do not use
void csll_CameraDayToNight(float fTransitionTime, int nCutNumber, object oArea);
// low-level cutscene function, do not use
void csll_CameraNightToDay(float fTransitionTime, int nCutNumber, object oArea);

// low-level cutscene function, do not use
void csll_EndCutscene(int bStopFade=TRUE, int bFadeFromBlack=FALSE, float fSpeed=FADE_SPEED_MEDIUM, int nCutNumber=1, object oArea=OBJECT_SELF, int bFromAbortFunction=FALSE);

// low-level cutscene function, do not use
void csll_ActorCleanUp(object oActor, int bFromAbortFunction);
// low-level cutscene function, do not use
void csll_ActorCleanUp_PC(object oActor, int bFromAbortFunction);
// low-level cutscene function, do not use
void csll_ActorCleanUp_NPC(object oActor, int bFromAbortFunction);
// low-level cutscene function, do not use
void csll_ActorCleanUp_Placeable(object oActor, int bFromAbortFunction);
// low-level cutscene function, do not use
void csll_ActorCleanUp_Door(object oActor, int bFromAbortFunction);
// low-level cutscene function, do not use
void csll_ActorCleanUp_Sound(object oActor, int bFromAbortFunction);
// low-level cutscene function, do not use
void csll_AreaCleanUp(object oArea);
// low-level cutscene function, do not use
void csll_ResetDelay(float fResetValueTo, int nCutNumber, object oArea);

// low-level cutscene function, do not use
int csll_AddPCToCutscene(object oPC, object oArea=OBJECT_SELF);

// low-level cutscene function, do not use
void csll_ApplyPCCutsceneEffects(object oPC, object oArea=OBJECT_SELF, float fDelay=0.0);

// low-level cutscene function, do not use
void csll_ApplyAssociateCutsceneEffects(int nAssociateType, object oPC, object oArea=OBJECT_SELF, float fDelay=0.0);

// low-level cutscene function, do not use
void csll_AreaOnEnter(object oEnterer);

//================================================

void csll_ActionJumpToLocation(object oCreature, location lLoc, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, ActionJumpToLocation(lLoc));
}

void csll_JumpToLocation(object oCreature, location lLoc, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, JumpToLocation(lLoc));
}

void csll_ActionMoveToLocation(object oCreature, location lLoc, int bRun, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, ActionMoveToLocation(lLoc, bRun));
}

void csll_ActionMoveToObject(object oCreature, object oObject, int bRun, float fRange, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, ActionMoveToObject(oObject, bRun, fRange));
}

void csll_ClearAllActions(object oCreature, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    //ClearAllActionsBetter(oCreature);
    AssignCommand(oCreature, ClearAllActions(TRUE));
}

void csll_ActionAttack(object oCreature, object oAttackee, int bPassive, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, ActionAttack(oAttackee, bPassive));
}

void csll_ActionCastFakeSpellAtLocation(object oCreature, int nSpell, location lTarget, int nProjectilePathType, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, ActionCastFakeSpellAtLocation(nSpell, lTarget, nProjectilePathType));
}

void csll_ActionCastFakeSpellAtObject(object oCreature, int nSpell, object oTarget, int nProjectilePathType, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, ActionCastFakeSpellAtObject(nSpell, oTarget, nProjectilePathType));
}

void csll_ActionCastSpellAtLocation(object oCreature, int nSpell, location lTargetLocation, int nMetaMagic, int bCheat, int nProjectilePathType, int bInstantSpell, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, ActionCastSpellAtLocation(nSpell, lTargetLocation, nMetaMagic, bCheat, nProjectilePathType, bInstantSpell));
}

void csll_ActionCastSpellAtObject(object oCreature, int nSpell, object oTarget, int nMetaMagic, int bCheat, int nDomainLevel, int nProjectilePathType, int bInstantSpell, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, ActionCastSpellAtObject(nSpell, oTarget, nMetaMagic, bCheat, nDomainLevel, nProjectilePathType, bInstantSpell));
}

void csll_ActionSpeakString(object oCreature, string sStringToSpeak, int nTalkVolume, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, ActionSpeakString(sStringToSpeak, nTalkVolume));
}

void csll_ActionSpeakStringByStrRef(object oCreature, int nStrRef, int nTalkVolume, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, ActionSpeakStringByStrRef(nStrRef, nTalkVolume));
}

void csll_SpeakString(object oCreature, string sStringToSpeak, int nTalkVolume, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, SpeakString(sStringToSpeak, nTalkVolume));
}

void csll_SpeakStringByStrRef(object oCreature, int nStrRef, int nTalkVolume, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, SpeakStringByStrRef(nStrRef, nTalkVolume));
}

void csll_FloatingTextStringOnCreature(string sString, object oCreature, int bBroadcastToFactionOnly, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    FloatingTextStringOnCreature(sString, oCreature, bBroadcastToFactionOnly);
}

void csll_FloatingTextStrRefOnCreature(int nStrRef, object oCreature, int bBroadcastToFactionOnly, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    FloatingTextStrRefOnCreature(nStrRef, oCreature, bBroadcastToFactionOnly);
}

void csll_SetFacing(object oCreature, float fDirection, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, SetFacing(fDirection));
}

void csll_SetFacingPoint(object oCreature, vector vTarget, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, ActionDoCommand(SetFacingPoint(vTarget)));
}

void csll_ActionSetFacing(object oCreature, float fDirection, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, ActionDoCommand(SetFacing(fDirection)));
}

void csll_ActionSetFacingPoint(object oCreature, vector vTarget, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, ActionDoCommand(SetFacingPoint(vTarget)));
}

void csll_ActionCloseDoor(object oCreature, object oDoor, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, ActionCloseDoor(oDoor));
}

void csll_ActionOpenDoor(object oCreature, object oDoor, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oCreature, ActionOpenDoor(oDoor));
}

void csll_SetLocked(object oTarget, int bLocked, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    SetLocked(oTarget, bLocked);
}

void csll_ApplyEffectAtLocation(int nDurationType, effect eEffect, location lLocation, float fDuration, int bDestroyOnCSEnd, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    // hackity-hack-hack-hack - create invisbile object at location to apply effect to
    vector vTemp = GetPositionFromLocation(lLocation);
    vTemp.z -= 0.25; // shift it down
    location lFinal = Location(oArea, vTemp, 0.0);
    object oInvis = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lFinal, FALSE, "cs_EffectLocation");

    if(bDestroyOnCSEnd)
    {
        csm_AddActor(oInvis, oArea);
        csm_SetFlag(CS_FLAG_DESTROYED, oInvis);
    }
    ApplyEffectToObject(nDurationType, eEffect, oInvis, fDuration);

    if(nDurationType==DURATION_TYPE_TEMPORARY) DestroyObject(oInvis, fDuration+10.0);
    else if(nDurationType==DURATION_TYPE_INSTANT) DestroyObject(oInvis, 60.0);
}

void csll_ApplyEffectToObject(int nDurationType, effect eEffect, object oTarget, float fDuration, int bDestroyOnCSEnd, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    if(bDestroyOnCSEnd)
    {
        csm_SetFlag(CS_FLAG_EFFECT, oTarget);
    }
    ApplyEffectToObject(nDurationType, eEffect, oTarget, fDuration);
}

void csll_ApplyVFXToObject(int nDurationType, int nVisualEffectId, object oTarget, float fDuration, int nMissEffect, int bDestroyOnCSEnd, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    if(bDestroyOnCSEnd)
    {
        csm_SetFlag(CS_FLAG_VFX, oTarget);
        // geez this is so hacky...
        object oEffectObject = GetLocalObject(oArea, "cs_oEffectObject");
        SetLocalInt(oEffectObject, "nDurationType", nDurationType);
        SetLocalObject(oEffectObject, "oTarget", oTarget);
        SetLocalFloat(oEffectObject, "fDuration", fDuration);
        SetLocalInt(oEffectObject, "nVisualEffectId", nVisualEffectId);
        SetLocalInt(oEffectObject, "nMissEffect", nMissEffect);
        ExecuteScript("_cs_applyvfx", oEffectObject);
    }
    else ApplyEffectToObject(nDurationType, EffectVisualEffect(nVisualEffectId, nMissEffect), oTarget, fDuration);
}

void csll_RemoveVFXFromObject(object oObject, int bAllVFX, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    if(bAllVFX)
    {
        csm_RemoveEffects(oObject, TRUE);
    }
    else
    {
        csm_RemoveFlaggedEffects(oObject);
    }
}

void csll_ActionPlayAnimation(object oObject, int nAnimation, float fSpeed, float fDuration, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    if(GetLocalInt(OBJECT_SELF, "cs_nFlags") & CS_FLAG_ANIMATION) csm_ClearFlag(CS_FLAG_ANIMATION, oObject);
    AssignCommand(oObject, ActionPlayAnimation(nAnimation, fSpeed, fDuration));
}

void csll_PlayAnimation(object oObject, int nAnimation, float fSpeed, float fDuration, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    if(GetLocalInt(OBJECT_SELF, "cs_nFlags") & CS_FLAG_ANIMATION) csm_ClearFlag(CS_FLAG_ANIMATION, oObject);
    AssignCommand(oObject, PlayAnimation(nAnimation, fSpeed, fDuration));
}

void csll_RenderPCVisible(int nPCNumber, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;

    if(GetIsObjectValid(GetLocalObject(oArea, "cs_oVisiblePC"))) return;

    object oPC = GetObjectArray(oArea, "cs_oPC", nPCNumber);
    if(!GetIsObjectValid(oPC)) oPC = GetObjectArray(oArea, "cs_oPC", 0);

    effect e = GetFirstEffect(oPC);
    while(GetIsEffectValid(e))
    {
        if(GetEffectType(e)==EFFECT_TYPE_CUTSCENEGHOST ||
           (GetEffectType(e)==EFFECT_TYPE_VISUALEFFECT &&
            GetTag(GetEffectCreator(e))=="cs_EffectObject"))
        {
            RemoveEffect(oPC, e);
        }
        e = GetNextEffect(oPC);
    }
    SetLocalObject(oArea, "cs_oVisiblePC", oPC);
}

void csll_RenderPCInvisible(int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;

    object oPC = GetLocalObject(oArea, "cs_oVisiblePC");
    if(GetIsObjectValid(oPC))
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oPC);
        SetLocalObject(oArea, "cs_oVisiblePC", OBJECT_INVALID);
    }
}

void csll_PlaySound(object oObject, string sSoundName, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oObject, PlaySound(sSoundName));
}

void csll_PlaySoundByStrRef(object oObject, int nStrRef, int bRunAsAction, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oObject, PlaySoundByStrRef(nStrRef, bRunAsAction));
}

void csll_PlayVoiceChat(object oCreature, int nVoiceChatID, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    PlayVoiceChat(nVoiceChatID, oCreature);
}

void csll_ActionStartConversation(object oObjectToInitiate, object oObjectToConverseWith, string sDialogResRef, int bPrivateConversation, int bPlayHello, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AssignCommand(oObjectToInitiate, ActionStartConversation(oObjectToConverseWith, sDialogResRef, bPrivateConversation, bPlayHello));
}

void csll_FireConversationEvent(object oFireEventOn, object oObjectToTalkTo, string sResRef, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    SetLocalObject(oFireEventOn, "cs_oObjectToTalkTo", oObjectToTalkTo);
    SetLocalString(oFireEventOn, "cs_sResRef", sResRef);
    SetLocalInt(oFireEventOn, "cs_bTriggeredByCutscene", TRUE);

    SignalEvent(oFireEventOn, EventConversation());
}

void csll_UserDefinedEvent(object oObject, int nUserDefinedEventNumber, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    if(GetLocalInt(OBJECT_SELF, "cs_nFlags") & CS_FLAG_USER_DEFINED_EVENT) csm_ClearFlag(CS_FLAG_USER_DEFINED_EVENT, oObject);
    SignalEvent(oObject, EventUserDefined(nUserDefinedEventNumber));
}

void csll_SoundObjectPlay(object oSound, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    if( (GetLocalInt(OBJECT_SELF, "cs_nFlags") & CS_FLAG_SOUND) &&
        GetLocalInt(OBJECT_SELF, "cs_nPlay") == CS_SOUND_PLAY ) csm_ClearFlag(CS_FLAG_SOUND, oSound);
    SoundObjectPlay(oSound);
}
void csll_SoundObjectSetPosition(object oSound, vector vPosition, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    SoundObjectSetPosition(oSound, vPosition);
}
void csll_SoundObjectSetVolume(object oSound, int nVolume, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    SoundObjectSetVolume(oSound, nVolume);
}
void csll_SoundObjectStop(object oSound, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    SoundObjectStop(oSound);
}
void csll_AmbientSoundChangeDay(int nTrack, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AmbientSoundChangeDay(oArea, nTrack);
}
void csll_AmbientSoundChangeNight(int nTrack, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AmbientSoundChangeNight(oArea, nTrack);
}
void csll_AmbientSoundPlay(int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AmbientSoundPlay(oArea);
}
void csll_AmbientSoundStop(int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AmbientSoundStop(oArea);
}
void csll_AmbientSoundSetDayVolume(int nVolume, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AmbientSoundSetDayVolume(oArea, nVolume);
}
void csll_AmbientSoundSetNightVolume(int nVolume, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    AmbientSoundSetNightVolume(oArea, nVolume);
}
void csll_MusicBackgroundChangeDay(int nTrack, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    MusicBackgroundChangeDay(oArea, nTrack);
}
void csll_MusicBackgroundChangeNight(int nTrack, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    MusicBackgroundChangeNight(oArea, nTrack);
}
void csll_MusicBackgroundPlay(int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    MusicBackgroundPlay(oArea);
}
void csll_MusicBackgroundStop(int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    MusicBackgroundStop(oArea);
}
void csll_MusicBattleChange(int nTrack, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    MusicBattleChange(oArea, nTrack);
}
void csll_MusicBattlePlay(int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    MusicBattlePlay(oArea);
}
void csll_MusicBattleStop(int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    MusicBattleStop(oArea);
}


void csll_CameraJumpToLocation(location lLoc, int nCutNumber=1, object oArea=OBJECT_SELF)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    SetLocalLocation(oArea, "cs_lCameraLocation", lLoc);
    int nNumPC = GetLocalInt(oArea, "cs_nNumPC");
    int x;
    object oPC;
    for(x=0;x<nNumPC;x++)
    {
        oPC = GetObjectArray(oArea, "cs_oPC", x);
        SetCommandable(TRUE, oPC);
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, JumpToLocation(lLoc));
    }
}

void csll_CameraActionJumpToLocation(location lLoc, int nCutNumber=1, object oArea=OBJECT_SELF)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    SetLocalLocation(oArea, "cs_lCameraLocation", lLoc);
    int nNumPC = GetLocalInt(oArea, "cs_nNumPC");
    int x;
    object oPC;
    for(x=0;x<nNumPC;x++)
    {
        oPC = GetObjectArray(oArea, "cs_oPC", x);
        SetCommandable(TRUE, oPC);
        AssignCommand(oPC, ActionJumpToLocation(lLoc));
    }
}

void csll_CameraSetFacing(float fDirection, float fDistance = -1.0f, float fPitch = -1.0f, int nTransitionType=CAMERA_TRANSITION_TYPE_SNAP, int nCutNumber=1, object oArea=OBJECT_SELF)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    SetLocalFloat(oArea, "cs_fCameraDirection", fDirection);
    SetLocalFloat(oArea, "cs_fCameraDistance", fDistance);
    SetLocalFloat(oArea, "cs_fCameraPitch", fPitch);
    int nNumPC = GetLocalInt(oArea, "cs_nNumPC");
    int x;
    object oPC;
    for(x=0;x<nNumPC;x++)
    {
        oPC = GetObjectArray(oArea, "cs_oPC", x);
        SetCommandable(TRUE, oPC);
        AssignCommand(oPC, SetCameraFacing(fDirection, fDistance, fPitch, nTransitionType));
    }
}

void csll_CameraSetHeight(float fHeight=0.0f, int nCutNumber=1, object oArea=OBJECT_SELF)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    SetLocalFloat(oArea, "cs_fCameraHeight", fHeight);
    int nNumPC = GetLocalInt(oArea, "cs_nNumPC");
    int x;
    object oPC;
    for(x=0;x<nNumPC;x++)
    {
        oPC = GetObjectArray(oArea, "cs_oPC", x);
        SetCameraHeight(oPC, fHeight);
    }
}

void csll_CameraDoFade(int nFadeType, float fSpeed, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;

    if( (nFadeType==CS_FADE_TYPE_NONE) || (nFadeType==CS_FADE_TYPE_FROM_BLACK) )
        SetLocalInt(oArea, "cs_bFaded", FALSE);
    else SetLocalInt(oArea, "cs_bFaded", TRUE);

    int nNumPC = GetLocalInt(oArea, "cs_nNumPC");
    int x;
    object oPC;
    for(x=0;x<nNumPC;x++)
    {
        oPC = GetObjectArray(oArea, "cs_oPC", x);
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
}

void csll_CameraSetCameraMode(int nCameraMode, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    SetLocalInt(oArea, "cs_nCameraMode", nCameraMode);
    int nNumPC = GetLocalInt(oArea, "cs_nNumPC");
    int x;
    object oPC;
    for(x=0;x<nNumPC;x++)
    {
        oPC = GetObjectArray(oArea, "cs_oPC", x);
        SetCameraMode(oPC, nCameraMode);
    }
}

void csll_CameraActionMoveToLocation(location lLoc, int bRun=FALSE, int nCutNumber=1, object oArea=OBJECT_SELF)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    SetLocalLocation(oArea, "cs_lCameraLocation", lLoc);
    int nNumPC = GetLocalInt(oArea, "cs_nNumPC");
    int x;
    object oPC;
    for(x=0;x<nNumPC;x++)
    {
        oPC = GetObjectArray(oArea, "cs_oPC", x);
        SetCommandable(TRUE, oPC);
        AssignCommand(oPC, ActionMoveToLocation(lLoc, bRun));
    }
}

void csll_CameraActionMoveToObject(object oMoveTo, int bRun=FALSE, float fRange=0.0f, int nCutNumber=1, object oArea=OBJECT_SELF)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    SetLocalLocation(oArea, "cs_lCameraLocation", GetLocation(oMoveTo));
    int nNumPC = GetLocalInt(oArea, "cs_nNumPC");
    int x;
    object oPC;
    for(x=0;x<nNumPC;x++)
    {
        oPC = GetObjectArray(oArea, "cs_oPC", x);
        SetCommandable(TRUE, oPC);
        AssignCommand(oPC, ActionMoveToObject(oMoveTo, bRun, fRange));
    }
}

void csll_CameraSetMovementRate(float fRate, int nCutNumber=1, object oArea=OBJECT_SELF)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    SetLocalFloat(oArea, "cs_fRate", fRate);
    int nNumPC = GetLocalInt(oArea, "cs_nNumPC");
    int x;
    object oPC;
    for(x=0;x<nNumPC;x++)
    {
        oPC = GetObjectArray(oArea, "cs_oPC", x);
        SetCutsceneCameraMoveRate(oPC, fRate);
    }
}

void csll_CameraDayToNight(float fTransitionTime, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    SetLocalInt(oArea, "cs_nDayNight", CS_DAYNIGHT_NIGHT);
    int nNumPC = GetLocalInt(oArea, "cs_nNumPC");
    int x;
    object oPC;
    for(x=0;x<nNumPC;x++)
    {
        oPC = GetObjectArray(oArea, "cs_oPC", x);
        DayToNight(oPC, fTransitionTime);
    }
}

void csll_CameraNightToDay(float fTransitionTime, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    SetLocalInt(oArea, "cs_nDayNight", CS_DAYNIGHT_DAY);
    int nNumPC = GetLocalInt(oArea, "cs_nNumPC");
    int x;
    object oPC;
    for(x=0;x<nNumPC;x++)
    {
        oPC = GetObjectArray(oArea, "cs_oPC", x);
        NightToDay(oPC, fTransitionTime);
    }
}

void csll_EndCutscene(int bStopFade=TRUE, int bFadeFromBlack=FALSE, float fSpeed=FADE_SPEED_MEDIUM, int nCutNumber=1, object oArea=OBJECT_SELF, int bFromAbortFunction=FALSE)
{
    if(csm_CutsceneAborted(nCutNumber, oArea) && bFromAbortFunction==FALSE) return;

    // actor clean up
    int nActorNum = GetLocalInt(oArea, "cs_nActorNum");
    int nActor;
    object oActor;
    for(nActor=0; nActor < nActorNum; nActor++)
    {
        oActor = GetObjectArray(oArea, "cs_oActor", nActor);
        csll_ActorCleanUp(oActor, bFromAbortFunction);
    }
    // so far no reason to call the area clean up if cutscene ended normally
    if(bFromAbortFunction) csll_AreaCleanUp(oArea);

    // following line should be removed, but some other scripting is relying on it
    SetLocalInt(oArea, "cs_bCutsceneStarted", FALSE);
    SetLocalInt(oArea, "cs_bCutsceneEnded"+IntToString(nCutNumber), TRUE);

    int nNumPC = GetLocalInt(oArea, "cs_nNumPC");
    int x;
    object oPC;
    for(x=0;x<nNumPC;x++)
    {
        oPC = GetObjectArray(oArea, "cs_oPC", x);
        if(bStopFade) StopFade(oPC);
        else if(bFadeFromBlack) FadeFromBlack(oPC, fSpeed);
        SetCameraHeight(oPC, 0.0);
        SetCutsceneMode(oPC, FALSE);
        effect e = GetFirstEffect(oPC);
        while(GetIsEffectValid(e))
        {
            if(GetTag(GetEffectCreator(e))=="cs_EffectObject" ||
               GetEffectType(e)==EFFECT_TYPE_CUTSCENEGHOST) RemoveEffect(oPC, e);
            e = GetNextEffect(oPC);
        }
    }

    // Delete cutscene variables
    DeleteObjectArray(oArea, "cs_oPC", nNumPC);
    DeleteLocalInt(oArea, "cs_nNumPC");
    DeleteLocalInt(oArea, "cs_nCutNumber");
    DeleteLocalInt(oArea, "cs_bAbortable");
    DeleteLocalInt(oArea, "cs_bCutsceneStarted");
    DeleteLocalLocation(oArea, "cs_lCameraLocation");
    DeleteLocalFloat(oArea, "cs_fCameraDirection");
    DeleteLocalFloat(oArea, "cs_fCameraDistance");
    DeleteLocalFloat(oArea, "cs_fCameraPitch");
    DeleteLocalFloat(oArea, "cs_fCameraHeight");
    DeleteLocalFloat(oArea, "cs_fRate");
    DeleteLocalInt(oArea, "cs_bFaded");
    DeleteLocalFloat(oArea, "cs_fTotalDelay");

    DelayCommand(0.05, ExecuteScript(GetLocalString(oArea, "cs_sEndScript"), oArea));

    // Clean up effect object. Delayed a bit to make sure it can be referenced properly
    // in sEndScript, just in case that might be handy.
    object oEffectObject = GetLocalObject(oArea, "cs_oEffectObject");
    DestroyObject(oEffectObject, 5.0);
    DeleteLocalObject(oArea, "cs_oEffectObject");

    return;
}

void csll_ActorCleanUp(object oActor, int bFromAbortFunction)
{
    switch(GetObjectType(oActor))
    {
        case OBJECT_TYPE_CREATURE:
            if(GetIsPC(oActor)) csll_ActorCleanUp_PC(oActor, bFromAbortFunction);
            else csll_ActorCleanUp_NPC(oActor, bFromAbortFunction);
            break;
        case OBJECT_TYPE_PLACEABLE:
            csll_ActorCleanUp_Placeable(oActor, bFromAbortFunction);
            break;
        case OBJECT_TYPE_DOOR:
            csll_ActorCleanUp_Door(oActor, bFromAbortFunction);
            break;
        case OBJECT_TYPE_INVALID:
            // cuz sounds don't have an object type... doh...
            csll_ActorCleanUp_Sound(oActor, bFromAbortFunction);
    }
    DeleteLocalInt(oActor, "cs_bIsActor");
    DeleteLocalInt(oActor, "cs_nFlags");
}

void csll_ActorCleanUp_PC(object oActor, int bFromAbortFunction)
{
    // Clean up when aborted
    if(bFromAbortFunction)
    {
        AssignCommand(oActor, ClearAllActions(TRUE));
        if(csm_GetOption(CS_OPTION_RESTORE_PC_LOCATION, GetArea(oActor))==1)
        {
            DelayCommand(0.01, RestorePCLocations(0, oActor, 1.0));
        }
        else
        {
            AssignCommand(oActor, JumpToLocation(GetLocalLocation(GetArea(oActor), "cs_e_lCameraLocation")));
        }
        int nDayToNight = GetLocalInt(GetArea(oActor), "cs_e_nDayNight");
        if(nDayToNight==CS_DAYNIGHT_DAY) NightToDay(oActor);
        else if(nDayToNight==CS_DAYNIGHT_NIGHT) DayToNight(oActor);
    }
    // Clean up when ending normally
    else
    {
        if(csm_GetOption(CS_OPTION_RESTORE_PC_LOCATION, GetArea(oActor))==1)
        {
            DelayCommand(0.01, RestorePCLocations(0, oActor, 1.0));
        }
    }
}

void csll_ActorCleanUp_NPC(object oActor, int bFromAbortFunction)
{
    int nFlags = GetLocalInt(oActor, "cs_nFlags");
    // Clean up when aborted
    if(bFromAbortFunction)
    {
        if(nFlags & CS_FLAG_DESTROYED)
        {
            // we make the actor invisible before destorying them, otherwise
            // the player may seem them fade out, which is silly
            effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oActor);
            DestroyObject(oActor);
        }
        else
        {
            if(nFlags & CS_FLAG_POSITION)
                AssignCommand(oActor, JumpToLocation(GetLocalLocation(oActor, "cs_lEndLoc")));
            if(nFlags & CS_FLAG_FACING)
                AssignCommand(oActor, SetFacing(GetLocalFloat(oActor, "cs_fEndFacing")));
            if(nFlags & CS_FLAG_ANIMATION)
            {
                int nAnimation = GetLocalInt(oActor, "cs_Anim_nAnimation");
                float fSpeed = GetLocalFloat(oActor, "cs_Anim_fSpeed");
                float fDuration = GetLocalFloat(oActor, "cs_Anim_fDuration");
                AssignCommand(oActor, PlayAnimation(nAnimation, fSpeed, fDuration));
            }
            if(nFlags & CS_FLAG_EFFECT) csm_RemoveEffects(oActor);
            else
            {
                if(nFlags & CS_FLAG_VFX) csm_RemoveFlaggedEffects(oActor);
                if(nFlags & CS_FLAG_CUTSCENE_GHOST_EFFECT)
                {
                    effect e = GetFirstEffect(oActor);
                    while(GetIsEffectValid(e))
                    {
                        if(GetEffectType(e)==EFFECT_TYPE_CUTSCENEGHOST) DelayCommand(0.05, RemoveEffect(oActor, e));
                        e = GetNextEffect(oActor);
                    }
                }
            }
            if(nFlags & CS_FLAG_USER_DEFINED_EVENT)
            {
                SignalEvent(oActor, EventUserDefined(GetLocalInt(oActor, "cs_nUserDefinedEventNumber")));
            }
        }
    }
    // Clean up on normal end
    else
    {
        if(nFlags & CS_FLAG_DESTROYED)
        {
            // we make the actor invisible before destorying them, otherwise
            // the player may seem them fade out, which is silly
            effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oActor);
            DestroyObject(oActor);
        }
        else
        {
            if(nFlags & CS_FLAG_EFFECT) csm_RemoveEffects(oActor);
            else
            {
                if(nFlags & CS_FLAG_VFX) csm_RemoveFlaggedEffects(oActor);
                if(nFlags & CS_FLAG_CUTSCENE_GHOST_EFFECT)
                {
                    effect e = GetFirstEffect(oActor);
                    while(GetIsEffectValid(e))
                    {
                        if(GetEffectType(e)==EFFECT_TYPE_CUTSCENEGHOST) DelayCommand(0.05, RemoveEffect(oActor, e));
                        e = GetNextEffect(oActor);
                    }
                }
            }
        }
    }
}

void csll_ActorCleanUp_Placeable(object oActor, int bFromAbortFunction)
{
    int nFlags = GetLocalInt(oActor, "cs_nFlags");
    // Clean up when aborted
    if(bFromAbortFunction)
    {
        if(nFlags & CS_FLAG_DESTROYED) DestroyObject(oActor);
        else
        {
            if(nFlags & CS_FLAG_FACING)
                AssignCommand(oActor, SetFacing(GetLocalFloat(oActor, "cs_fEndFacing")));
            if(nFlags & CS_FLAG_OBJECT_LOCK_STATE)
            {
                if(GetLocalInt(oActor, "cs_nEndObjectLockState")==CS_OBJECT_LOCKED) SetLocked(oActor, TRUE);
                else SetLocked(oActor, FALSE);
            }
            if(nFlags & CS_FLAG_ANIMATION)
            {
                int nAnimation = GetLocalInt(oActor, "cs_Anim_nAnimation");
                float fSpeed = GetLocalFloat(oActor, "cs_Anim_fSpeed");
                float fDuration = GetLocalFloat(oActor, "cs_Anim_fDuration");
                AssignCommand(oActor, PlayAnimation(nAnimation, fSpeed, fDuration));
            }
            if(nFlags & CS_FLAG_USER_DEFINED_EVENT)
            {
                SignalEvent(oActor, EventUserDefined(GetLocalInt(oActor, "cs_nUserDefinedEventNumber")));
            }
            if(nFlags & CS_FLAG_EFFECT) csm_RemoveEffects(oActor);
            else if(nFlags & CS_FLAG_VFX) csm_RemoveFlaggedEffects(oActor);
        }
    }
    // Clean up on normal end
    else
    {
        if(nFlags & CS_FLAG_DESTROYED) DestroyObject(oActor);
        else
        {
            if(nFlags & CS_FLAG_EFFECT) csm_RemoveEffects(oActor);
            else if(nFlags & CS_FLAG_VFX) csm_RemoveFlaggedEffects(oActor);
        }
    }
}

void csll_ActorCleanUp_Door(object oActor, int bFromAbortFunction)
{
    int nFlags = GetLocalInt(oActor, "cs_nFlags");
    // Clean up when aborted
    if(bFromAbortFunction)
    {
        if(nFlags & CS_FLAG_DESTROYED) DestroyObject(oActor);
        else
        {
            if(nFlags & CS_FLAG_DOOR_OPEN_STATE)
            {
                if(GetLocalInt(oActor, "cs_nEndDoorOpenState")==CS_DOOR_OPEN) AssignCommand(oActor, ActionOpenDoor(oActor));
                else AssignCommand(oActor, ActionCloseDoor(oActor));
            }
            if(nFlags & CS_FLAG_OBJECT_LOCK_STATE)
            {
                if(GetLocalInt(oActor, "cs_nEndObjectLockState")==CS_OBJECT_LOCKED) SetLocked(oActor, TRUE);
                else SetLocked(oActor, FALSE);
            }
            if(nFlags & CS_FLAG_USER_DEFINED_EVENT)
            {
                SignalEvent(oActor, EventUserDefined(GetLocalInt(oActor, "cs_nUserDefinedEventNumber")));
            }
            if(nFlags & CS_FLAG_EFFECT) csm_RemoveEffects(oActor);
            else if(nFlags & CS_FLAG_VFX) csm_RemoveFlaggedEffects(oActor);
        }
    }
    // Clean up on normal end
    else
    {
        if(nFlags & CS_FLAG_DESTROYED) DestroyObject(oActor);
        else
        {
            if(nFlags & CS_FLAG_EFFECT) csm_RemoveEffects(oActor);
            else if(nFlags & CS_FLAG_VFX) csm_RemoveFlaggedEffects(oActor);
        }
    }
}

void csll_ActorCleanUp_Sound(object oActor, int bFromAbortFunction)
{
    int nFlags = GetLocalInt(oActor, "cs_nFlags");
    // Clean up when aborted
    if(bFromAbortFunction)
    {
        if(nFlags & CS_FLAG_DESTROYED) DestroyObject(oActor);
        else
        {
            if(nFlags & CS_FLAG_POSITION)
            {
                vector vPos;
                vPos.x = GetLocalFloat(oActor, "cs_fEndLocX");
                vPos.y = GetLocalFloat(oActor, "cs_fEndLocY");
                vPos.z = GetLocalFloat(oActor, "cs_fEndLocZ");
                SoundObjectSetPosition(oActor, vPos);
            }
            if(nFlags & CS_FLAG_SOUND)
            {
                switch(GetLocalInt(oActor, "cs_nPlay"))
                {
                    case CS_SOUND_PLAY:
                        SoundObjectPlay(oActor);
                        break;
                    case CS_SOUND_STOP:
                        SoundObjectStop(oActor);
                        break;
                }
            }
            if(nFlags & CS_FLAG_SOUND_VOLUME)
            {
                SoundObjectSetVolume(oActor, GetLocalInt(oActor, "cs_nSoundVolume"));
            }
        }
    }
    // Clean up on normal end
    else
    {
        if(nFlags & CS_FLAG_DESTROYED) DestroyObject(oActor);
    }
}

void csll_AreaCleanUp(object oArea)
{
    int nFlags = GetLocalInt(oArea, "cs_nFlags");
    if(nFlags & CS_AREA_FLAG_AMBIENT_SOUND_CHANGE_DAY)
    {
        AmbientSoundChangeDay(oArea, GetLocalInt(oArea, "cs_nAmbientSoundDay"));
    }
    if(nFlags & CS_AREA_FLAG_AMBIENT_SOUND_CHANGE_NIGHT)
    {
        AmbientSoundChangeNight(oArea, GetLocalInt(oArea, "cs_nAmbientSoundNight"));
    }
    if(nFlags & CS_AREA_FLAG_AMBIENT_SOUND_PLAY)
    {
        switch(GetLocalInt(oArea, "cs_nPlayAmbient"))
        {
            case CS_SOUND_PLAY:
                AmbientSoundPlay(oArea); break;
            case CS_SOUND_STOP:
                AmbientSoundStop(oArea); break;
        }
    }
    if(nFlags & CS_AREA_FLAG_AMBIENT_SOUND_VOLUME_DAY)
    {
        AmbientSoundSetDayVolume(oArea, GetLocalInt(oArea, "cs_nAmbientSoundVolumeDay"));
    }
    if(nFlags & CS_AREA_FLAG_AMBIENT_SOUND_VOLUME_NIGHT)
    {
        AmbientSoundSetNightVolume(oArea, GetLocalInt(oArea, "cs_nAmbientSoundVolumeNight"));
    }
    if(nFlags & CS_AREA_FLAG_MUSIC_BATTLE_CHANGE)
    {
        MusicBattleChange(oArea, GetLocalInt(oArea, "cs_nMusicBattleTrack"));
    }
    if(nFlags & CS_AREA_FLAG_MUSIC_BATTLE_PLAY)
    {
        switch(GetLocalInt(oArea, "cs_nPlayBattle"))
        {
            case CS_SOUND_PLAY:
                MusicBattlePlay(oArea); break;
            case CS_SOUND_STOP:
                MusicBattleStop(oArea); break;
        }
    }
    if(nFlags & CS_AREA_FLAG_MUSIC_CHANGE_DAY)
    {
        MusicBackgroundChangeDay(oArea, GetLocalInt(oArea, "cs_nMusicTrackDay"));
    }
    if(nFlags & CS_AREA_FLAG_MUSIC_CHANGE_NIGHT)
    {
        MusicBackgroundChangeNight(oArea, GetLocalInt(oArea, "cs_nMusicTrackNight"));
    }
    if(nFlags & CS_AREA_FLAG_MUSIC_PLAY)
    {
        switch(GetLocalInt(oArea, "cs_nPlayMusic"))
        {
            case CS_SOUND_PLAY:
                MusicBackgroundPlay(oArea); break;
            case CS_SOUND_STOP:
                MusicBackgroundStop(oArea); break;
        }
    }
}

void csll_ResetDelay(float fResetValueTo, int nCutNumber, object oArea)
{
    if(csm_CutsceneAborted(nCutNumber, oArea)) return;
    SetLocalFloat(oArea, "cs_fTotalDelay", fResetValueTo);
}

// Adds a PC to a cutscene currently running in an area.
// returns TRUE if successful
int csll_AddPCToCutscene(object oPC, object oArea=OBJECT_SELF)
{
    // if no cutscene is running, abort
    if(!GetLocalInt(oArea, "cs_bCutsceneStarted")) return FALSE;
    // if for some reason this pc isn't in the right area, abort
    if(GetArea(oPC) != oArea) return FALSE;
    // if this pc isn't actually a pc (or is a dm), abort
    if(!GetIsPC(oPC) || GetIsDM(oPC)) return FALSE;
    // just in case the game is marking a pc copy as a "pc" - I don't think it
    // does, but better safe than sorry
    if(GetTag(oPC)!="") return FALSE;
    // If this pc has already been marked as an actor in the cutscene, abort
    if(GetLocalInt(oPC, "cs_bIsActor")) return FALSE;

    int nNumPC = GetLocalInt(oArea, "cs_nNumPC");
    SetObjectArray(oArea, "cs_oPC", nNumPC, oPC);
    SetLocalInt(oArea, "cs_nNumPC", nNumPC+1);

    if(csm_GetOption(CS_OPTION_RESTORE_PC_LOCATION, oArea)) StorePCLocations(FALSE, oPC);

    location lLoc = GetLocalLocation(oArea, "cs_lCameraLocation");
    float fCameraDirection = GetLocalFloat(oArea, "cs_fCameraDirection");
    float fCameraDistance = GetLocalFloat(oArea, "cs_fCameraDistance");
    float fCameraPitch = GetLocalFloat(oArea, "cs_fCameraPitch");
    float fCameraHeight = GetLocalFloat(oArea, "cs_fCameraHeight");
    float fRate = GetLocalFloat(oArea, "cs_fRate");
    int bFaded = GetLocalInt(oArea, "cs_bFaded");
    int nDayNight = GetLocalInt(oArea, "cs_nDayNight");

    csll_ApplyPCCutsceneEffects(oPC, oArea);

    // put the newly added PC in the right spot, and set up the camera
    //AssignCommand(oPC, JumpToLocation(lLoc));
    SetLocalInt(oPC, PC_JUMP_CAMERA_SETTINGS, TRUE);
    SetLocalFloat(oPC, PC_JUMP_CAMERA_DIRECTION, fCameraDirection);
    SetLocalFloat(oPC, PC_JUMP_CAMERA_DISTANCE, fCameraDistance);
    SetLocalFloat(oPC, PC_JUMP_CAMERA_HEIGHT, fCameraHeight);
    SetLocalFloat(oPC, PC_JUMP_CAMERA_MOVEMENT_RATE, fRate);
    SetLocalFloat(oPC, PC_JUMP_CAMERA_PITCH, fCameraPitch);
    SetLocalInt(oPC, PC_JUMP_CUTSCENE_OK, TRUE);
    SetLocalLocation(oPC, PC_JUMP_LOCATION_INC_GENERIC, lLoc);
    SetLocalFloat(oPC, PC_JUMP_RANGE_INC_GENERIC, 0.5);
    ExecuteScript(FORCE_JUMP_SCRIPT_INC_GENERIC, oPC);

    if(bFaded) BlackScreen(oPC); else StopFade(oPC);
    if(nDayNight==CS_DAYNIGHT_DAY) NightToDay(oPC);
    else if(nDayNight==CS_DAYNIGHT_NIGHT) DayToNight(oPC);

    return TRUE;
}

void csll_ApplyPCCutsceneEffects(object oPC, object oArea=OBJECT_SELF, float fDelay=0.0)
{
    // Should we force PC's to unpossess their familiars?
    // this needs to happen right away
    if(csm_GetOption(CS_OPTION_REMOVE_PC_FAMILIAR_POSSESSION)==1)
    {
        UnpossessFamiliar(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC));
    }

    int bRemovePolymorph = csm_GetOption(CS_OPTION_REMOVE_PC_POLYMORPH);
    int bRemoveBlindness = csm_GetOption(CS_OPTION_REMOVE_PC_BLINDNESS_DARKNESS);
    int nEffectType;
    // Are there effects we should be removing from the PC?
    if(bRemovePolymorph==1 || bRemoveBlindness==1)
    {
        effect e = GetFirstEffect(oPC);
        while(GetIsEffectValid(e))
        {
            nEffectType = GetEffectType(e);
            if(bRemovePolymorph && nEffectType==EFFECT_TYPE_POLYMORPH)
            {
                DelayCommand(0.01, RemoveEffect(oPC, e));
            }
            if(bRemoveBlindness)
            {
                if(nEffectType == EFFECT_TYPE_BLINDNESS ||
                   nEffectType == EFFECT_TYPE_DARKNESS ||
                   nEffectType == EFFECT_TYPE_DEAF)
                {
                    DelayCommand(0.01, RemoveEffect(oPC, e));
                }
            }

            // If the player has effects applied from being in the crafting
            // system at the time of the cutscene, remove the effects.
            if (nEffectType == EFFECT_TYPE_CUTSCENEIMMOBILIZE
              && GetEffectCreator(e) == oPC
              && GetEffectSubType(e) == SUBTYPE_EXTRAORDINARY )
            {
                DelayCommand(0.01, RemoveEffect(oPC, e));
            }

            e = GetNextEffect(oPC);
        }
    }

    csm_AddActor(oPC, oArea);
    SetCutsceneMode(oPC, TRUE);
    // Delay these by fDelay...
    DelayCommand(fDelay, AssignCommand(oPC, ClearAllActions(TRUE)));
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oPC));
    DelayCommand(fDelay, csll_ApplyVFXToObject(DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oPC, 0.0, FALSE, TRUE, csm_GetLastCutsceneNumber(oArea), oArea));
    // This is a work-around for a weird henchman issue. Normally, when the PC goes into or out of
    // detect mode, the henchman will do the same. But if the PC has Keen Sense, they're always in
    // detect mode. So trying to turn it off doesn't turn it off at all, and the henchman end up
    // going into detect mode, which is not what we want at all. So I don't bother trying to turn
    // it off if the PC has Keen Sense.
    if(!GetHasFeat(FEAT_KEEN_SENSE, oPC))
    {
        DelayCommand(fDelay, SetActionMode(oPC, ACTION_MODE_DETECT, FALSE));
    }
    DelayCommand(fDelay, SetActionMode(oPC, ACTION_MODE_STEALTH, FALSE));
    int nCameraMode = GetLocalInt(oArea, "cs_nCameraMode");
    DelayCommand(fDelay, SetCameraMode(oPC, nCameraMode));

    // Does the PC have followers? Better do something about them, if the options are set.
    if(csm_GetOption(CS_OPTION_ASSOCIATE_INVISIBILITY)==1)
    {
        csll_ApplyAssociateCutsceneEffects(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC, oArea, fDelay);
        csll_ApplyAssociateCutsceneEffects(ASSOCIATE_TYPE_DOMINATED, oPC, oArea, fDelay);
        csll_ApplyAssociateCutsceneEffects(ASSOCIATE_TYPE_FAMILIAR, oPC, oArea, fDelay);
        csll_ApplyAssociateCutsceneEffects(ASSOCIATE_TYPE_SUMMONED, oPC, oArea, fDelay);
        csll_ApplyAssociateCutsceneEffects(ASSOCIATE_TYPE_HENCHMAN, oPC, oArea, fDelay);
    }
    else
    {
        if(csm_GetOption(CS_OPTION_ASSOCIATE_INVISIBILITY_ANIMALCOMPANION)==1)
            csll_ApplyAssociateCutsceneEffects(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC, oArea, fDelay);
        if(csm_GetOption(CS_OPTION_ASSOCIATE_INVISIBILITY_DOMINATED)==1)
            csll_ApplyAssociateCutsceneEffects(ASSOCIATE_TYPE_DOMINATED, oPC, oArea, fDelay);
        if(csm_GetOption(CS_OPTION_ASSOCIATE_INVISIBILITY_FAMILIAR)==1)
            csll_ApplyAssociateCutsceneEffects(ASSOCIATE_TYPE_FAMILIAR, oPC, oArea, fDelay);
        if(csm_GetOption(CS_OPTION_ASSOCIATE_INVISIBILITY_HENCHMEN)==1)
            csll_ApplyAssociateCutsceneEffects(ASSOCIATE_TYPE_HENCHMAN, oPC, oArea, fDelay);
        if(csm_GetOption(CS_OPTION_ASSOCIATE_INVISIBILITY_SUMMONED)==1)
            csll_ApplyAssociateCutsceneEffects(ASSOCIATE_TYPE_SUMMONED, oPC, oArea, fDelay);
    }
}

void csll_ApplyAssociateCutsceneEffects(int nAssociateType, object oPC, object oArea=OBJECT_SELF, float fDelay=0.0)
{
    int nNth = 1;
    object oAssociate = GetAssociate(nAssociateType, oPC, 1);
    while(GetIsObjectValid(oAssociate))
    {
        // apply cutscene effects
        csm_AddActor(oAssociate, oArea);
        DelayCommand(fDelay, AssignCommand(oAssociate, ClearAllActions(TRUE)));
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oAssociate));
        DelayCommand(fDelay, csm_SetFlag(CS_FLAG_CUTSCENE_GHOST_EFFECT, oAssociate));
        DelayCommand(fDelay, csll_ApplyVFXToObject(DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oAssociate, 0.0, FALSE, TRUE, csm_GetLastCutsceneNumber(oArea), oArea));

        // Remove summoned creatures that associates may have spawned in
        // I kinda hate to do this, but for now I have to be sure that they
        // can't screw things up... someday I'd like to revisit this and
        // do it a better way.
        DestroyObject(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oAssociate));
        DestroyObject(GetAssociate(ASSOCIATE_TYPE_DOMINATED, oAssociate));
        DestroyObject(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oAssociate));
        DestroyObject(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oAssociate));

        // get next henchman, or exit if not looking for henchmen
        if(nAssociateType==ASSOCIATE_TYPE_HENCHMAN)
        {
            nNth++;
            oAssociate = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nNth);
        }
        else oAssociate = OBJECT_INVALID;
    }
}

void csll_AreaOnEnter(object oEnterer)
{
    // OBJECT_SELF is an area, since this function is for the area OnEnter event
    if(GetLocalInt(OBJECT_SELF, "cs_bCutsceneStarted")) csll_AddPCToCutscene(oEnterer);
}