// this is the cutscene where the griffons haul the player off to meet Bugo

#include "hf_in_cutscene"
#include "hf_in_npc"
#include "hf_in_util"

// remove wandering NPCs in cutscene area
void ClearCutsceneArea(object oPC)
{
    object oTrigger = GetObjectByTag("pm_cs_subarea");
    object oInTrigger = GetFirstInPersistentObject(oTrigger, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oInTrigger))
    {
        if ((!GetIsPC(oInTrigger)) && (!GetFactionEqual(oInTrigger, oPC)))
        {
            SetCommandable(TRUE, oInTrigger);
            AssignCommand(oInTrigger, ClearAllActions(TRUE));
            AssignCommand(oInTrigger, ActionJumpToObject(GetObjectInArea("pm_cs_subarea_jump", oInTrigger),FALSE));
        }
        oInTrigger = GetNextInPersistentObject(oTrigger, OBJECT_TYPE_CREATURE);
    }
}

// player's henchmen all move to a given waypoint
void PartyFollows(object oPC, object oWP)
{
    int i = 1;
    object oHench = GetHenchman(oPC, i);
    while (GetIsObjectValid(oHench))
    {
        AssignCommand(oHench, ActionMoveToObject(oWP, FALSE, 1.0));
        oHench = GetHenchman(oPC, ++i);
    }
}

// create the NPCs used in this scene
void SpawnNPCs(object oPC)
{
    location lGuard1a = GetLocation(GetWaypointByTag("WP_cs_Malitia1a"));
    location lGuard2a = GetLocation(GetWaypointByTag("WP_cs_Malitia2a"));
    location lGuard3a = GetLocation(GetWaypointByTag("WP_cs_Malitia3a"));
    location lGuard4a = GetLocation(GetWaypointByTag("WP_cs_Malitia4a"));
    location lGuardCap = GetLocation(GetWaypointByTag("WP_cs_MalitiaCapt"));
    object oGuard1 = CreateObject(OBJECT_TYPE_CREATURE,"pm_griffon",lGuard1a,FALSE,"cs_guard1");
    CutsceneAddActor("cs_guard1", oGuard1);
    object oGuard2 = CreateObject(OBJECT_TYPE_CREATURE,"pm_griffon",lGuard2a,FALSE,"cs_guard2");
    CutsceneAddActor("cs_guard2", oGuard2);
    object oGuard3 = CreateObject(OBJECT_TYPE_CREATURE,"pm_griffon",lGuard3a,FALSE,"cs_guard3");
    CutsceneAddActor("cs_guard3", oGuard3);
    object oGuard4 = CreateObject(OBJECT_TYPE_CREATURE,"pm_griffon",lGuard4a,FALSE,"cs_guard4");
    CutsceneAddActor("cs_guard4", oGuard4);
    object oCaptain = CreateObject(OBJECT_TYPE_CREATURE,"pm_griffon_cs",lGuardCap,FALSE,"cs_capt");
    CutsceneAddActor("cs_capt", oCaptain);
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(FALSE, FALSE);
    CutsceneMusic(68);
    ClearCutsceneArea(oPC);
    SpawnNPCs(oPC);
    SetLocalInt(oPC,"CS_MARINER",1);
    SetLocalInt(GetArea(oPC), "HF_DISABLE_AM", TRUE);
}

// guards confront the player
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oGuard1  = CutsceneGetActor("cs_guard1");
    object oGuard2  = CutsceneGetActor("cs_guard2");
    object oGuard3  = CutsceneGetActor("cs_guard3");
    object oGuard4  = CutsceneGetActor("cs_guard4");
    object oCaptain = CutsceneGetActor("cs_capt");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // camera
        CutsceneCameraSetup(-1.0, 90.0, 15.0, 60.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // sounds
        AssignCommand(oGuard1, PlaySound("as_pl_officerm3"));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        // guard4 runs towards player
        string sGender = "He";
        if (GetGender(oPC) == GENDER_FEMALE)
            sGender = "She";
        AssignCommand(oGuard4, ActionSpeakString(q+sGender+"'s here!"+q));
        object oDest = GetWaypointByTag("WP_cs_Malitia4");
        AssignCommand(oGuard4, ActionMoveToObject(oDest, TRUE));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        // guard1 runs towards player
        string sGender = "him";
        if (GetGender(oPC) == GENDER_FEMALE)
            sGender = "her";
        AssignCommand(oGuard1, ActionSpeakString(q+"Surround "+sGender+" men!"+q));
        object oDest = GetWaypointByTag("WP_cs_Malitia1");
        AssignCommand(oGuard1, ActionMoveToObject(oDest, TRUE));
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        // guard2, guard3 run towards player
        object oDest2 = GetWaypointByTag("WP_cs_Malitia2");
        AssignCommand(oGuard2, ActionMoveToObject(oDest2, TRUE));
        object oDest3 = GetWaypointByTag("WP_cs_Malitia3");
        AssignCommand(oGuard3, ActionMoveToObject(oDest3, TRUE));
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        // captain talks to player (this also moves him close to player)
        AssignCommand(oCaptain, ActionStartConversation(oPC, "pm_cs_griffon", FALSE, FALSE));
    }
}

// guards escort player
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oDest = GetWaypointByTag("WP_cs_marinerescort");
    object oGuard1  = CutsceneGetActor("cs_guard1");
    object oGuard2  = CutsceneGetActor("cs_guard2");
    object oGuard3  = CutsceneGetActor("cs_guard3");
    object oGuard4  = CutsceneGetActor("cs_guard4");
    object oCaptain = CutsceneGetActor("cs_capt");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneCameraSetup(-1.0, 110.0, 15.0, 50.0, CAMERA_TRANSITION_TYPE_MEDIUM);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // captain walks away
        AssignCommand(oCaptain, ActionSpeakString(q+"Follow me."+q));
        AssignCommand(oCaptain, ActionMoveToObject(oDest, TRUE, 0.0));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        // player follows the captain
        SetCutsceneCameraMoveRate(oPC, 0.7);
        object oDest = GetWaypointByTag("WP_cs_marinerescort");
        AssignCommand(oPC, ActionMoveToObject(oDest, FALSE, 2.0));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        // player's henchmen follow (if any exist)
        object oDest = GetWaypointByTag("WP_cs_marinerescort");
        PartyFollows(oPC, oDest);
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        // guard1, guard4 follows the player
        AssignCommand(oGuard2, PlaySound("as_pl_soldierm4"));
        AssignCommand(oGuard1, ActionMoveToObject(oPC, FALSE, 1.0));
        AssignCommand(oGuard4, ActionMoveToObject(oPC, FALSE, 2.0));
        CutsceneNext(7.5);
    }
    else if (fTime == 7.5)
    {
        // guard2, guard3 follow the captain
        AssignCommand(oGuard2, ActionMoveToObject(oDest, FALSE, 1.0));
        AssignCommand(oGuard3, ActionMoveToObject(oDest, FALSE, 1.0));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        // fade to black and cleanup
        FadeToBlack(oPC);
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        CutsceneEnd();
    }
}

// guards are gone; cutscene continues in the castle
void end()
{
    object oPC = GetFirstPC();
    object oGuard1  = CutsceneGetActor("cs_guard1");
    object oGuard2  = CutsceneGetActor("cs_guard2");
    object oGuard3  = CutsceneGetActor("cs_guard3");
    object oGuard4  = CutsceneGetActor("cs_guard4");
    object oCaptain = CutsceneGetActor("cs_capt");

    // guards are gone
    DestroyObject(oGuard1);
    DestroyObject(oGuard2);
    DestroyObject(oGuard3);
    DestroyObject(oGuard4);
    DestroyObject(oCaptain);

    // enable the ambient system for this area
    DeleteLocalInt(GetArea(oPC), "HF_DISABLE_AM");

    // jump to castle where a new cutscene begins
    DelayCommand(1.5, TeleportToWaypoint(oPC, "WP_CS_MARINER2"));
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
