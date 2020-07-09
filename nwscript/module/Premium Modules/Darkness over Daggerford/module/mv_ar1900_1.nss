// this is the cutscene where the player enters the lizard city (guard confronts)

#include "hf_in_cutscene"

// get a handle on the scene actors
void SpawnNPCs(object oPC)
{
    object oGuard = GetNearestObjectByTag("lizguard1", oPC);
    CutsceneAddActor("lizguard1", oGuard);
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    CutsceneStart(FALSE, FALSE);
    MusicBattlePlay(GetArea(oPC));
    SpawnNPCs(oPC);
}

// player and guard are talking
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oGuard = CutsceneGetActor("lizguard1");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // guard and player move into position
        object oWP1 = GetWaypointByTag("WP_AR1900_CUT1_GUARD");
        SetLocalInt(oGuard, "HF_DISABLE_AM", 1);
        AssignCommand(oGuard, ClearAllActions());
        AssignCommand(oGuard, ActionMoveToObject(oWP1, TRUE, 0.0));
        object oWP2 = GetWaypointByTag("WP_AR1900_CUT1_START");
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionMoveToObject(oWP2, FALSE, 0.0));
        CutsceneCameraSetup(-1.0, 70.0, 5.0, 75.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        // the guard is getting angry!
        AssignCommand(oPC, SetFacingPoint(GetPosition(oGuard)));
        AssignCommand(oGuard, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oGuard, PlaySound("c_lizardm_bat1"));
        AssignCommand(oGuard, SpeakString(q+"Kas! Tak zis laz?"+q));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // player is confused
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // the guard confronts the player
        AssignCommand(oGuard, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// just end the scene
void next1(float fTime)
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

// guard continues on his way
void end()
{
    object oPC = GetFirstPC();
    object oGuard = CutsceneGetActor("lizguard1");
    MusicBattleStop(GetArea(oPC));
    SetLocalInt(oGuard, "HF_DISABLE_AM", 0);
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
        // can't abort this scene (it's just a dialog)
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
