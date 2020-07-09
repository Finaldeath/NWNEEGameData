// this is the cutscene where the PC lands in Laughing Hollow
// .. veiti joins as henchman

#include "hf_in_cutscene"
#include "hf_in_npc"
#include "hf_in_henchman"
#include "hf_in_util"
#include "inc_bw_worldmap"

// copy the player's henchies (they go invis during the scene)
void CopyHenchmen(object oPC)
{
    object oHench1 = GetHenchman(oPC, 1);
    if (GetIsObjectValid(oHench1))
    {
        object oWP1 = GetWaypointByTag("WP_AR2500_CUT1_HENCH1");
        object oHench1A = CopyObject(oHench1, GetLocation(oWP1), OBJECT_INVALID, "_ar2500_hench1");
        AssignCommand(oHench1A,ChangeToStandardFaction(oHench1A,STANDARD_FACTION_COMMONER));
        CutsceneAddActor("_ar2500_hench1", oHench1A);
    }
    object oHench2 = GetHenchman(oPC, 2);
    if (GetIsObjectValid(oHench2))
    {
        object oWP2 = GetWaypointByTag("WP_AR2500_CUT1_HENCH2");
        object oHench2A = CopyObject(oHench2, GetLocation(oWP2), OBJECT_INVALID, "_ar2500_hench2");
        AssignCommand(oHench2A,ChangeToStandardFaction(oHench2A,STANDARD_FACTION_COMMONER));
        CutsceneAddActor("_ar2500_hench2", oHench2A);
    }
}

// spawn NPCs used in this cutscene
void SpawnNPCs(object oPC)
{
    object oWP = GetWaypointByTag("WP_AR2500_CUT1_MAGDAREN");
    object oMag = CreateObject(OBJECT_TYPE_CREATURE, "db_magdaren", GetLocation(oWP));
    CutsceneAddActor("db_magdaren", oMag);

    oWP = GetWaypointByTag("WP_AR2500_CUT1_VEITI");
    object oVeiti = CreateObject(OBJECT_TYPE_CREATURE, "db_veiti", GetLocation(oWP));
    CutsceneAddActor("db_veiti", oVeiti);
}

// start the cutscene on the beach
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    DayToNight(oPC);
    SpawnNPCs(oPC);
    CopyHenchmen(oPC);
    CutsceneStart(FALSE, FALSE);
}

// looking at the cliffs, hearing spooky sounds
void next0(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        AssignCommand(oPC, PlaySound("as_wt_thunderds1"));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_SOUTH, 7.0, 88.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC, FADE_SPEED_SLOW);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oPC, PlaySound("as_pl_crptvoice1"));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 7.0, 88.0, CAMERA_TRANSITION_TYPE_SLOW);
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        AssignCommand(oPC, PlaySound("as_pl_zombief1"));
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        AssignCommand(oPC, PlaySound("as_pl_crptvoice4"));
        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 25.0, 88.0, CAMERA_TRANSITION_TYPE_SLOW);
        CutsceneNext(20.0);
    }
    else if (fTime == 20.0)
    {
        AssignCommand(oPC, PlaySound("as_pl_zombiem2"));
        CutsceneNext(25.0);
    }
    else if (fTime == 25.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 25.0, 45.0, CAMERA_TRANSITION_TYPE_SLOW);
        CutsceneNext(26.0);
    }
    else if (fTime == 26.0)
    {
        AssignCommand(oPC, PlaySound("as_pl_crptvoice2"));
        CutsceneNext(30.0);
    }
    else if (fTime == 30.0)
    {
        AssignCommand(oPC, PlaySound("as_wt_thunderds3"));
        CutsceneNextShot();
    }
}

// mags talks to the player
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oMag = CutsceneGetActor("db_magdaren");

    if (fTime == 0.0)
    {
        // set the camera for mag's dialog
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 10.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        // magdaren talks to the player
        AssignCommand(oMag, ActionStartConversation(oPC, "ks_ar2500_magdar", FALSE, FALSE));
    }
}

// mags get on the boat (off camera) and vanishes
void next2(float fTime)
{
    if (fTime == 0.0)
    {
        CutsceneEnd();
    }
}

// mags is gone; veiti is now a henchie
void end()
{
    object oPC = GetFirstPC();
    object oMag = CutsceneGetActor("db_magdaren");
    object oVeiti = CutsceneGetActor("db_veiti");
    object oBoat = GetObjectInArea("pdag_tno_boat1", oPC);

    // remove the henchman copies
    object oHench1Copy = CutsceneGetActor("_ar2500_hench1");
    if (GetIsObjectValid(oHench1Copy))
    {
        AssignCommand(oHench1Copy, ClearAllActions(TRUE));
        AssignCommand(oHench1Copy, SetIsDestroyable(TRUE));
        DestroyObject(oHench1Copy);
        DestroyObject(oHench1Copy, 0.5);
        DestroyObject(oHench1Copy, 1.0);
    }
    object oHench2Copy = CutsceneGetActor("_ar2500_hench2");
    if (GetIsObjectValid(oHench2Copy))
    {
        AssignCommand(oHench2Copy, ClearAllActions(TRUE));
        AssignCommand(oHench2Copy, SetIsDestroyable(TRUE));
        DestroyObject(oHench2Copy);
        DestroyObject(oHench2Copy, 0.5);
        DestroyObject(oHench2Copy, 1.0);
    }

    // mags and her boat are gone
    DestroyObject(oBoat);
    DestroyObject(oMag);

    // hire veiti as a henchman
    HenchmanHire(oVeiti, oPC);
    ForceRest(oVeiti);

    // give the "dwarves of illefarn" journal and reveal map
    AddJournalQuestEntry("j16", 1, oPC);
    RevealMapLocation("c1ar2500");
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
        if (nShot == 2) next2(fTime);
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
