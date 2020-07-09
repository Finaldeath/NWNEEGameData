//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Cutscene for "Elf In Chains" Quest
//::////////////////////////////////////////////////////
//:: First cutscene, trying to buy to Elf
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"
#include "hf_in_plot"


const string NPC_TAG_ELF = "Elf";

const string NPC_TAG_CREEL = "SlavemasterCreel";
const string WP_TAG_CREEL_INIT = "WP_cut_elfchain_creel_0";
const string WP_TAG_CREEL_TALK = "WP_cut_elfchain_creel_1";

const string WP_TAG_PLAYER_INIT = "WP_cut_elfchain_pc_0";
const string WP_TAG_PLAYER_TALK = "WP_cut_elfchain_pc_1";

const string LVAR_QUEST_UPDATE_DONCE = "cut_elfchain0_donce";


// Updates Quest at shot 0
void updateQuest0(object oPC)
{
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) <= 0)
    {
        // Setup Creels dialog: Try to buy Elf
        PlotLevelSet(NPC_TAG_CREEL, 2);
    }
}


// Updates Quest at shot 1
void updateQuest1(object oPC)
{
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 1)
    {
        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 1);

        // Setup Creels dialog: Apologizes to PC for Elfs behaviour
        PlotLevelSet(NPC_TAG_CREEL, 3);
        // PC knows all slaves have to be bought
        PlotLevelSet("ElfInChains-Status", 2);
    }
}


// Updates Quest at end
void updateQuestEnd(object oPC)
{
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 2)
    {
        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 2);

        // Reset Creels dialog to standard responses
        PlotLevelSet(NPC_TAG_CREEL, 1);
    }
}


void setupActors(object oPC)
{
    object oActorCreel = GetObjectInArea(NPC_TAG_CREEL, oPC);
    CutsceneAddActor(NPC_TAG_CREEL, oActorCreel);

    object oActorElf = GetObjectInArea(NPC_TAG_ELF, oPC);
    CutsceneAddActor(NPC_TAG_ELF, oActorElf);
}


void start()
{
    object oPC = CutsceneGetPC();

    CutsceneStart(FALSE, FALSE, "", FALSE);
}


void abort()
{
    object oPC = CutsceneGetPC();
    setupActors(oPC);

    updateQuest0(oPC);
    updateQuest1(oPC);

    object oActorCreel = GetObjectInArea(NPC_TAG_CREEL, oPC);
    object oWpCreel = GetWaypointByTag(WP_TAG_CREEL_INIT);
    AssignCommand(oActorCreel, ClearAllActions(TRUE));
    DelayCommand(0.5f, AssignCommand(oActorCreel, JumpToLocation(GetLocation(oWpCreel))));
}


void end()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;
    updateQuestEnd(oPC);

    // Creel leaves, if slaves have been bought
    if (PlotLevelCheckEquals("ElfInChains-Status", 4))
    {
        oActor = CutsceneGetActor(NPC_TAG_CREEL);
        ExecuteScript("hf_cs_exit", oActor);
    }
}


// Shot 0: Initiate 1st dialog with Creel
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorCreel = CutsceneGetActor(NPC_TAG_CREEL);
    // Waypoints
    object oWpPlayer = GetObjectInArea(WP_TAG_PLAYER_TALK, oPC);
    object oWpCreel = GetObjectInArea(WP_TAG_CREEL_TALK, oPC);

    if (fTime == 0.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FAST);

        updateQuest0(oPC);
        setupActors(oPC);

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oActorCreel, ClearAllActions(TRUE));

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oPC, JumpToLocation(GetLocation(oWpPlayer)));
        AssignCommand(oActorCreel, JumpToLocation(GetLocation(oWpCreel)));

        CutsceneCameraSetup(0.0, 210.0, 7.0, 70.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(4.0);
    }
    else if (fTime >= 4.0)
    {
        AssignCommand(oActorCreel, ClearAllActions());
        AssignCommand(oActorCreel, ActionStartConversation(oPC, "", FALSE, FALSE));

        // Called from conversation
        //CutsceneNextShot();
    }
}


// Shot 1: Start walking back to original location
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorCreel = CutsceneGetActor(NPC_TAG_CREEL);
    // Waypoints
    object oWpPlayer = GetObjectInArea(WP_TAG_PLAYER_INIT, oPC);
    object oWpCreel = GetObjectInArea(WP_TAG_CREEL_INIT, oPC);

    if (fTime == 0.0)
    {
        updateQuest1(oPC);

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        AssignCommand(oActorCreel, ClearAllActions());
        AssignCommand(oActorCreel, ActionMoveToLocation(GetLocation(oWpCreel), FALSE));

        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionMoveToLocation(GetLocation(oWpPlayer), FALSE));

        CutsceneNext(8.0);
    }
    else if (fTime >= 8.0)
    {
        CutsceneNextShot();
    }
}


// Shot 2: Re-Initate Dialog
void next2(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorCreel = CutsceneGetActor(NPC_TAG_CREEL);
    // Waypoints
    object oWpPlayer = GetObjectInArea(WP_TAG_PLAYER_INIT, oPC);
    object oWpCreel = GetObjectInArea(WP_TAG_CREEL_INIT, oPC);

    if (fTime == 0.0)
    {
        AssignCommand(oActorCreel, ClearAllActions());
        AssignCommand(oActorCreel, JumpToLocation(GetLocation(oWpCreel)));

        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, JumpToLocation(GetLocation(oWpPlayer)));


        CutsceneNext(2.0);
    }
    else if (fTime >= 2.0)
    {
        AssignCommand(oActorCreel, ActionStartConversation(oPC, "", FALSE, FALSE));
        CutsceneCameraSetup(0.0, 120.0, 5.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);

        // Called from conversation
        //CutsceneNextShot();
    }
}


// Shot 2: Ends cutscene
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
