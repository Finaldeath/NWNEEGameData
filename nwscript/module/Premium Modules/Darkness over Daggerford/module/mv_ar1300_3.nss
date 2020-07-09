// this is the cutscene where the stronghold messenger talks to the player

#include "hf_in_cutscene"
#include "inc_stronghold"

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    CutsceneStart(FALSE, FALSE);
}

// messenger talks to the player
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oMsger = GetLocalObject(GetModule(), "oQuestGiver");

    if (fTime == 0.0)
    {
        // allow some time for the camera to settle
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        // position the camera
        CutsceneCameraSetup(-1.0, 165.0, 8.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // msger talks
        string sDlg = QuestGetDialogFile(oMsger);
        AssignCommand(oMsger, ActionStartConversation(oPC, sDlg));
    }
}

// just end the scene
void next1(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        CutsceneEnd();
    }
}

// nothing special to do here
void end()
{
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
