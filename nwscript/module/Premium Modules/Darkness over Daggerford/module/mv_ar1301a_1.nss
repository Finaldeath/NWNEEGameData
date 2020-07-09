// this is the cutscene when the player enters bhaal's temple
// .. just pans over the holy symbol on the floor

#include "hf_in_cutscene"

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE, "WP_AR1301A_CUT1_START", TRUE);
}

// pan the camera along the floor and view the bhaal symbol
void next0(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // set camera angle
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 8.0, 88.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // zoom in over bhaal symbol
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 1.0, 88.0, CAMERA_TRANSITION_TYPE_MEDIUM);
        CutsceneNext(11.0);
    }
    else if (fTime == 11.0)
    {
        // top-down shot of bhaal's symbol
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 5.0, 0.0, CAMERA_TRANSITION_TYPE_FAST);
        CutsceneNext(18.0);
    }
    else if (fTime == 18.0)
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
