// this is the cutscene where feldran first confronts the player

#include "hf_in_cutscene"
#include "hf_in_npc"
#include "hf_in_spawn"
#include "hf_in_plot"
#include "hf_in_util"
#include "NW_I0_GENERIC"

// spawn and levelup feldran
void SpawnNPCs(object oPC)
{
    object oWP = GetWaypointByTag("WP_AR2003_CUT1_FELDRAN");
    object oFeldran = CreateObject(OBJECT_TYPE_CREATURE, "ks_feldran", GetLocation(oWP));
    int nLevels = SpawnGetPartyCR(oPC, 100);
    SpawnLevelupCreature(oFeldran, nLevels);
    CutsceneAddActor("ks_feldran", oFeldran);
}

// move the camera into position
void start()
{
    object oPC = GetFirstPC();
    TeleportToWaypoint(oPC, "WP_AR2003_CUT1_START", FALSE);
    DelayCommand(1.0, CutsceneStart(FALSE, FALSE));
    SpawnNPCs(oPC);
}

// feldran speaks to player
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oFeldran = CutsceneGetActor("ks_feldran");

    if (fTime == 0.0)
    {
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        CutsceneCameraSetup(-1.0, 310.0, 4.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oPC, ActionStartConversation(oFeldran));
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

// feldran must be hostile
void end()
{
    object oPC = GetFirstPC();
    object oFeldran = GetObjectInArea("ks_feldran", oPC);
    SetPlotFlag(oFeldran, FALSE);
    SetImmortal(oFeldran, TRUE);
    ChangeToStandardFaction(oFeldran, STANDARD_FACTION_HOSTILE);
    AssignCommand(oFeldran, DetermineCombatRound());

    // in case the player made a deal with the drawbridge,
    // ... that deal is canceled.
    PlotLevelSet("dt_ar2000_drawbridge", 7);
    PlotLevelSet("ks_griswald", 2);
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
