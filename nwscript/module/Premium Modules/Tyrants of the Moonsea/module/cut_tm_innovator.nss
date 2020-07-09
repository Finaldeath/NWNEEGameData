//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_innovator
// DATE: November 1, 2005
// AUTH: Luke Scull/Rich Barker
// NOTE: Cutscene and dialogue with Innovator.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "hf_in_cutscene"
#include "nw_i0_generic"

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    CutsceneStart(TRUE, TRUE, "WP_DreadspireLibrary_Move", TRUE);
}

// Innovator talks to player
void next0(float fTime)
{
    object oInnovator = GetObjectByTag("DreadspireTheInnovatorofPain");
    object oPC = GetFirstPC();
    object oWaypoint = GetObjectByTag("WP_DreadspireLibrary_Move");

    if (fTime == 0.0)
    {
        // some time for the camera to settle down
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // position the camera
        CutsceneCameraSetup(-1.0, 0.0, 5.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        //CutsceneNextShot() invoked from Innovator conversation
        AssignCommand(oInnovator, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// just end the scene
void next1(float fTime)
{
    if (fTime == 0.0)
    {
        CutsceneEnd();
    }
}

void end()
{
    object oPC = GetFirstPC();
    object oInnovator = GetObjectByTag("DreadspireTheInnovatorofPain");

    //Innovator attacks and will follow PC
    SetLocalInt(oInnovator, "iPursuing", 1);
    DelayCommand(4.0, ExecuteScript("exe_tm_innovphb", oInnovator));
    DelayCommand(4.1, ChangeToStandardFaction(oInnovator, STANDARD_FACTION_HOSTILE));
    DelayCommand(4.2, AssignCommand(oInnovator, DetermineCombatRound(oPC)));
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
        StopFade(GetFirstPC());
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
