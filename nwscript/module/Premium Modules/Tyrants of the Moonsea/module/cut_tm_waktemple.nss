//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_waktemple
// DATE: March 30, 2006
// AUTH: Luke Scull
// NOTE: Cutscene in Temple District
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"


const string NPC_RESREF_KAINE = "kaine";
const string NPC_TAG_KAINE = "Kaine";
const string WP_TAG_KAINE_SPAWN = "WP_cut_waktemple_kaine_spawn";
const string WP_TAG_KAINE_MOVE = "WP_cut_waktemple_kaine_move";

const string NPC_RESREF_MATTIUS = "mattius";
const string NPC_TAG_MATTIUS = "Mattius";
const string WP_TAG_MATTIUS_SPAWN = "WP_cut_waktemple_mattius_spawn";
const string WP_TAG_MATTIUS_MOVE = "WP_cut_waktemple_mattius_move";

const string NPC_RESREF_WAKSIM = "wakrathar";
const string NPC_TAG_WAKSIM = "WakRatharSimulacrum";
const string WP_TAG_WAKSIM_SPAWN = "WP_cut_waktemple_waksim_spawn";
const string WP_TAG_WAKSIM_MOVE = "WP_cut_waktemple_waksim_move";
const string WP_TAG_WAKSIM_TOWER = "WP_WakSimulacrum_Jump";

const string NPC_RESREF_PLUMEOFF = "kaine001";
const string NPC_TAG_PLUMEOFF = "RedPlumeOfficer";
const string WP_TAG_PLUMEOFF_SPAWN = "WP_cut_waktemple_plumeoff_spawn";
const string WP_TAG_PLUMEOFF_MOVE = "WP_cut_waktemple_plumeoff_move";

const string WP_TAG_PLAYER = "WP_cut_waktemple_pc_init";


void updateQuest(object oPC)
{
    AddJournalQuestEntry("CrazedOldMan", 32, oPC);
}


void setupActors(object oPC)
{
    CutsceneSpawnActor(NPC_RESREF_KAINE, NPC_TAG_KAINE, WP_TAG_KAINE_SPAWN);
    CutsceneSpawnActor(NPC_RESREF_MATTIUS, NPC_TAG_MATTIUS, WP_TAG_MATTIUS_SPAWN);
    CutsceneSpawnActor(NPC_RESREF_WAKSIM, NPC_TAG_WAKSIM, WP_TAG_WAKSIM_SPAWN);
    CutsceneSpawnActor(NPC_RESREF_PLUMEOFF, NPC_TAG_PLUMEOFF, WP_TAG_PLUMEOFF_SPAWN);
}


void start()
{
    object oPC = CutsceneGetPC();

    CutsceneStart(FALSE, FALSE, "", FALSE);
}


void abort()
{
    object oPC = CutsceneGetPC();
    object oWaypoint = OBJECT_INVALID;
    object oActor = OBJECT_INVALID;

    setupActors(oPC);

    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));

    // Remove Red Plumes, if they are still around
    oActor = CutsceneGetActor(NPC_TAG_KAINE);
    if (GetIsObjectValid(oActor))
        DestroyObject(oActor);
    oActor = CutsceneGetActor(NPC_TAG_MATTIUS);
    if (GetIsObjectValid(oActor))
        DestroyObject(oActor);
    oActor = CutsceneGetActor(NPC_TAG_PLUMEOFF);
    if (GetIsObjectValid(oActor))
        DestroyObject(oActor);

    // Jump Wak Rathar to his Tower
    oActor = CutsceneGetActor(NPC_TAG_WAKSIM);
    if (GetArea(oActor) == GetArea(oPC))
    {
        oWaypoint = GetWaypointByTag(WP_TAG_WAKSIM_TOWER);
        AssignCommand(oActor, ClearAllActions(TRUE));
        AssignCommand(oActor, ActionCastFakeSpellAtObject(SPELL_CURE_MINOR_WOUNDS, oActor, PROJECTILE_PATH_TYPE_DEFAULT));
        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1), oActor));
        DelayCommand(1.0, AssignCommand(oActor, ActionJumpToLocation(GetLocation(oWaypoint))));
    }
}


void end()
{
    object oPC = CutsceneGetPC();
    updateQuest(oPC);

    object oWak = CutsceneGetActor(NPC_TAG_WAKSIM);
    SetLocalInt(oWak, "nBusy" , 1);
}


// Shot 0: Initiate Dialog
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorKaine = CutsceneGetActor(NPC_TAG_KAINE);
    object oActorMattius = CutsceneGetActor(NPC_TAG_MATTIUS);
    object oActorWaksim = CutsceneGetActor(NPC_TAG_WAKSIM);
    // Waypoint
    object oWpPlayer = GetWaypointByTag(WP_TAG_PLAYER);
    object oWpKaineMove = GetWaypointByTag(WP_TAG_KAINE_MOVE);
    object oWpMattiusMove = GetWaypointByTag(WP_TAG_MATTIUS_MOVE);
    object oWpWaksimMove = GetWaypointByTag(WP_TAG_WAKSIM_MOVE);

    if (fTime == 0.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FASTEST);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // Setup during black screen
        setupActors(oPC);

        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionJumpToObject(oWpPlayer));

        CutsceneCameraSetup(2.0, 0.0, 7.0, 50.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneCameraSetup(2.0, 25.0, 5.0, 85.0, CAMERA_TRANSITION_TYPE_VERY_SLOW);
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oActorKaine, ActionMoveToObject(oWpKaineMove, FALSE));
        AssignCommand(oActorMattius, ActionMoveToObject(oWpMattiusMove, FALSE));
        AssignCommand(oActorWaksim, ActionMoveToObject(oWpWaksimMove, FALSE, 0.3));

        CutsceneNext(8.0);
    }
    else if (fTime >= 8.0)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oActorWaksim, 3.0f);
        AssignCommand(oActorWaksim, ActionStartConversation(oPC, "", FALSE, FALSE));

        // Called from dialog
        //CutsceneNextShot();
    }
}


// Shot 1: Pauses conversation, moves Red Plume Officer to join conversation
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorPlumeOfficer = CutsceneGetActor(NPC_TAG_PLUMEOFF);
    // Waypoints
    object oWpPlumeOffMove = GetWaypointByTag(WP_TAG_PLUMEOFF_MOVE);

    if (fTime == 0.0)
    {
        AssignCommand(oPC, ActionPauseConversation());
        AssignCommand(oActorPlumeOfficer, ActionMoveToObject(oWpPlumeOffMove, FALSE, 0.2));

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oPC, ActionResumeConversation());

        // Called from conversation
        // CutsceneNextShot();
    }
}


// Shot 2: Red Plumes leave, Wak Rathar teleports away
void next2(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorKaine = CutsceneGetActor(NPC_TAG_KAINE);
    object oActorMattius = CutsceneGetActor(NPC_TAG_MATTIUS);
    object oActorWak = CutsceneGetActor(NPC_TAG_WAKSIM);
    object oActorPlumeOfficer = CutsceneGetActor(NPC_TAG_PLUMEOFF);
    // Waypoint
    object oWaksimTeleportWP = GetWaypointByTag(WP_TAG_WAKSIM_TOWER);

    if (fTime == 0.0)
    {
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        AssignCommand(oActorWak, ActionCastFakeSpellAtObject(SPELL_CURE_MINOR_WOUNDS, oActorWak, PROJECTILE_PATH_TYPE_DEFAULT));

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1), oActorWak);
        AssignCommand(oActorWak, ActionJumpToLocation(GetLocation(oWaksimTeleportWP)));
        SetLocalInt(oActorWak, "nBusy" , 1);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        SetLocalInt(oActorKaine, "HF_EXIT_RUN", 1);
        ExecuteScript("hf_cs_exit", oActorKaine);

        SetLocalInt(oActorMattius, "HF_EXIT_RUN", 1);
        ExecuteScript("hf_cs_exit", oActorMattius);

        SetLocalInt(oActorPlumeOfficer, "HF_EXIT_RUN", 1);
        ExecuteScript("hf_cs_exit", oActorPlumeOfficer);

        FadeToBlack(oPC, FADE_SPEED_FASTEST);

        CutsceneNext(6.0);
    }
    else if (fTime >= 6.0)
    {
        CutsceneNextShot();
    }
}


// Shot 3: End Cutscene
void next3(float fTime)
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
        if (nShot == 1) next1(fTime);
        if (nShot == 2) next2(fTime);
        if (nShot >= 3) next3(fTime);
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

