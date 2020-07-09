//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_thayanam2
//:: DATE: January 28, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Thayan Ambassador
//:: Cutscene in Red Wizard Enclave: Selfaril Audience
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "hf_in_util"


// Open the door so the player can leave
const string DOOR_TAG_ENCLAVE_EXIT = "RedWizEnclaveOUT";
const string DOOR_TAG_ENCLAVE_ENTRANCE = "RedWizEnclaveIN";

const string NPC_TAG_SELFARIL = "tm_cr_selfaril0";
const string WP_TAG_SELFARIL_INIT = "WP_cut_thayanam2_selfa_init";
const string WP_TAG_SELFARIL_JUMP = "WP_cut_thayanam2_selfa_jump";

const string NPC_TAG_DMITRA = "tm_cr_dmitra0";
const string WP_TAG_DMITRA_INIT = "WP_cut_thayanam2_dmitra_init";

const string NPC_TAG_ZAMAKUS = "CaptainZamakus";
const string WP_TAG_ZAMAKUS_INIT = "WP_cut_thayanam2_zama_init";

const string NPC_RESREF_AMBASSADOR = "redwizardambassa";
const string NPC_TAG_AMBASSADOR = "RedWizardAmbassador";
const string WP_TAG_AMBASSADOR_INIT = "WP_cut_thayanam2_amba_init";

const string WP_TAG_PLAYER_INIT = "WP_cut_thayanam2_pc_init";
const string WP_TAG_PLAYER_JUMP = "WP_cut_thayanam2_pc_jump";


void updateQuestEnd(object oPC)
{
    AddJournalQuestEntry("ThayanAmbassadors", 50, oPC);
    GiveXPToCreature(oPC, GetJournalQuestExperience("ThayanAmbassadors"));

    PlotLevelSet("thayanam_status", 5);

    // Set Selfaril dialog level in case the cutscene was skipped
    PlotLevelSet(NPC_TAG_SELFARIL, 2);
}


void setupActors(object oPC)
{
    object oAmbassador = CutsceneGetActor(NPC_TAG_AMBASSADOR);
    if (!GetIsObjectValid(oAmbassador))
    {
        object oAmbassadorWP = GetWaypointByTag(WP_TAG_AMBASSADOR_INIT);
        oAmbassador = GetObjectInArea(NPC_TAG_AMBASSADOR, oAmbassadorWP);
        if (!GetIsObjectValid(oAmbassador))
            oAmbassador = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_AMBASSADOR, GetLocation(oAmbassadorWP));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oAmbassador, 10.0f);
        AssignCommand(oAmbassador, ClearAllActions(TRUE));
        CutsceneAddActor(NPC_TAG_AMBASSADOR, oAmbassador);
    }

    object oSelfaril = CutsceneGetActor(NPC_TAG_SELFARIL);
    if (!GetIsObjectValid(oSelfaril))
    {
        object oSelfarilWP = GetWaypointByTag(WP_TAG_SELFARIL_INIT);
        oSelfaril = GetObjectInArea(NPC_TAG_SELFARIL, oSelfarilWP);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oSelfaril, 10.0f);
        AssignCommand(oSelfaril, ClearAllActions(TRUE));
        CutsceneAddActor(NPC_TAG_SELFARIL, oSelfaril);
    }

    object oDmitra = CutsceneGetActor(NPC_TAG_DMITRA);
    if (!GetIsObjectValid(oDmitra))
    {
        object oDmitraWP = GetWaypointByTag(WP_TAG_DMITRA_INIT);
        oDmitra = GetObjectInArea(NPC_TAG_DMITRA, oDmitraWP);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oDmitra, 10.0f);
        AssignCommand(oDmitra, ClearAllActions(TRUE));
        CutsceneAddActor(NPC_TAG_DMITRA, oDmitra);
    }

    object oZamakus = CutsceneGetActor(NPC_TAG_ZAMAKUS);
    if (!GetIsObjectValid(oZamakus))
    {
        object oZamakusWP = GetWaypointByTag(WP_TAG_ZAMAKUS_INIT);
        oZamakus = GetObjectInArea(NPC_TAG_ZAMAKUS, oZamakusWP);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oZamakus, 10.0f);
        AssignCommand(oZamakus, ClearAllActions(TRUE));
        CutsceneAddActor(NPC_TAG_ZAMAKUS, oZamakus);
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

    BlackScreen(oPC);
    setupActors(oPC);

    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));

    object oZamakus = CutsceneGetActor(NPC_TAG_ZAMAKUS);
    if (GetIsObjectValid(oZamakus))
        DestroyObject(oZamakus);

    object oDmitra = CutsceneGetActor(NPC_TAG_DMITRA);
    if (GetIsObjectValid(oDmitra))
        DestroyObject(oDmitra);

    object oAmbassador = CutsceneGetActor(NPC_TAG_AMBASSADOR);
    if (GetIsObjectValid(oAmbassador))
        DestroyObject(oAmbassador);
}


void end()
{
    object oPC = CutsceneGetPC();

    updateQuestEnd(oPC);

    // Unlock the door, PC is allowed to leave now
    object oDoorA = GetObjectByTag(DOOR_TAG_ENCLAVE_EXIT);
    SetLocked(oDoorA, FALSE);
    object oDoorB = GetObjectByTag(DOOR_TAG_ENCLAVE_ENTRANCE);
    SetLocked(oDoorB, FALSE);
}


// Shot 0: Selfaril initiates conversation
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorSelfaril = CutsceneGetActor(NPC_TAG_SELFARIL);
    object oActorAmbassador = CutsceneGetActor(NPC_TAG_AMBASSADOR);
    object oActorZamakus = CutsceneGetActor(NPC_TAG_ZAMAKUS);
    object oActorDmitra = CutsceneGetActor(NPC_TAG_DMITRA);
    // Waypoints
    object oWpPlayerInit = GetWaypointByTag(WP_TAG_PLAYER_INIT);
    object oWpAmbassadorInit = GetWaypointByTag(WP_TAG_AMBASSADOR_INIT);
    object oWpDmitraInit = GetWaypointByTag(WP_TAG_DMITRA_INIT);
    object oWpSelfarilInit = GetWaypointByTag(WP_TAG_SELFARIL_INIT);
    object oWpZamakusInit = GetWaypointByTag(WP_TAG_ZAMAKUS_INIT);


    if (fTime == 0.0)
    {
        BlackScreen(oPC);  // Fade done in ndt_tm_thaygolem

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        setupActors(oPC);

        AssignCommand(oPC, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oPC, JumpToLocation(GetLocation(oWpPlayerInit))));

        CutsceneCameraSetup(0.0, 120.0, 8.0, 70.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oActorAmbassador, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oActorAmbassador, JumpToLocation(GetLocation(oWpAmbassadorInit))));

        AssignCommand(oActorDmitra, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oActorDmitra, JumpToLocation(GetLocation(oWpDmitraInit))));

        AssignCommand(oActorSelfaril, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oActorSelfaril, JumpToLocation(GetLocation(oWpSelfarilInit))));

        AssignCommand(oActorZamakus, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oActorZamakus, JumpToLocation(GetLocation(oWpZamakusInit))));

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(4.0);
    }
    else if (fTime >= 4.0)
    {
        AssignCommand(oActorSelfaril, ActionStartConversation(oPC, "tm_selfaril", FALSE, FALSE));

        // Called from conversation (tm_selfaril)
        //CutsceneNextShot();
    }
}


// Shot 1: Selfaril orders Ambassador to be taken away, Dmitra leaves
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorAmbassador = CutsceneGetActor(NPC_TAG_AMBASSADOR);
    object oActorZamakus = CutsceneGetActor(NPC_TAG_ZAMAKUS);
    // Waypoints
    object oWpPlayerInit = GetWaypointByTag(WP_TAG_PLAYER_INIT);

    if (fTime == 0.0)
    {
        ExecuteScript("hf_cs_exit", oActorAmbassador);

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        ExecuteScript("hf_cs_exit", oActorZamakus);

        // Called from conversation (tm_selfaril)
        //CutsceneNextShot();
    }
}


// Shot 2: Audience with Selfaril
void next2(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorDmitra = CutsceneGetActor(NPC_TAG_DMITRA);
    object oActorSelfaril = CutsceneGetActor(NPC_TAG_SELFARIL);
    // Waypoints
    object oWpPlayerJump = GetWaypointByTag(WP_TAG_PLAYER_JUMP);
    object oWpSelfarilJump = GetWaypointByTag(WP_TAG_SELFARIL_JUMP);

    if (fTime == 0.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FAST);

        ExecuteScript("hf_cs_exit", oActorDmitra);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
        DelayCommand(1.0f, AssignCommand(oPC, JumpToLocation(GetLocation(oWpPlayerJump))));

        AssignCommand(oActorSelfaril, ClearAllActions(TRUE));
        DelayCommand(1.0f, AssignCommand(oActorSelfaril, JumpToLocation(GetLocation(oWpSelfarilJump))));

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(6.0);
    }
    else if (fTime >= 6.0)
    {
        AssignCommand(oActorSelfaril, ActionStartConversation(oPC, "tm_selfaril", FALSE, FALSE));

        // Called from conversation (tm_selfaril)
        //CutsceneNextShot();
    }
}


// Shot 3: Ends the cutscene
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
