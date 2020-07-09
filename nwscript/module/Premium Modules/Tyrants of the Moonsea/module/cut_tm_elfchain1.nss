//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Cutscene for "Elf In Chains" Quest
//::////////////////////////////////////////////////////
//:: Ilandra's distraction, guards are gone
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"
#include "hf_in_plot"


const string NPC_RESREF_ELF = "elf";
const string NPC_TAG_ELF = "Elf";
const string WP_TAG_ELF_INIT = "WP_melv_market_elf_captive";
const string WP_TAG_ELF_REVOLT = "WP_melv_market_elf_revolt";
const string WP_TAG_ELF_HIDEOUT = "WP_melv_shipy_elf_hide";

const string NPC_TAG_CREEL = "SlavemasterCreel";
const string WP_TAG_CREEL_INIT = "WP_cut_elfchain_creel_0";
const string WP_TAG_CREEL_FLEE = "WP_cut_elfchain_creel_2";

const string NPC_TAG_SLAVE = "tm_cr_melv_slave";

const string WP_TAG_PLAYER_INIT = "WP_cut_elfchain_pc_0";

const string LVAR_QUEST_UPDATE_DONCE = "cut_elfchain1_donce";


// Updates Quest at shot 0
void updateQuest0(object oPC)
{
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) <= 0)
    {

    }
}


// Updates Quest at shot 1
void updateQuest1(object oPC)
{
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 1)
    {
        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 1);

        AddJournalQuestEntry("ElfinChains", 10, oPC);
    }
}


// Updates Quest at shot 2
void updateQuest2(object oPC)
{
    object oCreel = OBJECT_SELF;
    int nPlayerKilledCreel = GetLocalInt(oCreel, "HF_ARG");

    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 2)
    {
        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 2);

        // Ends quest
        PlotLevelSet("ElfInChains-Status", 4);
        // Set up Elf dialog for when he freed using force/ ilandra distraction
        PlotLevelSet(NPC_TAG_ELF, 10);
    }
}


// Move NPCs towards target
void npcMove(string sNPCtag, object oPC, object oTarget)
{
    int nNth = 1;
    object oNPC = GetNearestObjectByTag(sNPCtag, oPC, nNth);
    while (GetIsObjectValid(oNPC))
    {
        AssignCommand(oNPC, ActionMoveToObject(oTarget, FALSE, 2.0f));
        nNth++;
        oNPC = GetNearestObjectByTag(sNPCtag, oPC, nNth);
    }
}


// Make NPCs leave the area
void npcExit(string sNPCtag, object oPC)
{
    int nNth = 1;
    object oNPC = GetNearestObjectByTag(sNPCtag, oPC, nNth);
    while (GetIsObjectValid(oNPC))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oNPC, 9.0);
        SetLocalInt(oNPC, "HF_EXIT_RUN", 1);
        DelayCommand(1.0f, ExecuteScript("hf_cs_exit", oNPC));

        nNth++;
        oNPC = GetNearestObjectByTag(sNPCtag, oPC, nNth);
    }
}


void setupActors(object oPC)
{
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    oActor = GetObjectInArea(NPC_TAG_CREEL, oPC);
    CutsceneAddActor(NPC_TAG_CREEL, oActor);

    oActor = GetObjectInArea(NPC_TAG_ELF, oPC);
    CutsceneAddActor(NPC_TAG_ELF, oActor);
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
    setupActors(oPC);

    // Slaves leave
    npcExit(NPC_TAG_SLAVE, oPC);
    // Elf leaves
    oActor = CutsceneGetActor(NPC_TAG_ELF);
    if (GetIsObjectValid(oActor))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oActor, 9.0);
        ExecuteScript("hf_cs_exit", oActor);
    }

    updateQuest0(oPC);
    updateQuest1(oPC);
    updateQuest2(oPC);
}


void end()
{
    object oPC = CutsceneGetPC();
    object oWaypoint = OBJECT_INVALID;

    // Create new Elf at abandones warehouse
    oWaypoint = GetWaypointByTag(WP_TAG_ELF_HIDEOUT);
    CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_ELF, GetLocation(oWaypoint), FALSE, NPC_TAG_ELF);

    object oCreel = GetNearestObjectByTag(NPC_TAG_CREEL);
    if (GetIsObjectValid(oCreel))
        DestroyObject(oCreel);
}


// Shot 0: Initiate dialog with Creel
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorCreel = CutsceneGetActor(NPC_TAG_CREEL);
    // Waypoints
    object oWpPlayer = GetWaypointByTag(WP_TAG_PLAYER_INIT);
    object oWpCreel = GetWaypointByTag(WP_TAG_CREEL_INIT);

    if (fTime == 0.0)
    {
        updateQuest0(oPC);

        FadeToBlack(oPC, FADE_SPEED_FASTEST);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, JumpToLocation(GetLocation(oWpPlayer)));
        CutsceneCameraSetup(0.0, 210.0, 5.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);

        setupActors(oPC);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oActorCreel, ClearAllActions());
        AssignCommand(oActorCreel, JumpToLocation(GetLocation(oWpCreel)));

        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(5.0);
    }
    else if (fTime >= 5.0)
    {
        AssignCommand(oActorCreel, ActionStartConversation(oPC, "", FALSE, FALSE));

        // Called from conversation
        //CutsceneNextShot();
    }
}


// Shot 1: Creel is forced to free the slaves
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorCreel = CutsceneGetActor(NPC_TAG_CREEL);
    object oActorElf = CutsceneGetActor(NPC_TAG_ELF);
    // Waypoints
    object oWpElf = GetWaypointByTag(WP_TAG_ELF_REVOLT);
    if (fTime == 0.0)
    {
        AssignCommand(oPC, ActionPauseConversation());
        updateQuest1(oPC);

        FadeToBlack(oPC, FADE_SPEED_FASTEST);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // Slaves move towards Creel
        npcMove(NPC_TAG_SLAVE, oPC, oActorCreel);

        // Elf moves towards Creel
        AssignCommand(oActorElf, ClearAllActions());
        AssignCommand(oActorElf, ActionMoveToObject(oWpElf, FALSE, 0.2f));

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(4.0);
    }
    else if (fTime >= 4.0)
    {
        AssignCommand(oPC, ActionResumeConversation());

        // Called from dialog
        //CutsceneNextShot();
    }
}


// Shot 2: Decide Creels fate
void next2(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorCreel = CutsceneGetActor(NPC_TAG_CREEL);
    // Waypoints
    object oWaypointCreelFlee = GetWaypointByTag(WP_TAG_CREEL_FLEE);

    if (fTime == 0.0)
    {
        AssignCommand(oPC, ActionPauseConversation());
        updateQuest2(oPC);

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oActorCreel);
        // Kill Creel or make him leave depending on players choice
        if (GetLocalInt(oActorCreel, "HF_ARG") > 0)
        {
            //SetPlotFlag(oActorCreel, FALSE);
            //SetImmortal(oActorCreel, FALSE);
            //DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oActorCreel));
            AssignCommand(oActorCreel, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 600.0f));
        }
        else
        {
            //ExecuteScript("hf_cs_exit", oActorCreel);
            AssignCommand(oActorCreel, ActionMoveToLocation(GetLocation(oWaypointCreelFlee), TRUE));
        }

        CutsceneNext(3.0);
    }
    else if (fTime >= 3.0)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oActorCreel);
        AssignCommand(oPC, ActionResumeConversation());

        // Called from dialog
        //CutsceneNextShot();
    }
}


// Shot 3: Elf and Slaves leave for the warehouse
void next3(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorElf = CutsceneGetActor(NPC_TAG_ELF);

    if (fTime == 0.0)
    {
        // Slaves disappear
        npcExit(NPC_TAG_SLAVE, oPC);
        // Elf leaves
        ExecuteScript("hf_cs_exit", oActorElf);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FASTEST);

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(5.0);
    }
    else if (fTime >= 5.0)
    {
        CutsceneNextShot();
    }
}


// Shot 4: End cutscene
void next4(float fTime)
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
        if (nShot == 3) next3(fTime);
        if (nShot >= 4) next4(fTime);
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
