//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_thayanam1
//:: DATE: January 28, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Thayan Ambassador
//:: Cutscene in Red Wizard Enclave: Golem attack
//::////////////////////////////////////////////////////

#include "nw_i0_generic"

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "hf_in_util"


// Lock the door so no one can leave until the fight is over
const string DOOR_TAG_ENCLAVE_EXIT = "RedWizEnclaveOUT";

const string NPC_RESREF_ZAMAKUS = "captainzamakus";
const string NPC_TAG_ZAMAKUS = "CaptainZamakus";
const string WP_TAG_ZAMAKUS_INIT = "WP_cut_thayanam1_zamakus_init";
const string WP_TAG_ZAMAKUS_OUTSIDE = "WP_cut_thayanam0_zama_jump";

const string NPC_RESREF_SELFARIL = "tm_cr_selfaril0";
const string NPC_TAG_SELFARIL = "tm_cr_selfaril0";
const string WP_TAG_SELFARIL_SPAWN = "WP_cut_thayanam1_selfaril_spawn";

const string NPC_RESREF_DMITRA = "tm_cr_dmitra0";
const string NPC_TAG_DMITRA = "tm_cr_dmitra0";
const string WP_TAG_DMITRA_SPAWN = "WP_cut_thayanam1_dmitra_spawn";

const string NPC_RESREF_AMBASSADOR = "redwizardambassa";
const string NPC_TAG_AMBASSADOR = "RedWizardAmbassador";
const string WP_TAG_AMBASSADOR_SPAWN = "WP_cut_thayanam1_amba_spawn";
const string WP_TAG_AMBASSADOR_MOVE = "WP_cut_thayanam1_amba_move";
const string WP_TAG_AMBASSADOR_FLEE = "WP_cut_thayanam1_amba_flee";

// Gem golems, resref will be read from spawn waypoints
const string NPC_TAG_GOLEMx = "CR_cut_thayanam1_golem";
const string WP_TAG_GOLEMx_SPAWN = "WP_cut_thayanam1_golem_spawn";
const string WP_TAG_GOLEMx_MOVE = "WP_cut_thayanam1_golem_move";

const string WP_TAG_PLAYER_INIT = "WP_cut_thayanam1_pc_init";
const string WP_TAG_PLAYER_JUMP = "WP_cut_thayanam1_pc_jump";


void updateQuestEnd(object oPC)
{
    AddJournalQuestEntry("ThayanAmbassadors", 30, oPC);
    PlotLevelSet("thayanam_status", 3);
}


void golemSpawn()
{
    int i = 0;
    string sGolemResRef = "";
    string sGolemWp = WP_TAG_GOLEMx_SPAWN + IntToString(i);
    while (GetIsObjectValid(GetWaypointByTag(sGolemWp)))
    {
        sGolemResRef = GetLocalString(GetWaypointByTag(sGolemWp), "resref");

        CutsceneSpawnActor(sGolemResRef, NPC_TAG_GOLEMx + IntToString(i), sGolemWp);
        i++;
        sGolemWp = WP_TAG_GOLEMx_SPAWN + IntToString(i);
    }
}


void golemMove()
{
    int i = 0;
    object oActorGolem = CutsceneGetActor(NPC_TAG_GOLEMx + IntToString(i));
    object oWpGolem = GetWaypointByTag(WP_TAG_GOLEMx_MOVE + IntToString(i));
    while (GetIsObjectValid(oWpGolem))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oActorGolem, 12.0);
        AssignCommand(oActorGolem, ActionMoveToObject(oWpGolem, FALSE));

        i++;
        oActorGolem = CutsceneGetActor(NPC_TAG_GOLEMx + IntToString(i));
        oWpGolem = GetWaypointByTag(WP_TAG_GOLEMx_MOVE + IntToString(i));
    }
}


void golemJumpFinal()
{
    int i = 0;
    object oActorGolem = CutsceneGetActor(NPC_TAG_GOLEMx + IntToString(i));
    object oWpGolem = GetWaypointByTag(WP_TAG_GOLEMx_MOVE + IntToString(i));
    while (GetIsObjectValid(oWpGolem))
    {
        AssignCommand(oActorGolem, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oActorGolem, JumpToLocation(GetLocation(oWpGolem))));

        i++;
        oActorGolem = CutsceneGetActor(NPC_TAG_GOLEMx + IntToString(i));
        oWpGolem = GetWaypointByTag(WP_TAG_GOLEMx_MOVE + IntToString(i));
    }
}


void golemTurn()
{
    int i = 0;
    effect eVFX = EffectVisualEffect(VFX_IMP_HEAD_ODD);
    object oGolem = CutsceneGetActor(NPC_TAG_GOLEMx + IntToString(i));
    object oWpGolem = GetWaypointByTag(WP_TAG_GOLEMx_MOVE + IntToString(i));
    while (GetIsObjectValid(oWpGolem))
    {
        AssignCommand(oGolem, ActionDoCommand(SetFacing(GetFacing(oWpGolem))));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oGolem);

        i++;
        oGolem = CutsceneGetActor(NPC_TAG_GOLEMx + IntToString(i));
        oWpGolem = GetWaypointByTag(WP_TAG_GOLEMx_MOVE + IntToString(i));
    }
}


void golemAttack(object oPC)
{
    object oWpAmbassador = GetWaypointByTag(WP_TAG_AMBASSADOR_FLEE);
    object oAmbassador = GetObjectInArea(NPC_TAG_AMBASSADOR, oWpAmbassador);
    AssignCommand(oAmbassador, ClearAllActions(TRUE));
    DelayCommand(1.0f, AssignCommand(oAmbassador, ActionMoveToObject(oWpAmbassador, TRUE, 3.0f)));

    int i = 0;
    object oGolem = GetObjectByTag(NPC_TAG_GOLEMx + IntToString(i));
    while (GetIsObjectValid(oGolem))
    {
        ExecuteScript("hf_ut_hostile", oGolem);

        i++;
        oGolem = GetObjectByTag(NPC_TAG_GOLEMx + IntToString(i));
    }

    object oSelfaril = GetNearestObjectByTag(NPC_TAG_SELFARIL, oPC);
    DelayCommand(1.0f, AssignCommand(oSelfaril, DetermineCombatRound()));

    object oDmitra = GetNearestObjectByTag(NPC_TAG_DMITRA, oPC);
    DelayCommand(1.0f, AssignCommand(oDmitra, DetermineCombatRound()));
}


void setupActors(object oPC)
{
    object oDoor = OBJECT_INVALID;

    CutsceneSpawnActor(NPC_RESREF_SELFARIL, NPC_TAG_SELFARIL, WP_TAG_SELFARIL_SPAWN);
    CutsceneSpawnActor(NPC_RESREF_DMITRA, NPC_TAG_DMITRA, WP_TAG_DMITRA_SPAWN);
    CutsceneSpawnActor(NPC_RESREF_AMBASSADOR, NPC_TAG_AMBASSADOR, WP_TAG_AMBASSADOR_SPAWN);

    object oActorZamakus = CutsceneGetActor(NPC_TAG_ZAMAKUS);
    if (!GetIsObjectValid(oActorZamakus))
    {
        object oOldZamakus = OBJECT_INVALID;
        object oZamakusWP = OBJECT_INVALID;

        // Delete old Zamakus in Front of Enclave
        oZamakusWP = GetWaypointByTag(WP_TAG_ZAMAKUS_OUTSIDE);
        oOldZamakus = GetNearestObjectByTag(NPC_TAG_ZAMAKUS, oZamakusWP);
        if (GetIsObjectValid(oOldZamakus))
            DestroyObject(oOldZamakus);

        // Create new one inside the enclave
        oZamakusWP = GetWaypointByTag(WP_TAG_ZAMAKUS_INIT);
        oActorZamakus = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_ZAMAKUS, GetLocation(oZamakusWP));
        CutsceneAddActor(NPC_TAG_ZAMAKUS, oActorZamakus);
    }

    // make sure the door is locked to prevent the PC from leaving
    oDoor = GetObjectByTag(DOOR_TAG_ENCLAVE_EXIT);
    AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
    DelayCommand(1.0f, SetLocked(oDoor, TRUE));

    golemSpawn();
}


void start()
{
    object oPC = CutsceneGetPC();

    CutsceneStart(TRUE, FALSE, "", TRUE);
}


void abort()
{
    object oPC = CutsceneGetPC();

    BlackScreen(oPC);
    setupActors(oPC);

    golemJumpFinal();

    object oAmbassadorWP = GetWaypointByTag(WP_TAG_AMBASSADOR_MOVE);
    object oAmbassador = GetObjectInArea(NPC_TAG_AMBASSADOR, oAmbassadorWP);
    AssignCommand(oAmbassador, ClearAllActions(TRUE));
    DelayCommand(0.5f, AssignCommand(oAmbassador, JumpToLocation(GetLocation(oAmbassadorWP))));

    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
}


void end()
{
    object oPC = CutsceneGetPC();

    DelayCommand(2.0f, golemAttack(oPC));
}


// Shot 0: Spawn in actors, start conversation
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorAmbassador = CutsceneGetActor(NPC_TAG_AMBASSADOR);
    // Waypoints
    object oWpPlayerJump = GetWaypointByTag(WP_TAG_PLAYER_JUMP);
    object oWpAmbassadorMove = GetWaypointByTag(WP_TAG_AMBASSADOR_MOVE);

    if (fTime == 0.0)
    {
        // Cutscene starts after area transistion: Immediate Black screen
        BlackScreen(oPC);

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        setupActors(oPC);

        AssignCommand(oPC, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oPC, JumpToLocation(GetLocation(oWpPlayerJump))));

        CutsceneCameraSetup(2.0, 0.0, 8.0, 70.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        AssignCommand(oActorAmbassador, ActionMoveToObject(oWpAmbassadorMove));

        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        golemMove();

        CutsceneNext(12.0);
    }
    else if (fTime >= 12.0)
    {
        AssignCommand(oActorAmbassador, ActionStartConversation(oPC, "tm_ambassador", FALSE, FALSE));

        // Called from conversation (tm_abassador)
        //CutsceneNextShot();
    }
}


// Shot 1:
void next1(float fTime)
{
    if (fTime >= 0.0)
    {
        golemTurn();

        // Called from conversation (tm_abassador)
        //CutsceneNextShot();
    }
}


// Shot 2: Ends the cutscene (Golems attack)
void next2(float fTime)
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
        if (nShot >= 2) next2(fTime);
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
