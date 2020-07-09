// this is the cutscene where farmer talks to the player in daggerford
// .. there are two waypoints where the farmer might spawn based on
// .. which exit the player took from the house

#include "hf_in_cutscene"
#include "hf_in_util"

// return 1 if front door is closer, 2 if back door
int findDoor(object oPC)
{
    object oBackDoor = GetObjectInArea("Chateu_back_door", oPC);
    object oFrontDoor = GetObjectInArea("Chateu_front_door", oPC);
    float fDistBackDoor = GetDistanceBetween(oPC, oBackDoor);
    float fDistFrontDoor = GetDistanceBetween(oPC, oFrontDoor);
    if (fDistBackDoor < fDistFrontDoor)
    {
        return(2);
    }
    return(1);
}

// spawn NPCs at the waypoint closest to the player
void spawnNPCs(object oPC)
{
    object oWP;
    if (findDoor(oPC) == 1)
    {
        oWP = GetWaypointByTag("WP_AR0500_FARMER_SPAWN_FRONT");
    }
    else
    {
        oWP = GetWaypointByTag("WP_AR0500_FARMER_SPAWN_BACK");
    }
    object oFarmer = CreateObject(OBJECT_TYPE_CREATURE, "pm_farmer", GetLocation(oWP), FALSE);
    CutsceneAddActor("pm_farmer", oFarmer);
    SetLocalInt(oFarmer, "HF_DISABLE_AM", 1);
    SetLocalInt(oFarmer, "NW_GENERIC_MASTER", 0);
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    CutsceneStart(FALSE, FALSE);
    BlackScreen(oPC);
    spawnNPCs(oPC);
}

// farmer talks to the player
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oFarmer = CutsceneGetActor("pm_farmer");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // camera angle depends on how the player entered the area
        // .. (front door or back door)
        float fDir = 0.0;
        if (findDoor(oPC) == 2)
        {
            fDir = 180.0;
        }
        CutsceneCameraSetup(-1.0, fDir, 15.0, 50.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // farmer talks to the player
        AssignCommand(oFarmer, ActionSpeakString(q+"Hey there. We need to talk."+q));
        AssignCommand(oFarmer, ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
        AssignCommand(oFarmer, ActionStartConversation(oPC, "pm_farmer", TRUE));
    }
}

// just end the scene
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oFarmer = CutsceneGetActor("pm_farmer");

    if (fTime == 0.0)
    {
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        CutsceneEnd();
    }
}

// the farmer exits
void end()
{
    object oPC = GetFirstPC();
    object oFarmer = CutsceneGetActor("pm_farmer");

    // farmer runs away
    SetLocalString(oFarmer, "HF_EXIT_NAME", "EXIT_pm_farmer");
    SetLocalInt(oFarmer, "HF_EXIT_RUN", TRUE);
    ExecuteScript("hf_cs_exit", oFarmer);
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
