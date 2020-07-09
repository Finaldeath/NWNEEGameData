//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_thayanam0
//:: DATE: January 28, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Thayan Ambassador
//:: Cutscene in Mulmaster Docks
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_plot"

const string NPC_TAG_GUARD = "CR_cut_thayanam0_guard";

const string NPC_TAG_ZAMAKUS = "CaptainZamakus";

const string NPC_TAG_AMBASSADOR = "CR_cut_thayanam0_ambassador";

const int NUM_GOLEMS = 12;
const string NPC_RESREF_GOLEMx = "tm_cr_thaygolem"; // 0 = diamond, 1 = emerald, 2 = ruby
const string NPC_TAG_GOLEM = "CR_cut_thayanam0_golem";
const string WP_TAG_GOLEM_SPAWN = "WP_cut_thayanam0_golem_spawn";

const string WP_TAG_PLAYER_INIT = "WP_cut_thayanam0_pc_init";

// Move Target for all creatures
const string WP_TAG_EXIT_ALL = "WP_cut_thayanam0_move_all";

const string LVAR_CUTSCENE_IN_PROGRESS = "WP_cut_thayanam0_inprogress";


void updateQuestEnd(object oPC)
{
    AddJournalQuestEntry("ThayanAmbassadors", 10, oPC);
    PlotLevelSet("thayanam_status", 1);
}


void exitThayanOfficials(object oPC)
{
    object oAmbassador = GetNearestObjectByTag(NPC_TAG_AMBASSADOR, oPC);
    if (GetIsObjectValid(oAmbassador))
    {
        SetLocalString(oAmbassador, "HF_EXIT_NAME", WP_TAG_EXIT_ALL);
        SetLocalInt(oAmbassador, "HF_EXIT_RUN", 0);
        ExecuteScript("hf_cs_exit", oAmbassador);
    }

    object oZamakus = GetNearestObjectByTag(NPC_TAG_ZAMAKUS, oPC);
    if (GetIsObjectValid(oZamakus))
    {
        SetLocalString(oZamakus, "HF_EXIT_NAME", WP_TAG_EXIT_ALL);
        SetLocalInt(oZamakus, "HF_EXIT_RUN", 0);

        // ExecuteScript("hf_cs_exit", oZamakus);
        AssignCommand(oZamakus, ActionRandomWalk());
    }
}


void golemMarch(int nNth = 0)
{
    if ((nNth < NUM_GOLEMS) && (GetLocalInt(GetModule(), LVAR_CUTSCENE_IN_PROGRESS) > 0) )
    {
        string sGolemResRef = NPC_RESREF_GOLEMx + IntToString(nNth%3);
        object oSpawnWP = GetWaypointByTag(WP_TAG_GOLEM_SPAWN);
        object oMoveWP = GetWaypointByTag(WP_TAG_EXIT_ALL);
        object oGolem = CreateObject(OBJECT_TYPE_CREATURE, sGolemResRef, GetLocation(oSpawnWP), FALSE, NPC_TAG_GOLEM);

        SetPlotFlag(oGolem, TRUE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oGolem);
        SetLocalString(oGolem, "HF_EXIT_NAME", WP_TAG_EXIT_ALL);
        SetLocalInt(oGolem, "HF_EXIT_RUN", 0);

        //ExecuteScript("hf_cs_exit", oGolem);

        AssignCommand(oGolem, ActionForceMoveToObject(oMoveWP, FALSE));
        DelayCommand(15.0f, DestroyObject(oGolem));

        DelayCommand(4.0f, golemMarch(++nNth));
    }
}


void setupActors(object oPC)
{
    object oZamakus = CutsceneGetActor(NPC_TAG_ZAMAKUS);
    if (!GetIsObjectValid(oZamakus))
    {
        oZamakus = GetNearestObjectByTag(NPC_TAG_ZAMAKUS, oPC);

        CutsceneAddActor(NPC_TAG_ZAMAKUS, oZamakus);
    }
}


void start()
{
    object oPC = CutsceneGetPC();

    SetLocalInt(GetModule(), LVAR_CUTSCENE_IN_PROGRESS, 1);

    golemMarch();

    CutsceneStart(FALSE, FALSE, "", FALSE);
}


void abort()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;

    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
}


void end()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;

    DeleteLocalInt(GetModule(), LVAR_CUTSCENE_IN_PROGRESS);

    exitThayanOfficials(oPC);

    updateQuestEnd(oPC);
}


// Shot 0: Spawn in actors, start conversation
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorZamakus = CutsceneGetActor(NPC_TAG_ZAMAKUS);
    // Waypoints
    object oWpPlayerInit = GetWaypointByTag(WP_TAG_PLAYER_INIT);

    if (fTime == 0.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FAST);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        setupActors(oPC);

        AssignCommand(oPC, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oPC, JumpToLocation(GetLocation(oWpPlayerInit))));

        CutsceneCameraSetup(2.0, 280.0, 10.0, 70.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(4.0);
    }
    else if (fTime >= 4.0)
    {
        AssignCommand(oActorZamakus, ActionStartConversation(oPC, "tm_thayanguard", FALSE, FALSE));

        // Called from conversation (tm_thayanguard)
        //CutsceneNextShot();
    }
}


// Shot 1: Ends the cutscene
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

