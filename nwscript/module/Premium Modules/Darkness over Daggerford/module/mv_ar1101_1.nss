// cutscene where Roo the Rat talks to the player

#include "hf_in_cutscene"

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(FALSE, FALSE, "WP_AR1101_CUT1_START", FALSE);
}

// roo the rat talks to the player
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oRoo = GetObjectByTag("ac_rootherat");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // give some time for the camera to settle down
        SetLocalInt(oRoo, "HF_DISABLE_AM", 1);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // player walks into the cave
        CutsceneCameraSetup(-1.0, DIRECTION_SOUTH, 5.0, 65.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        FadeFromBlack(oPC);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        // roo squeeks and walks towards the player
        AssignCommand(oRoo, ActionSpeakString("*squeak*"));
        AssignCommand(oPC, PlaySound("as_an_ratsqueak2"));
        AssignCommand(oRoo, ActionMoveToObject(oPC));
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        // player hears a noise
        AssignCommand(oPC, ActionSpeakString(q+"What's that noise?"+q));
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT));
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT));
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        // roo talks to the player
        AssignCommand(oRoo, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// just end the scene
void next1(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        CutsceneEnd();
    }
}

// guard continues on his way
void end()
{
    object oPC = GetFirstPC();
    object oRoo = GetObjectByTag("ac_rootherat");
    SetLocalInt(oRoo, "HF_DISABLE_AM", 0);
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
        //CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
