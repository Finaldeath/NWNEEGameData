// this is the cutscene where the player enters daggerford;
// .. falias and astriel talk to the player

#include "hf_in_cutscene"
#include "hf_in_util"

// spawn falias and amara
void SpawnNPCs(object oPC)
{
    object oWP;
    oWP = GetWaypointByTag("WP_AR0500_CUT1_AMARA");
    object oAmara = CreateObject(OBJECT_TYPE_CREATURE, "db_amara1", GetLocation(oWP));
    CutsceneAddActor("db_amara1", oAmara);
    oWP = GetWaypointByTag("WP_AR0500_CUT1_FALIAS");
    object oFalias = CreateObject(OBJECT_TYPE_CREATURE, "pm_falias", GetLocation(oWP));
    CutsceneAddActor("pm_falias", oFalias);
}

// just start the scene (always play the daggerford music for this scene)
void start()
{
    object oPC = GetFirstPC();
    object oArea = GetArea(oPC);
    CutsceneStart(FALSE, FALSE);
    MusicBackgroundChangeDay(oArea, 81);
    MusicBackgroundChangeNight(oArea, 81);
    MusicBackgroundPlay(oArea);
    SpawnNPCs(oPC);
}

// falias talks to the player
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oFalias = CutsceneGetActor("pm_falias");

    if (fTime == 0.0)
    {
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // set camera angle
        CutsceneCameraSetup(-1.0, 150.0, 7.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // falias talks to the player
        AssignCommand(oFalias, ActionStartConversation(oPC));
    }
}

// astriel talks to the player
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oAstriel = CutsceneGetActor("db_amara1");

    if (fTime == 0.0)
    {
        CutsceneCameraSetup(-1.0, 60.0, 6.0, 80.0, CAMERA_TRANSITION_TYPE_FAST);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oAstriel, ActionStartConversation(oPC));
    }
}

// just end the scene
void next2(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        CutsceneEnd();
    }
}

// the river gates should be open and unlocked
void end()
{
    object oPC = GetFirstPC();
    object oGates = GetObjectInArea("pm_rivergate", oPC);
    SetLocalInt(GetArea(oPC), "iResetMusic", 1);
    SetLocked(oGates, FALSE);
    AssignCommand(oGates, ActionOpenDoor(oGates));
}

void main()
{
    int nShot = CutsceneGetShot();
    float fTime = CutsceneGetTime();
    int nEvent = CutsceneGetEvent();

    if (nEvent == CUTSCENE_EVENT_START)
    {
        start();
        CutsceneNext(0.0);
    }
    else if (nEvent == CUTSCENE_EVENT_SHOT ||
             nEvent == CUTSCENE_EVENT_NEXT)
    {
        if (nShot == 0) next0(fTime);
        if (nShot == 1) next1(fTime);
        if (nShot == 2) next2(fTime);
    }
    else if (nEvent == CUTSCENE_EVENT_END)
    {
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
