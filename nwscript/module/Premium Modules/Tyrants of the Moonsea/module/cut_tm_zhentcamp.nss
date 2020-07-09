//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_zhentcamp
// DATE: December 11, 2018
// AUTH: Rich Barker
// NOTE: Cutscene and dialogue on arriving at Zhent camp
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "x0_i0_walkway"

#include "hf_in_cutscene"
#include "hf_in_plot"

const string NPC_TAG_OFFICER = "IyraurothZhentarimOfficer";
const string WP_TAG_OFFICER_INIT = "WP_THID_CS_OFFICER_JUMP";

const string NPC_TAG_ZOR = "ZortheQuartermaster";

void SetupActors(object oPC)
{
    object oActor = GetNearestObjectByTag(NPC_TAG_OFFICER, oPC);
    CutsceneAddActor(NPC_TAG_OFFICER, oActor);

    oActor = GetNearestObjectByTag(NPC_TAG_ZOR, oPC);
    CutsceneAddActor(NPC_TAG_ZOR, oActor);
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();
    AssignCommand(oPC, ClearAllActions());
    CutsceneStart(TRUE, FALSE, "WP_THID_CS_PC_START", FALSE);
    SetupActors(oPC);
}

// Ezril talks to player
void next0(float fTime)
{
    object oOfficer = CutsceneGetActor(NPC_TAG_OFFICER);
    object oZor = CutsceneGetActor(NPC_TAG_ZOR);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 0.0, 5.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);
        // some time for the camera to settle down
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oZor, SetFacingPoint(GetPosition(oPC)));
        //CutsceneNextShot() invoked from Merrik conversation
        AssignCommand(oOfficer, ActionStartConversation(oPC, "", FALSE, FALSE));
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

//Ensure Officer dialog aborted
void abort()
{
    object oPC = CutsceneGetPC();

    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
}

void end()
{
    object oOfficer = CutsceneGetActor(NPC_TAG_OFFICER);
    object oPC = CutsceneGetPC();
    object oZor = CutsceneGetActor(NPC_TAG_ZOR);

    AssignCommand(oPC, SetCameraFacing(0.0, 25.0, 50.0));

    //Set Plot flag on Officer and start Waypoint Walking
    PlotLevelSet(NPC_TAG_OFFICER, 1);
    SetWalkCondition(NW_WALK_FLAG_CONSTANT, TRUE, oOfficer);
    SetWalkCondition(NW_WALK_FLAG_CONSTANT, TRUE, oZor);

    AssignCommand(oPC, StoreCameraFacing());
    AssignCommand(oPC, RestoreCameraFacing());
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
        abort();
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
