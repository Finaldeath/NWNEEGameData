// this is the cutscene where Bugo talks inside the castle
// .. in the game it happens right after the mariner's cutscene
// .. where the griffins 'escort' you into the castle

#include "hf_in_cutscene"
#include "hf_in_npc"
#include "hf_in_util"

// create the NPCs used in this scene
void SpawnNPCs(object oPC)
{
    // make sure the little girl selling books in this area is gone
    object oWP = GetWaypointByTag("WP_AR0401_GOLDEN_GIRL");
    object oGirl = GetObjectInArea("ks_golden_girl", oWP);
    DestroyObject(oGirl);

    location lGuard1 = GetLocation(GetWaypointByTag("WP_cs_Malitia1b"));
    location lGuard2 = GetLocation(GetWaypointByTag("WP_cs_Malitia2b"));
    location lGuard3 = GetLocation(GetWaypointByTag("WP_cs_Malitia3b"));
    location lGuard4 = GetLocation(GetWaypointByTag("WP_cs_Malitia4b"));
    location lGuard5 = GetLocation(GetWaypointByTag("WP_cs_Malitia5b"));
    location lGuard6 = GetLocation(GetWaypointByTag("WP_cs_Malitia6b"));
    location lGuardCap = GetLocation(GetWaypointByTag("WP_cs_MalitiaCaptb"));
    location lBaron = GetLocation(GetWaypointByTag("WP_cs_Baron"));
    object oGuard1 = CreateObject(OBJECT_TYPE_CREATURE,"pm_griffon",lGuard1,FALSE,"castguard1");
    CutsceneAddActor("castguard1", oGuard1);
    object oGuard2 = CreateObject(OBJECT_TYPE_CREATURE,"pm_griffon",lGuard2,FALSE,"castguard2");
    CutsceneAddActor("castguard2", oGuard2);
    object oGuard3 = CreateObject(OBJECT_TYPE_CREATURE,"pm_griffon",lGuard3,FALSE,"castguard3");
    CutsceneAddActor("castguard3", oGuard3);
    object oGuard4 = CreateObject(OBJECT_TYPE_CREATURE,"pm_griffon",lGuard4,FALSE,"castguard4");
    CutsceneAddActor("castguard4", oGuard4);
    object oGuard5 = CreateObject(OBJECT_TYPE_CREATURE,"pm_griffon",lGuard5,FALSE,"castguard5");
    CutsceneAddActor("castguard5", oGuard5);
    object oGuard6 = CreateObject(OBJECT_TYPE_CREATURE,"pm_griffon",lGuard6,FALSE,"castguard6");
    CutsceneAddActor("castguard6", oGuard6);
    object oCaptain = CreateObject(OBJECT_TYPE_CREATURE,"pm_griffon_cs",lGuardCap,FALSE,"castguard7");
    CutsceneAddActor("castguard7", oCaptain);
    object oBugo = CreateObject(OBJECT_TYPE_CREATURE,"db_matagar",lBaron,FALSE);
    CutsceneAddActor("db_matagar", oBugo);
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(FALSE, FALSE);
    SpawnNPCs(oPC);
}

// guards confront the player
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oGuard1  = CutsceneGetActor("castguard1");
    object oGuard2  = CutsceneGetActor("castguard2");
    object oGuard3  = CutsceneGetActor("castguard3");
    object oGuard4  = CutsceneGetActor("castguard4");
    object oGuard5  = CutsceneGetActor("castguard5");
    object oGuard6  = CutsceneGetActor("castguard6");
    object oCaptain = CutsceneGetActor("castguard7");
    object oBugo    = CutsceneGetActor("db_matagar");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneCameraSetup(-1.0, 0.0, 7.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        // captain bows to bugo
        AssignCommand(oCaptain, ActionMoveToObject(oBugo, FALSE, 3.5));
        AssignCommand(oCaptain, ActionPlayAnimation(ANIMATION_FIREFORGET_BOW));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        // captain talks to bugo
        AssignCommand(oCaptain, PlaySound("vs_mgriff1_001"));
        AssignCommand(oCaptain, ActionSpeakString(q+"I have brought the adventurer, as you requested."+q));
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        // camera zooms in on player
        CutsceneCameraSetup(-1.0, 0.0, 2.0, 85.0, CAMERA_TRANSITION_TYPE_FAST);
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        // captain moves out of the way
        object oDest = GetWaypointByTag("WP_cs_MalitiaCaptb");
        AssignCommand(oCaptain, ActionMoveToObject(oDest));
        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        // bugo talks to the player
        AssignCommand(oBugo, ActionStartConversation(oPC, "pm_cs_matagor", FALSE, FALSE));
    }
}

// just end the cutscene
void next1(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        FadeToBlack(oPC);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        CutsceneEnd();
    }
}

// guards are gone; jump player back outside
void end()
{
    object oPC = GetFirstPC();
    object oGuard1  = CutsceneGetActor("castguard1");
    object oGuard2  = CutsceneGetActor("castguard2");
    object oGuard3  = CutsceneGetActor("castguard3");
    object oGuard4  = CutsceneGetActor("castguard4");
    object oGuard5  = CutsceneGetActor("castguard5");
    object oGuard6  = CutsceneGetActor("castguard6");
    object oCaptain = CutsceneGetActor("castguard7");
    object oBugo    = CutsceneGetActor("db_matagar");

    // this variable was set in the previous cutscene
    SetLocalInt(oPC, "CS_MARINER", 0);

    // bugo returns to his starting point
    location lBaron = GetLocation(GetWaypointByTag("WP_cs_Baron"));
    AssignCommand(oBugo, ActionJumpToLocation(lBaron));
    AssignCommand(oBugo, SetFacing(180.0));

    // guards are gone
    DestroyObject(oGuard1);
    DestroyObject(oGuard2);
    DestroyObject(oGuard3);
    DestroyObject(oGuard4);
    //DestroyObject(oGuard5);
    //DestroyObject(oGuard6);
    DestroyObject(oCaptain);

    // jump outside the castle
    // .. delay is needed to allow the Destroy's to be processed while
    // .. the player is still in the area
    DelayCommand(1.5, TeleportToWaypoint(oPC, "WP_CS_MARINER3"));
    DelayCommand(1.6, StopFade(oPC));
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
