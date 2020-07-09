// this is the cutscene where frederick talks to the player just before the game ends

#include "hf_in_cutscene"
//edit by luspr: 061706 -- replaced astriel with end game version

// spawn NPCs at the waypoint closest to the player
void spawnNPCs(object oPC)
{
    // spawn fred (remove old fred in barracks)
    object oFred = GetObjectByTag("pm_captain_frede");
    DestroyObject(oFred);
    object oWP = GetWaypointByTag("WP_AR0500_CUT2_FRED");
    location lLoc = GetLocation(oWP);
    oFred = CreateObject(OBJECT_TYPE_CREATURE, "pm_cap_fred2",  lLoc, FALSE);
    CutsceneAddActor("pm_cap_fred2", oFred);

    // spawn some guards so that fred doesn't look lonely
    location lLoc1 = GetLocation(GetWaypointByTag("POST_pm_griffonguard1"));
    object oGuard1 = CreateObject(OBJECT_TYPE_CREATURE, "pm_malitia", lLoc1, FALSE);
    location lLoc2 = GetLocation(GetWaypointByTag("POST_pm_griffonguard2"));
    object oGuard2 = CreateObject(OBJECT_TYPE_CREATURE, "pm_malitia", lLoc2, FALSE);

    // spawn astriel beside fred
    oWP = GetWaypointByTag("WP_AR0500_CUT2_ASTRIEL");
    object oAstriel = CreateObject(OBJECT_TYPE_CREATURE, "db_astriel_end", lLoc);
    CutsceneAddActor("db_astriel_end", oAstriel);
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    CutsceneStart(FALSE, FALSE);
    BlackScreen(oPC);
    spawnNPCs(oPC);
}

// fred talks to the player
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oFred = CutsceneGetActor("pm_cap_fred2");

    if (fTime == 0.0)
    {
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // position the camera
        CutsceneCameraSetup(-1.0, 0.0, 12.0, 50.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // fred talks to the player
        AssignCommand(oPC,   ClearAllActions(TRUE));
        AssignCommand(oFred, ClearAllActions(TRUE));
        AssignCommand(oFred, ActionStartConversation(oPC, "at_frederick2", TRUE));
    }
}

// just end the scene
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oFred = CutsceneGetActor("pm_cap_fred2");

    if (fTime == 0.0)
    {
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        CutsceneEnd();
    }
}

// fred has to wait outside the castle gates
void end()
{
    object oPC = GetFirstPC();
    object oFred = CutsceneGetActor("pm_cap_fred2");
    object oAstriel = CutsceneGetActor("db_astriel_end");

    // fred remains standing outside the castle gates
    AssignCommand(oFred, SetFacing(180.0));
    AssignCommand(oAstriel, SetFacing(180.0));

    // doors close to prevent the player from leaving the end game area
    AssignCommand(GetObjectByTag("AR0500_AR0700_EXIT"), ActionCloseDoor(GetObjectByTag("AR0500_AR0700_EXIT")));
    AssignCommand(GetObjectByTag("C1AR0500_0401_EXIT"), ActionCloseDoor(GetObjectByTag("C1AR0500_0401_EXIT")));
    AssignCommand(GetObjectByTag("AR0500_AR0800_EXIT"), ActionCloseDoor(GetObjectByTag("AR0500_AR0800_EXIT")));
    AssignCommand(GetObjectByTag("pm_rivergate"), ActionCloseDoor(GetObjectByTag("pm_rivergate")));
    SetLocked(GetObjectByTag("AR0500_AR0700_EXIT"), TRUE);
    SetLocked(GetObjectByTag("C1AR0500_0401_EXIT"), TRUE);
    SetLocked(GetObjectByTag("AR0500_AR0800_EXIT"), TRUE);
    SetLocked(GetObjectByTag("pm_rivergate"), TRUE);

    // note that fred2 has spoken with the player
    SetLocalInt(GetModule(), "fred2_hasmet", 1);
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
