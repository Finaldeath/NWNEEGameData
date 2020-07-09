// this is the cutscene where nagnorm talks to the player

#include "hf_in_cutscene"
#include "hf_in_util"

// move the camera into position
void start()
{
    object oPC = GetFirstPC();
    CutsceneStart(FALSE, FALSE, "WP_AR1003_CUT1_START");
}

// player and nagnorm are talking
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oNagnorm = GetObjectInArea("ks_nagnorm", oPC);

    if (fTime == 0.0)
    {
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        FadeFromBlack(oPC);
        AssignCommand(oNagnorm, ActionStartConversation(oPC, "", FALSE, FALSE));
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

// nothing special here
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
        // can't abort this scene (it's just a dialog)
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
