//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_vaporand0
//:: DATE: January 13, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Vaporandir appears and initiates conversation
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_plot"

const string ITM_RESREF_DRAGON_EGG = "dragonegg";
const string ITM_TAG_DRAGON_EGG = "DragonEgg";

const string NPC_RESREF_VAPORANDIR = "tm_cr_vaporandir";
const string NPC_TAG_VAPORANDIR  = "tm_cr_vaporandir";
const string WP_TAG_VAPORANDIR_SPAWN = "WP_cut_vaporand0_vap_spawn";
const string WP_TAG_VAPORANDIR_FINAL = "WP_cut_vaporand0_vap_final";

const string WP_TAG_PLAYER_INIT = "WP_cut_vaporand0_pc_init";


void setupActors(object oPC)
{
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    oActor = GetObjectByTag(NPC_TAG_VAPORANDIR);
    if (!GetIsObjectValid(oActor))
    {
        oWaypoint = GetWaypointByTag(WP_TAG_VAPORANDIR_SPAWN);
        oActor = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_VAPORANDIR, GetLocation(oWaypoint), TRUE, NPC_TAG_VAPORANDIR);

        CutsceneAddActor(NPC_TAG_VAPORANDIR, oActor);
    }
}


void start()
{
    object oPC = CutsceneGetPC();

    CutsceneStart(FALSE, FALSE, "", FALSE);
}


void abort()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    BlackScreen(oPC);
    setupActors(oPC);

    // Jump player to final WP
    oWaypoint = GetWaypointByTag(WP_TAG_PLAYER_INIT);
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, JumpToLocation(GetLocation(oWaypoint)));

    // Jump Vaporandir directly to final dest.
    oActor = CutsceneGetActor(NPC_TAG_VAPORANDIR);
    oWaypoint = GetWaypointByTag(WP_TAG_VAPORANDIR_FINAL);
    AssignCommand(oActor, ClearAllActions(TRUE));
    AssignCommand(oActor, JumpToLocation(GetLocation(oWaypoint)));
}


void end()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;

    // Setup Vaporandir dialog branch (the PC has already met him)
    PlotLevelSet(NPC_TAG_VAPORANDIR, 1);
}


// Shot 0: Artemis walks along the road
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorVaporandir = CutsceneGetActor(NPC_TAG_VAPORANDIR);

    if (fTime == 0.0)
    {
        AssignCommand(oPC, ClearAllActions(TRUE));

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        CutsceneCameraSetup(3.0, 262.0, 10.0, 75.0, CAMERA_TRANSITION_TYPE_MEDIUM);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        setupActors(oPC);

        CutsceneNext(5.0);
    }
    else if (fTime >= 5.0)
    {
        AssignCommand(oActorVaporandir, ClearAllActions(TRUE));
        AssignCommand(oActorVaporandir, ActionStartConversation(oPC, "", FALSE, FALSE));

        CutsceneNextShot();
    }
}


// Shot 1: End cutscene
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
        StopFade(CutsceneGetPC());
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
