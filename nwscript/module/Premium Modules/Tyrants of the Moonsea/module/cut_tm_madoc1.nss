// cutscene in voonlar where madoc talks to the player on enter

#include "hf_in_cutscene"
#include "hf_in_plot"

const string NPC_TAG_MADOC = "MadoctheUncouth";

// just start the cutscene
void start()
{
    object oPC = CutsceneGetPC();
    CutsceneStart(FALSE, FALSE, "", FALSE);
}

// restore the original camera facing when the cutscene ends
void end()
{
    object oPC = CutsceneGetPC();
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, RestoreCameraFacing());
}

// this cutscene cannot be aborted, so nothing here
void abort()
{
}

// Shot 0: Madoc talks to the player
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    object oActorMadoc = GetNearestObjectByTag(NPC_TAG_MADOC, oPC);

    if (fTime == 0.0)
    {
        BlackScreen(oPC);
        CutsceneNext(0.5);
    }

    if (fTime == 0.5)
    {
        AssignCommand(oPC, StoreCameraFacing());
        CutsceneCameraSetup(2.0, 30.0, 7.0, 75.0, CAMERA_TRANSITION_TYPE_SNAP);
        StopFade(oPC);
        CutsceneNext(1.0);
    }

    if (fTime == 1.0)
    {
        PlotLevelSet("MadoctheUncouth", 5);
        AssignCommand(oActorMadoc, ActionStartConversation(oPC));
        // the "next" event is sent from a script in the dialog
    }
}

// Shot 1: Ends cutscene (this is called when the conversation exits)
void next1(float fTime)
{
    if (fTime >= 0.0)
    {
        CutsceneEnd();
    }
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
        if (nShot >= 1) next1(fTime);
    }
    else if (nEvent == CUTSCENE_EVENT_END)
    {
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        // abort not allowed; we want the player to see the entire conversation
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "Error: Invalid cutscene event (" + IntToString(nEvent) +")");
        // Try to end gracefully
        abort();
        CutsceneEnd();
    }
}
