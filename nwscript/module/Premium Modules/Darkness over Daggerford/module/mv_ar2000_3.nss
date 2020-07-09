// this is the cutscene where feldran confronts the player

#include "hf_in_cutscene"
#include "hf_in_npc"
#include "hf_in_spawn"
#include "hf_in_plot"
#include "hf_in_util"
#include "NW_I0_GENERIC"

// remove all NPCs with a certain tag in this area
void RemoveNPCs(string sTag, object oPC)
{
    int i = 1;
    object oGuard = GetObjectInArea(sTag, oPC, i);
    while (GetIsObjectValid(oGuard))
    {
        if (!GetIsDead(oGuard))
        {
            DestroyObject(oGuard);
        }
        oGuard = GetObjectInArea(sTag, oPC, ++i);
    }
}

// spawn and levelup feldran
void SpawnNPCs(object oPC)
{
    // spawn feldran
    object oWP = GetWaypointByTag("WP_AR2000_CUT3_FELDRAN");
    object oFeldran = CreateObject(OBJECT_TYPE_CREATURE, "ks_feldran", GetLocation(oWP));
    int nLevels = SpawnGetPartyCR(oPC, 100);
    SpawnLevelupCreature(oFeldran, nLevels);
    SetLocalInt(oFeldran, "nState", 3);
    CutsceneAddActor("ks_feldran", oFeldran);

    // delete any left-over guards / knights
    RemoveNPCs("ks_exeltis_guard", oPC);
    RemoveNPCs("ks_exeltis_knight", oPC);

    // spawn some guards as backup for feldran
    int i = 0;
    oWP = GetObjectByTag("WP_AR2000_CUT3_GUARD", i);
    while (GetIsObjectValid(oWP))
    {
        object oGuard = CreateObject(OBJECT_TYPE_CREATURE, "ks_exeltis_knigh", GetLocation(oWP));
        ChangeFaction(oGuard, oFeldran);
        oWP = GetObjectByTag("WP_AR2000_CUT3_GUARD", ++i);
    }
}

// move the camera into position
void start()
{
    object oPC = GetFirstPC();
    TeleportToWaypoint(oPC, "WP_AR2000_CUT3_START", FALSE);
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
        FadeFromBlack(oPC);
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 5.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        PlotLevelSet("ks_feldran", 2);
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

// make all creatures with this tag hostile
void GoHostile(string sTag, object oPC)
{
    int i = 1;
    object o = GetObjectInArea(sTag, oPC, i);
    while (GetIsObjectValid(o))
    {
        SetPlotFlag(o, FALSE);
        SetImmortal(o, FALSE);
        ChangeToStandardFaction(o, STANDARD_FACTION_HOSTILE);
        AssignCommand(o, DetermineCombatRound());
        o = GetObjectInArea(sTag, oPC, ++i);
    }
}

// feldran and guards must be hostile
void end()
{
    object oPC = GetFirstPC();
    GoHostile("ks_feldran", oPC);
    GoHostile("ks_exeltis_knight", oPC);

    // adjust plot levels
    PlotLevelSet("dt_ar2000_drawbridge", 6);
    PlotLevelSet("ks_olree", 2);
    SetLocalInt(GetModule(), "nFandocFeldranAttackFinal", 1);
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
