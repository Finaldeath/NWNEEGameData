#include "x0_i0_position"

const int CUTSCENE_EVENT_START = 1;
const int CUTSCENE_EVENT_NEXT  = 2;
const int CUTSCENE_EVENT_SHOT  = 3;
const int CUTSCENE_EVENT_END   = 4;
const int CUTSCENE_EVENT_ABORT = 5;

const int CUTSCENE_STATE_PLAYING = 1;
const int CUTSCENE_STATE_END = 2;

const int CUTSCENE_CAMERA_PC_SHOULDER = 1;
const int CUTSCENE_CAMERA_NPC_SHOULDER = 2;
const int CUTSCENE_CAMERA_MASTER = 3;
const int CUTSCENE_CAMERA_PC_CLOSEUP = 4;

// --------------------------------- QUERY -----------------------------------

// return the cutscene object
object CutsceneGetScene()
{
    return(GetLocalObject(GetModule(), "oCutsceneCreator"));
}

// return the name of this cutscene
string CutsceneGetSceneName()
{
    return(GetLocalString(CutsceneGetScene(), "sCutsceneName"));
}

// return the player involved in this cutscene
object CutsceneGetPC()
{
    return(GetLocalObject(CutsceneGetScene(), "oPlayerCharacter"));
}

// is a cutscene currently playing?
int CutsceneIsPlaying()
{
    return(GetLocalInt(CutsceneGetScene(), "nCutscenePlaying"));
}

// --------------------------------- STATES ----------------------------------

// set the state
void CutsceneSetState(int nState)
{
    object oCutscene = CutsceneGetScene();
    SetLocalInt(oCutscene, "nCutsceneState", nState);
}

// return the current state
int CutsceneGetState()
{
    object oCutscene = CutsceneGetScene();
    return(GetLocalInt(oCutscene, "nCutsceneState"));
}

// is this cutscene in the end state?
int CutsceneIsDone()
{
    return(CutsceneGetState() == CUTSCENE_STATE_END);
}

// --------------------------------- STEPS ---------------------------------

// set the current shot index to a given number
void CutsceneSetShot(int nShot)
{
    object oCutscene = CutsceneGetScene();
    SetLocalInt(oCutscene, "nCutsceneShot", nShot);
}

// return the current shot index
int CutsceneGetShot()
{
    object oCutscene = CutsceneGetScene();
    return(GetLocalInt(oCutscene, "nCutsceneShot"));
}

// execute the next shot in the cutscene
void CutsceneNextShot()
{
    object oCutscene = CutsceneGetScene();
    int nShot = CutsceneGetShot();
    CutsceneSetShot(++nShot);
    SetLocalFloat(oCutscene, "fCurTime", 0.0);
    SignalEvent(oCutscene, EventUserDefined(CUTSCENE_EVENT_SHOT));
}

// --------------------------------- TIME ----------------------------------

// return the current cutscene time index
float CutsceneGetTime()
{
    object oCutscene = CutsceneGetScene();
    return(GetLocalFloat(oCutscene, "fCurTime"));
}

// execute the next time index in the cutscene
void CutsceneNext(float fNextTime)
{
    object oCutscene = CutsceneGetScene();
    float fCurTime = GetLocalFloat(oCutscene, "fCurTime");
    float fDelay = fNextTime - fCurTime;
    if (fDelay <= 0.0)
        fDelay = 0.0;
    SetLocalFloat(oCutscene, "fCurTime", fNextTime);
    DelayCommand(fDelay, SignalEvent(oCutscene, EventUserDefined(CUTSCENE_EVENT_NEXT)));
}

// -------------------------------- ACTORS ---------------------------------

// add an actor to the scene. This simply caches the object so that you
// .. don't have to keep looking it up by searching for the object.
void CutsceneAddActor(string sName, object oActor)
{
    object oCutscene = CutsceneGetScene();
    int n = GetLocalInt(oCutscene, "Actor_Count");
    SetLocalObject(oCutscene, "Actor_" + sName, oActor);
    SetLocalString(oCutscene, "Actor_" + IntToString(n), sName);
    SetLocalInt(oCutscene, "nActorCount", ++n);
}

// lookup a stored actor by reference
object CutsceneGetActor(string sName)
{
    object oCutscene = CutsceneGetScene();
    object oActor = GetLocalObject(oCutscene, "Actor_" + sName);
    return(oActor);
}

// this erases all the actors from the cutscene; don't do this in the
// .. cutscene end functions, becase the end scripts still need to
// .. reference the actors. instead do it when a cutscene starts.
void CutscenePurgeActors()
{
    object oCutscene = CutsceneGetScene();
    int n = GetLocalInt(oCutscene, "nActorCount");
    int i;
    for (i = 0; i< n; i++)
    {
        string sIndex = "Actor_" + IntToString(i);
        string sName = GetLocalString(oCutscene, sIndex);
        DeleteLocalObject(oCutscene, "Actor_" + sName);
        DeleteLocalString(oCutscene, sIndex);
    }
    DeleteLocalInt(oCutscene, "nActorCount");
}

// --------------------------------- PREP ----------------------------------

// removes negative effects on the player which might interfere with the scene
void CutsceneRemoveNegativeEffects(object oPC)
{
    effect eBad = GetFirstEffect(oPC);
    while(GetIsEffectValid(eBad))
    {
        int nEffectType = GetEffectType(eBad);
        if (nEffectType == EFFECT_TYPE_BLINDNESS ||
            nEffectType == EFFECT_TYPE_CHARMED ||
            nEffectType == EFFECT_TYPE_CONFUSED ||
            nEffectType == EFFECT_TYPE_DAZED ||
            nEffectType == EFFECT_TYPE_DEAF ||
            nEffectType == EFFECT_TYPE_DOMINATED ||
            nEffectType == EFFECT_TYPE_ENTANGLE ||
            nEffectType == EFFECT_TYPE_FRIGHTENED ||
            nEffectType == EFFECT_TYPE_PARALYZE ||
            nEffectType == EFFECT_TYPE_PETRIFY ||
            nEffectType == EFFECT_TYPE_SILENCE ||
            nEffectType == EFFECT_TYPE_SLEEP ||
            nEffectType == EFFECT_TYPE_SLOW ||
            nEffectType == EFFECT_TYPE_STUNNED)
        {
            RemoveEffect(oPC, eBad);
        }
        eBad = GetNextEffect(oPC);
    }
}

// --------------------------------- JUMP ----------------------------------

// remove all effects applied by the cutscene to a given creature
void RemoveAssociateEffects(object oPC)
{
    object oCreator = CutsceneGetScene();
    effect eEff = GetFirstEffect(oPC);
    while (GetIsEffectValid(eEff))
    {
        if (GetEffectCreator(eEff) == oCreator)
        {
            RemoveEffect(oPC, eEff);
        }
        eEff = GetNextEffect(oPC);
    }
}

// freeze a particular associate
void FreezeAssociate(object oPlayers, int bVanish)
{
    effect eAssociate = EffectCutsceneParalyze();
    effect eInv = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);

    object oCompanion = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPlayers);
    if (oCompanion != OBJECT_INVALID)
    {
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAssociate, oCompanion);
       if(bVanish)
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInv, oCompanion);
    }

    object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPlayers);
    if (oFamiliar != OBJECT_INVALID)
    {
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAssociate, oFamiliar);
       if(bVanish)
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInv, oFamiliar);
    }

    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPlayers);
    if (oSummon != OBJECT_INVALID)
    {
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAssociate, oSummon);
       if(bVanish)
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInv, oSummon);
    }

    object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPlayers);
    if (oDominated != OBJECT_INVALID)
    {
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAssociate, oDominated);
       if(bVanish)
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInv, oDominated);
    }
}

// freeze all associates of a player
void FreezeAssociates(object oPlayers, int bVanish)
{
    effect eAssociate = EffectCutsceneParalyze();
    effect eInv = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);

    int i = 1;
    object oHench = GetHenchman(oPlayers, i);
    while(oHench != OBJECT_INVALID)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAssociate, oHench);
        if(bVanish)
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInv, oHench);
        FreezeAssociate(oHench, bVanish);
        oHench = GetHenchman(oPlayers, ++i);
    }
    FreezeAssociate(oPlayers, bVanish);

    i = 0;
    object oFollower = GetObjectByTag("hf_follower", i);
    while (GetIsObjectValid(oFollower))
    {
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAssociate, oFollower);
       if(bVanish)
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInv, oFollower);
        oFollower = GetObjectByTag("hf_follower", ++i);
    }
}

// unfreeze a given associate
void UnFreezeAssociate(object oPlayers)
{
    object oCompanion = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPlayers);
    if (oCompanion != OBJECT_INVALID)
       RemoveAssociateEffects(oCompanion);
    object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPlayers);
    if (oFamiliar != OBJECT_INVALID)
       RemoveAssociateEffects(oFamiliar);
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPlayers);
    if (oSummon != OBJECT_INVALID)
       RemoveAssociateEffects(oSummon);
    object oDominated = GetLocalObject(oPlayers, "oDominated");
    if (oDominated != OBJECT_INVALID)
       RemoveAssociateEffects(oDominated);
}

// unfreeze the player's associates
void UnFreezeAssociates(object oPlayers)
{
    int i = 1;
    object oHench = GetHenchman(oPlayers, i);
    while(oHench != OBJECT_INVALID)
    {
        RemoveAssociateEffects(oHench);
        UnFreezeAssociate(oHench);
        oHench = GetHenchman(oPlayers, ++i);
    }
    UnFreezeAssociate(oPlayers);

    i = 0;
    object oFollower = GetObjectByTag("hf_follower", i);
    while (GetIsObjectValid(oFollower))
    {
        RemoveAssociateEffects(oFollower);
        oFollower = GetObjectByTag("hf_follower", ++i);
    }
}

// teleport all player's associates to a given waypoint
void CutMoveAssociatesTo(object oPC, string sWaypoint)
{
    location lLoc = GetLocation(GetWaypointByTag(sWaypoint));
    UnFreezeAssociates(oPC);
    object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
    object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
    if(oAnimal != OBJECT_INVALID)
        AssignCommand(oAnimal, JumpToLocation(lLoc));
    if(oDominated != OBJECT_INVALID)
        AssignCommand(oDominated, JumpToLocation(lLoc));
    if(oFamiliar != OBJECT_INVALID)
        AssignCommand(oFamiliar, JumpToLocation(lLoc));
    if(oSummoned != OBJECT_INVALID)
        AssignCommand(oSummoned, JumpToLocation(lLoc));

    int i = 1;
    object oHenchman = GetHenchman(oPC, i);
    while(oHenchman != OBJECT_INVALID)
    {
        AssignCommand(oHenchman, JumpToLocation(lLoc));
        oHenchman = GetHenchman(oPC, ++i);
    }
}

// teleports the party to a given waypoint
// .. the screen is blanked briefly to mimimize camera jerkiness (nSmooth)
void CutsceneMoveTo(string sWaypoint, int nAssociatesToo = FALSE, int nSmooth = TRUE)
{
    object oPC = CutsceneGetPC();
    if (!GetLocalInt(CutsceneGetScene(), "nCutSceneOriginalLocation"))
    {
        SetLocalLocation(CutsceneGetScene(), "lCutSceneOriginalLocation", GetLocation(oPC));
        SetLocalInt(CutsceneGetScene(), "nCutSceneOriginalLocation", 1);
    }
    object oWP = GetWaypointByTag(sWaypoint);
    if (GetIsObjectValid(oWP))
    {
        location lLoc = GetLocation(oWP);
        if (nSmooth)
            BlackScreen(oPC);
        AssignCommand(oPC, JumpToLocation(lLoc));
        if (nSmooth)
            DelayCommand(0.25, StopFade(oPC));
        if (nAssociatesToo)
        {
            CutMoveAssociatesTo(oPC, sWaypoint);
        }
    } else {
        SendMessageToPC(oPC, "ERROR: invalid waypoint: " + sWaypoint);
    }
}

// keeps executing move commands every second until they work, or until timeout
void CutsceneForceMoveTo(string sWaypoint, float fDelay, int nMaxTimes)
{
    object oPC = CutsceneGetPC();
    object oWP = GetWaypointByTag(sWaypoint);
    object oCutscene = CutsceneGetScene();
    if (GetDistanceBetween(oPC, oWP) > 1.0 && nMaxTimes > 0)
    {
        CutsceneMoveTo(sWaypoint, FALSE, FALSE);
        DelayCommand(fDelay, CutsceneForceMoveTo(sWaypoint, fDelay, --nMaxTimes));
    }
}

// unfreeze all the hostile creatures in the same area as the player
void CutUnfreezeHostiles(object oPC)
{
    object oCreator = CutsceneGetScene();
    int i = 1;
    object oCreature = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oPC, i);
    while (GetIsObjectValid(oCreature))
    {
        effect eEff = GetFirstEffect(oCreature);
        while (GetIsEffectValid(eEff))
        {
            if (GetEffectCreator(eEff) == oCreator)
            {
                RemoveEffect(oCreature, eEff);
            }
            eEff = GetNextEffect(oCreature);
        }
        oCreature = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oPC, ++i);
    }

}

// freeze all the hostile creatures in the same area as the player
void CutFreezeHostiles(object oPC)
{
    int i = 1;
    object oCreature = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oPC, i);
    while (GetIsObjectValid(oCreature))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oCreature, 9999.0);
        oCreature = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oPC, ++i);
    }
}

// -------------------------------- SOUND ------------------------------------

// play a certain music track during the cutscene
void CutsceneMusic(int nTrack, int nAmbientStop=TRUE)
{
    object oPC = CutsceneGetPC();
    object oArea = GetArea(oPC);
    SetLocalInt(oArea, "HF_CS_MUSIC_BG_DAY", MusicBackgroundGetDayTrack(oArea));
    SetLocalInt(oArea, "HF_CS_MUSIC_BG_NIGHT", MusicBackgroundGetNightTrack(oArea));
    MusicBackgroundChangeDay(oArea, nTrack);
    MusicBackgroundChangeNight(oArea, nTrack);
    AmbientSoundStop(oArea);
    MusicBackgroundPlay(oArea);
}

// private function to restore the music tracks to their original values
void MusicRestore(object oPC)
{
    object oArea = GetArea(oPC);
    if (GetLocalInt(oArea, "HF_CS_MUSIC_BG_DAY"))
        MusicBackgroundChangeDay(oArea, GetLocalInt(oArea, "HF_CS_MUSIC_BG_DAY"));
    if (GetLocalInt(oArea, "HF_CS_MUSIC_BG_NIGHT"))
        MusicBackgroundChangeNight(oArea, GetLocalInt(oArea, "HF_CS_MUSIC_BG_NIGHT"));
    AmbientSoundPlay(oArea);
    MusicBackgroundPlay(oArea);
}

// --------------------------------- CAMERA ----------------------------------

// control the camera
void CutsceneCameraSetup(float fHeight, float fDir, float fDist, float fPitch, int nTransitionType)
{
    object oPC = CutsceneGetPC();
    if (fHeight >= 0.0)
        SetCameraHeight(oPC, fHeight);
    AssignCommand(oPC, SetCameraFacing(fDir, fDist, fPitch, nTransitionType));
}

// track the movements of an NPC for a certain duration
void CutsceneCameraTrack(object oNPC, float fDur)
{
    object oPC = CutsceneGetPC();
    if (GetIsObjectValid(oNPC) && GetIsObjectValid(oPC))
    {
        float fNewDur = GetLocalFloat(CutsceneGetScene(), "fCutSceneTrackingTime");
        fNewDur += 0.20;
        if (fNewDur < fDur)
        {
            vector v = GetPosition(oNPC) - GetPosition(oPC);
            float fDir = VectorToAngle(v);
            SetLocalFloat(CutsceneGetScene(), "fCutSceneTrackingTime", fNewDur);
            AssignCommand(oPC, SetCameraFacing(fDir, -1.0, -1.0, CAMERA_TRANSITION_TYPE_MEDIUM));
            DelayCommand(0.20, CutsceneCameraTrack(oNPC, fDur));
        } else {
            DeleteLocalFloat(CutsceneGetScene(), "fCutSceneTrackingTime");
        }
    }
}

// point the camera at an NPC
void CutsceneCameraFace(object oNPC)
{
    object oPC = CutsceneGetPC();
    vector v = GetPosition(oNPC) - GetPosition(oPC);
    float fDir = VectorToAngle(v);
    AssignCommand(oPC, SetCameraFacing(fDir, -1.0, -1.0, CAMERA_TRANSITION_TYPE_MEDIUM));
}

// position the player and point the camera to give a closeup shot of an NPC
void CutsceneCameraCloseup(object oNPC, float fDist=1.5)
{
    object oPC = CutsceneGetPC();
    float fDir = GetFacing(oNPC);
    location lLoc = GenerateNewLocation(oNPC, 1.5, fDir, GetOppositeDirection(fDir));
    AssignCommand(oPC, ActionJumpToLocation(lLoc));
    float fDir2 = VectorToAngle(GetPosition(oNPC) - GetPosition(oPC));
    AssignCommand(oPC, SetCameraFacing(fDir2, fDist, 85.0, CAMERA_TRANSITION_TYPE_SNAP));
}

// --------------------------------- CONTROL ----------------------------------

// call this function to start playing a cutscene.
// .. sName = the script filename that the cutscene is stored in
void CutscenePlay(object oPC, string sName)
{
    object oCutscene = GetObjectByTag("hf_cutscene_object");
    if (!GetIsObjectValid(oCutscene))
    {
        SendMessageToPC(oPC, "ERROR: scene object not found.");
    }
    CutsceneSetState(CUTSCENE_STATE_PLAYING);
    CutsceneSetShot(0);
    SetLocalObject(oCutscene, "oPlayerCharacter", oPC);
    SetLocalObject(GetModule(), "oCutsceneCreator", oCutscene);
    SetLocalString(oCutscene, "sCutsceneName", sName);
    SetLocalInt(oCutscene, "nCutscenePlaying", 1);
    SetLocalFloat(oCutscene, "fCurTime", 0.0);
    SetLocalInt(oCutscene, "nEvent", 0);
    SetLocalInt(oCutscene, "nCutSceneOriginalLocation", 0);
    SetLocalInt(oCutscene, "nCutSceneTeleport", 1);
    SetLocalInt(oCutscene, "nMoveTimer", 3);
    CutscenePurgeActors();
    SetLocalInt(oCutscene, "nActorCount", 0);
    CutsceneRemoveNegativeEffects(oPC);
    SignalEvent(oCutscene, EventUserDefined(CUTSCENE_EVENT_START));
}

// start a cutscene
// .. nVanish = should the party vanish?
// .. nFade = should a fade to black execute before the scene starts?
// .. sWaypoint = teleport the party to this waypoint
// .. nTeleport = should the party be teleported back to the original location?
void CutsceneStart(int nVanish = FALSE, int nFade = TRUE, string sWaypoint = "", int nTeleport = TRUE)
{
    object oCutscene = GetObjectByTag("hf_cutscene_object");
    object oPC = CutsceneGetPC();
    AssignCommand(oPC, ClearAllActions(TRUE));
    SetActionMode(oPC, ACTION_MODE_DETECT, FALSE);
    SetActionMode(oPC, ACTION_MODE_STEALTH, FALSE);
    if (sWaypoint != "")
    {
        if (nFade)
        {
            FadeToBlack(oPC, FADE_SPEED_FAST);
            DelayCommand(2.0, CutsceneMoveTo(sWaypoint, FALSE, FALSE));
        } else {
            CutsceneMoveTo(sWaypoint, FALSE, FALSE);
        }
        if (nFade)
        {
            DelayCommand(3.0, FadeFromBlack(oPC, FADE_SPEED_FAST));
        }
    }
    if (nVanish)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oPC);
    }
    if (!nTeleport)
    {
        SetLocalInt(oCutscene, "nCutSceneTeleport", 0);
    }

    SetCutsceneMode(oPC, TRUE);
    FreezeAssociates(oPC, TRUE); // henchmen and such are always invisible
    CutFreezeHostiles(oPC);
}

// private function to cleanup after a cutscene ends
void CutsceneOver(object oPC)
{
    MusicRestore(oPC);
    RemoveAssociateEffects(oPC);
    UnFreezeAssociates(oPC);
    CutUnfreezeHostiles(oPC);
    SetCutsceneMode(oPC, FALSE);
    SetPlotFlag(oPC, FALSE);
}

// call this function to end the cutscene. the player is returned to
// .. the pre-cutscene location unless "teleport" was turned off for this scene
void CutsceneEnd()
{
    object oCutscene = CutsceneGetScene();
    object oPC = CutsceneGetPC();
    SetCameraHeight(oPC, 0.0);
    if (GetLocalInt(oCutscene, "nCutSceneOriginalLocation") &&
        GetLocalInt(oCutscene, "nCutSceneTeleport"))
    {
        location lLoc = GetLocalLocation(oCutscene, "lCutSceneOriginalLocation");
        FadeToBlack(oPC, FADE_SPEED_FAST);
        DelayCommand(2.0, CutsceneOver(oPC));
        DelayCommand(2.5, AssignCommand(oPC, JumpToLocation(lLoc)));
        DelayCommand(3.0, FadeFromBlack(oPC, FADE_SPEED_FAST));
    } else {
        CutsceneOver(oPC);
    }
    SignalEvent(oCutscene, EventUserDefined(CUTSCENE_EVENT_END));
    SetLocalInt(oCutscene, "nCutscenePlaying", 0);
}

// private function called when a cutscene is aborted by the player
void CutsceneAbort(object oPC)
{
    object oCutscene = CutsceneGetScene();
    SignalEvent(oCutscene, EventUserDefined(CUTSCENE_EVENT_ABORT));
}

// return the current cutscene event number
int CutsceneGetEvent()
{
    object oCutscene = CutsceneGetScene();
    return(GetLocalInt(oCutscene, "nEvent"));
}

// private function which executes the current cutscene event
void CutsceneEvent(int nEvent)
{
    object oCutscene = CutsceneGetScene();
    if (!CutsceneIsDone())
    {
        SetLocalInt(oCutscene, "nEvent", nEvent);
        ExecuteScript(CutsceneGetSceneName(), oCutscene);
        if (nEvent == CUTSCENE_EVENT_END)
            CutsceneSetState(CUTSCENE_STATE_END);
    }
}

// --------------------------------- CONVO ----------------------------------

// return the angle between two objects
vector GetVectorAB(object oA, object oB)
{
    vector vA = GetPosition(oA);
    vector vB = GetPosition(oB);
    vector vDelta = (vA - vB);
    return vDelta;
}

// return the horizontal distance between two objects
float GetHorizontalDistanceBetween(object oA, object oB)
{
    vector vHorizontal = GetVectorAB(oA,oB);
    float fDistance = sqrt(pow(vHorizontal.x,2.0) + pow(vHorizontal.y,2.0));
    return fDistance;
}

// return the direction a target is away from another target
float GetDirection(object oTarget, object oPC)
{
    vector vdTarget = GetVectorAB(oTarget,oPC);
    float fDirection = VectorToAngle(vdTarget);
    return fDirection;
}

// set the convo camera to a certain mode
void CutsceneConvoCameraSetup(object oPC, object oNPC, int nMode)
{
    float fRange;
    float fPitch;
    float fAngle;

    if (!GetLocalInt(oNPC, "nCameraFacingStored"))
    {
        SetLocalInt(oNPC, "nCameraFacingStored", 1);
        AssignCommand(oPC, StoreCameraFacing());
    }

    if (nMode == CUTSCENE_CAMERA_PC_SHOULDER)
    {
        fRange = 1.5;
        fAngle = GetDirection(oNPC, oPC) + (40.0 / sqrt(GetHorizontalDistanceBetween(oNPC, oPC)));
        fPitch = 75.0;
        if (fAngle > 360.0) fAngle -= 360.0;
    }
    if (nMode == CUTSCENE_CAMERA_NPC_SHOULDER)
    {
        fRange = GetHorizontalDistanceBetween(oNPC, oPC) + 1.5;
        fAngle = GetDirection(oPC, oNPC) - (asin(1.0 / fRange) / 1.5);
        fPitch = 90.0 - sqrt(12.0 - fRange);
        if (fAngle < 0.0) fAngle += 360.0;
    }
    if (nMode == CUTSCENE_CAMERA_PC_CLOSEUP)
    {
        fAngle = GetDirection(oPC, oNPC) - 5.0;
        fRange = 1.0;
        fPitch = 90.0;
        if (fAngle < 0.0) fAngle += 360.0;
    }
    if (nMode == CUTSCENE_CAMERA_MASTER)
    {
        fAngle = GetDirection(oNPC, oPC) + 60.0;
        fRange = GetHorizontalDistanceBetween(oNPC, oPC) * 1.5;
        fPitch = 90.0;
        if (fAngle > 360.0) fAngle -= 360.0;
        if (fRange < 2.0)   fRange = 2.0;
    }
    AssignCommand(oPC, SetCameraFacing(fAngle, fRange, fPitch));
}

// restore the camera to its pre-cutscene facing
void CutsceneConvoCameraEnd(object oPC, object oNPC)
{
    AssignCommand(oPC, RestoreCameraFacing());
    DeleteLocalInt(oNPC, "nCameraFacingStored");
}

/*
BASIC SETUP
 Create a creature in an inaccessible area of the module.
 Set its user-defined script to "hf_cs_cutscen_ud"
 Play a scene by calling CutscenePlay("name of script")

BASIC THEORY
 A scene is a series of sequential shots.
 Each shot has a time index where actions occur.

CUTSCENE OBJECT:
 Name: name of the script that is currently playing
 State: state of the current scene (END or PLAY)
 Shot: current shot number within the scene
 Time: current time index within the step
 Player: player object in the scene
 Original Location: player's original location
*/

//void main() {}
