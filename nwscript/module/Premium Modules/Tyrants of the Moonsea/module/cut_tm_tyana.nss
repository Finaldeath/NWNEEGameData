// this is the cutscene where the player meets tyana in the zhentil keep orphanage

#include "hf_in_cutscene"
#include "hf_in_npc"
#include "hf_in_util"
#include "hf_in_plot"

const string TYANA_NPC_TAG = "Tyana";

// make sure sparrow is standing in the correct place
void setup(object oPC)
{
    object oWP = GetWaypointByTag("WP_ZKAO_SPARROW2");
    location lLoc = GetLocation(oWP);
    object oSparrow = GetObjectInArea("Sparrow", oPC);
    if (GetIsObjectValid(oSparrow))
    {
        AssignCommand(oSparrow, JumpToLocation(lLoc));
    }
    else
    {
        CreateObject(OBJECT_TYPE_CREATURE, "sparrow", lLoc);
    }
}

// no point setting a camera angle (the convo will change it)
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    setup(oPC);
    CutsceneStart(FALSE, TRUE, "WP_ZKAO_CUT1_START", FALSE);
}

// talk with tyana
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    object oTyana = GetObjectInArea(TYANA_NPC_TAG, oPC);

    if (fTime == 0.0)
    {
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // spin the camera around
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 10.0, 60.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // player is walking towards tyana
        object oWP = GetWaypointByTag("WP_ZKAO_CUT1_PLAYER");
        AssignCommand(oPC, ActionMoveToObject(oWP));
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oPC, ActionStartConversation(oTyana, "tm_tyana", FALSE, FALSE));
        // the "next" event is sent from a script in the dialog
    }
}

// just end the scene
void next1(float fTime)
{
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        CutsceneEnd();
    }
}

// party and sparrow are both kicked back outside
void end()
{
    object oPC = CutsceneGetPC();

    PlotLevelSet("Tyana", 1);

    object oSparrow = GetObjectInArea("Sparrow", oPC);
    object oWPspar = GetWaypointByTag("WP_ZKEP_ZKAO_SPARROW");
    AssignCommand(oSparrow, JumpToLocation(GetLocation(oWPspar)));

    object oJackdaw = GetObjectInArea("Jackdaw", oPC);
    object oWPjack = GetWaypointByTag("WP_ZKEP_ZKAO_JACKDAW");
    AssignCommand(oJackdaw, JumpToLocation(GetLocation(oWPjack)));

    TeleportToWaypoint(oPC, "WP_ZKEP_ZKAO_PC");
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
