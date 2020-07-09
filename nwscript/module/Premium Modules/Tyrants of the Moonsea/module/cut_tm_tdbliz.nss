// cutscene: player enters hillsfar temple district from arena
// and blizzard talks

#include "hf_in_cutscene"
#include "cut_tm_arena_inc"

const string WP_TAG_PC_INIT = "WP_TD_Jump";


// spawn blizzard into the scene
void SetupActors(object oPC)
{
    object oWaypoint = GetWaypointByTag("WP_Blizzard_Temple");
    location lTarget = GetLocation(oWaypoint);
    object oBlizzard = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_BLIZZARD, lTarget, FALSE, NPC_TAG_BLIZZARD);
    CutsceneAddActor(NPC_TAG_BLIZZARD, oBlizzard);
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();
    StopFade(oPC);
    BlackScreen(oPC);
    CutsceneStart(FALSE, FALSE, WP_TAG_PC_INIT, FALSE);
    SetupActors(oPC);
}

// start conversation with blizzard
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    object oBlizzard = CutsceneGetActor(NPC_TAG_BLIZZARD);

    if (fTime == 0.0)
    {
        // give the camera some time to settle
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(2.0, 150.0, 10.0, 65.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oBlizzard, ActionStartConversation(oPC));
    }
}

// called from conversation
void end()
{
    object oPC = CutsceneGetPC();
    AssignCommand(oPC, SetCameraFacing(150.0, 10.0, 65.0));
    AssignCommand(oPC, StoreCameraFacing());
    AssignCommand(oPC, RestoreCameraFacing());
    CutsceneEnd();
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
        // can't abort this scene; c'mon it's just a convo
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
