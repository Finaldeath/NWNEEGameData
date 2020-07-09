#include "hf_in_cutscene"
#include "hf_in_util"


const string PLC_RESREF_FLAME = "plc_flamemedium";
const string WP_TAG_FLAME_SPAWN = "WP_TorchBearer_Move1";

const string NPC_RESREF_TORCHBEARER = "torchbearer";
const string NPC_TAG_TORCHBEARER = "TorchBearer";
const string WP_TAG_TORCHBEARER_SPAWN = "WP_cut_finalcut_torchbearer0";
const string WP_TAG_TORCHBEARER_MOVE_1 = "WP_cut_finalcut_torchbearer1";
const string WP_TAG_TORCHBEARER_MOVE_2 = "WP_cut_finalcut_torchbearer2";

const string NPC_RESREF_DEADASTAR = "deadastar";
const string NPC_TAG_DEADASTARx = "DeadAstar"; // append number
const string WP_TAG_DEADASTARx_SPAWN = "WP_cut_finalcut_astar_ship"; // append number

const string WP_TAG_PLAYER_0 = "WP_cut_finalcut_player0";
const string WP_TAG_PLAYER_1 = "WP_cut_finalcut_player1";
const string WP_TAG_PLAYER_2 = "WP_cut_finalcut_player2";


void questUpdate(object oPC)
{

}


void setupActors(object oPC)
{
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;
    int i = 0;

    for (i=1; i <= 3; i++)
    {
        CutsceneSpawnActor(NPC_RESREF_DEADASTAR, NPC_TAG_DEADASTARx + IntToString(i), WP_TAG_DEADASTARx_SPAWN + IntToString(i));
    }

    CutsceneSpawnActor(NPC_RESREF_TORCHBEARER, NPC_TAG_TORCHBEARER, WP_TAG_TORCHBEARER_SPAWN);
}


void start()
{
    object oPC = CutsceneGetPC();

    // Player will be invisble during this cutscene + jump back to original location
    CutsceneStart(TRUE, FALSE, "", TRUE);
}


void abort()
{
    object oPC = CutsceneGetPC();
    object oWaypoint = OBJECT_INVALID;

    setupActors(oPC);
}


void end()
{
    object oPC = CutsceneGetPC();
    object oWaypoint = OBJECT_INVALID;
    
    oWaypoint = GetWaypointByTag(WP_TAG_PLAYER_0);
    AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWaypoint)));    
}


void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorTorchbearer = CutsceneGetActor(NPC_TAG_TORCHBEARER);
    // Waypoints
    object oWpPlayer0 = GetWaypointByTag(WP_TAG_PLAYER_0);
    object oWpPlayer1 = GetWaypointByTag(WP_TAG_PLAYER_1);
    object oWpPlayer2 = GetWaypointByTag(WP_TAG_PLAYER_2);
    object oWpTorchbearerMove1 = GetWaypointByTag(WP_TAG_TORCHBEARER_MOVE_1);
    object oWpTorchbearerMove2 = GetWaypointByTag(WP_TAG_TORCHBEARER_MOVE_2);
    object oWpFlameSpawn = GetWaypointByTag(WP_TAG_FLAME_SPAWN);

    if (fTime == 0.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FASTEST);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // Black screen
        setupActors(oPC);

        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWpPlayer0)));

        CutsceneCameraSetup(2.5, 143.0, 5.0, 89.0, CAMERA_TRANSITION_TYPE_SNAP);
        //cs_CameraUseCameraWaypoint(0.1, 1, FALSE, OBJECT_SELF, 1);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_SLOW);

        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oActorTorchbearer, ActionMoveToLocation(GetLocation(oWpTorchbearerMove1), FALSE));

        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        AssignCommand(oActorTorchbearer, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 2.0));

        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        CreateObject(OBJECT_TYPE_PLACEABLE, PLC_RESREF_FLAME, GetLocation(oWpFlameSpawn), FALSE);

        CutsceneNext(13.0);
    }
    else if (fTime == 13.0)
    {
        AssignCommand(oActorTorchbearer, ActionMoveToLocation(GetLocation(oWpTorchbearerMove2), FALSE));

        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {

        FadeToBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(16.0);
    }
    else if (fTime == 16.0)
    {
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWpPlayer1)));

        CutsceneCameraSetup(1.5, 212.0, 10.0, 89.0, CAMERA_TRANSITION_TYPE_SNAP);
        //cs_CameraUseCameraWaypoint(1.5, 2, FALSE, OBJECT_SELF, 1);

        CutsceneNext(17.0);
    }
    else if (fTime == 17.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_SLOW);

        CutsceneNext(19.0);
    }
    else if (fTime == 19.0)
    {
        CutsceneCameraSetup(-1.0, 220.0, 12.0, 70.0, CAMERA_TRANSITION_TYPE_SLOW);
        // cs_CameraSetFacing(1.5, 220.0, 12.0, 70.0, CAMERA_TRANSITION_TYPE_SLOW, OBJECT_SELF, 1);

        CutsceneNext(27.0);
    }
    else if (fTime == 27.0)
    {
        FadeToBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(29.0);
    }
    else if (fTime == 29.0)
    {
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWpPlayer2)));

        CutsceneCameraSetup(2.0, 180.0, 5.0, 89.0, CAMERA_TRANSITION_TYPE_SNAP);
        //cs_CameraUseCameraWaypoint(1.5, 3, FALSE, OBJECT_SELF, 1);

        CutsceneNext(31.0);
    }
    else if (fTime == 31.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_SLOW);

        CutsceneNext(32.0);
    }
    else if (fTime >= 32.0)
    {
        CutsceneNextShot();
    }
}


// Shot 3: Ends the cutscene
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
        StopFade(GetFirstPC());
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        abort();
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "Error: Invalid cutscene event (" + IntToString(nEvent) +")");
        // Try to end gracefully
        abort();
        CutsceneEnd();
    }
}