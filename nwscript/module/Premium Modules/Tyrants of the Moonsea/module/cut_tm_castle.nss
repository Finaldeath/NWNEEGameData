//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_castle
// DATE: 1 April, 2006
// AUTH: Luke Scull
// NOTE: Castle Maalthiir cutscene
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"
#include "hf_in_worldmap"
#include "hf_in_plot"


const string WP_TAG_PLAYER_ARRIVE = "WP_hfcastle_throne_south";
const string WP_TAG_PLAYER_MOVE1 = "WP_hfcastle_throne_move1";
const string WP_TAG_PLAYER_GLADIATORPIT = "WP_cut_arena_pc_init";

const string NPC_TAG_MAALTHIR = "Maalthiir";
const string WP_TAG_MAALTHIR_INIT = "WP_hfcastle_maalthiir";

const string NPC_TAG_PLUME1 = "hfcastle_redplume8";
const string NPC_TAG_PLUME2 = "hfcastle_redplume5";
const string NPC_TAG_PLUME3 = "hfcastle_redplume3";

const string NPC_RESREF_PLUMEOFF = "kaine001";
const string NPC_TAG_PLUMEOFF = "RedPlumeOfficer";
const string WP_TAG_PLUMEOFF_SPAWN = "WP_hfcastle_plumeoff_spawn";
const string WP_TAG_PLUMEOFF_MOVE1 = "WP_hfcastle_plumeoff_move1";
const string WP_TAG_PLUMEOFF_MOVE2 = "WP_hfcastle_plumeoff_move2";

const string LVAR_QUEST_UPDATE_DONCE = "cut_castle_donce";


void setupCameraA(object oPC)
{
    AssignCommand(oPC, SetCameraFacing(110.0, 9.0, 50.0, CAMERA_TRANSITION_TYPE_SNAP));
    AssignCommand(oPC, StoreCameraFacing());
}


void setupCameraB(object oPC)
{
    AssignCommand(oPC, SetCameraFacing(90.0, 1.0, 89.0, CAMERA_TRANSITION_TYPE_SNAP));
    SetCameraHeight(oPC, 1.8);
}


// Updates quest at shot 0
void updateQuestStart(object oPC)
{
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 1)
    {
        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 1);

        if (PlotLevelGet(NPC_TAG_MAALTHIR) < 1)
            PlotLevelSet(NPC_TAG_MAALTHIR, 1);
    }
}


// Updates quest at shot 2
void updateQuest2(object oPC)
{
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 2)
    {
        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 2);

        AddJournalQuestEntry("OrderoftheCrippledFang", 35, oPC);
        UnlockMapLocation("Elventree");
    }
}


void updateQuestEnd(object oPC)
{
    int nXP;

    SetLocalInt(oPC, "hillsfarpass", 1);
    //Update journal and award quest completion xp
    AddJournalQuestEntry("TheCityofHillsfar", 50, oPC);
    nXP = GetJournalQuestExperience("TheCityofHillsfar");
    GiveXPToCreature(oPC, nXP);
}


void setupActors(object oPC)
{
    object oActor;
    object oWaypoint;

    CutsceneSpawnActor(NPC_RESREF_PLUMEOFF, NPC_TAG_PLUMEOFF, WP_TAG_PLUMEOFF_SPAWN);

    // May not be in the current area
    if (!GetIsObjectValid(CutsceneGetActor(NPC_TAG_MAALTHIR)))
    {
        oActor = GetObjectByTag(NPC_TAG_MAALTHIR);
        oWaypoint = GetWaypointByTag(WP_TAG_MAALTHIR_INIT);
        AssignCommand(oActor, ClearAllActions());
        AssignCommand(oActor, ActionJumpToLocation(GetLocation(oWaypoint)));
        CutsceneAddActor(NPC_TAG_MAALTHIR, oActor);
    }
}


void start()
{
    object oPC = CutsceneGetPC();

    updateQuestStart(oPC);

    CutsceneStart(FALSE, FALSE, "", FALSE);
}


void abort()
{
    object oPC = CutsceneGetPC();

    object oActorMaalthir = CutsceneGetActor(NPC_TAG_MAALTHIR);
    AssignCommand(oActorMaalthir, ClearAllActions(TRUE));

    AssignCommand(oPC, ActionResumeConversation());
}


void end()
{
    object oPC = CutsceneGetPC();
    object oWaypoint = GetWaypointByTag(WP_TAG_PLAYER_GLADIATORPIT);

    updateQuest2(oPC);
    updateQuestEnd(oPC);

    FadeToBlack(oPC, FADE_SPEED_MEDIUM);

    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));

    // Prepare camera for cutscene to prevent weirdness in the narrow corridor
    DelayCommand(2.0, setupCameraA(oPC));
    DelayCommand(3.0, setupCameraB(oPC));
    // Jump player back to arena
    DelayCommand(4.0, AssignCommand(oPC, JumpToObject(oWaypoint)));

    DeleteLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE);
}


// Shot 0: Player walks towards Maalthir and initiates conversation
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorMaalthir = CutsceneGetActor(NPC_TAG_MAALTHIR);
    // Waypoints
    object oPlayerArriveWP = GetWaypointByTag(WP_TAG_PLAYER_ARRIVE);
    object oPlayerMove1WP = GetWaypointByTag(WP_TAG_PLAYER_MOVE1);

    if (fTime == 0.0)
    {
        // Immediate Blackscreen as we start directly after area load
        BlackScreen(oPC);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // During Blackscreen
        setupActors(oPC);

        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionJumpToObject(oPlayerArriveWP));
        CutsceneCameraSetup(2.0, 90.0, 7.0, 65.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oPC, ActionMoveToLocation(GetLocation(oPlayerMove1WP), FALSE));

        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        //cs_CameraSetFacing(1.0, 90.0, 2.5, 65.0, CAMERA_TRANSITION_TYPE_MEDIUM, OBJECT_SELF, 1);
        CutsceneCameraSetup(2.0, 90.0, 4.0, 65.0, CAMERA_TRANSITION_TYPE_VERY_SLOW);

        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oActorMaalthir, 3.0f);
        AssignCommand(oActorMaalthir, ClearAllActions(TRUE));
        AssignCommand(oActorMaalthir, ActionStartConversation(oPC, "", FALSE, FALSE));

        // Called from dialog
        //CutsceneNextShot();
    }
}


// Shot 1: Pauses conversation, kills three red plumes
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorPlume1 = CutsceneGetActor(NPC_TAG_PLUME1);
    object oActorPlume2 = CutsceneGetActor(NPC_TAG_PLUME2);
    object oActorPlume3 = CutsceneGetActor(NPC_TAG_PLUME3);

    if (fTime == 0.0)
    {
        AssignCommand(oPC, ActionPauseConversation());
        FadeToBlack(oPC, FADE_SPEED_FAST);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oPC, PlaySound("cb_sw_blade1"));
        DelayCommand(0.5, AssignCommand(oPC, PlaySound("vs_nclerkm1_dead")));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oActorPlume1);

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oPC, PlaySound("cb_sw_bladehi2"));
        DelayCommand(0.5, AssignCommand(oPC, PlaySound("vs_ndesthem_dead")));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oActorPlume2);

        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oPC, PlaySound("cb_sw_bladelow2"));
        DelayCommand(0.5, AssignCommand(oPC, PlaySound("vs_ndruidm1_dead")));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oActorPlume3);

        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        AssignCommand(oPC, ActionResumeConversation());

        // Called from conversation
        //CutsceneNextShot();
    }
}


// Shot 2: Pauses conversation, moves Red Plume Officer to join conversation
void next2(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorMaalthir = CutsceneGetActor(NPC_TAG_MAALTHIR);
    object oActorPlumeOff = CutsceneGetActor(NPC_TAG_PLUMEOFF);
    // Waypoints
    object oPlumeOffMove01WP = GetWaypointByTag(WP_TAG_PLUMEOFF_MOVE1);
    object oPlumeOffMove02WP = GetWaypointByTag(WP_TAG_PLUMEOFF_MOVE2);

    if (fTime == 0.0)
    {
        updateQuest2(oPC);

        AssignCommand(oPC, ActionPauseConversation());
        AssignCommand(oActorPlumeOff, ActionJumpToObject(oPlumeOffMove01WP, FALSE));

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        AssignCommand(oActorPlumeOff, ActionMoveToObject(oPlumeOffMove02WP, FALSE, 0.2));

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oPC, ActionResumeConversation());

        // Called from conversation
        //CutsceneNextShot();
    }
}


// Shot 3: Ends conversation
void next3(float fTime)
{
    if (fTime == 0.0)
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
