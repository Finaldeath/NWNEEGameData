//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_sharsway
//:: DATE: January 04, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Cutscene for first Sharalyn encounter in Elventree
//:: Initiate conversation and move her to Hilrad
//:: afterwards
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"
#include "hf_in_plot"

const string NPC_RESREF_SHARALYN = "sharalynelventre";
const string NPC_TAG_SHARALYN = "SharalynElventree";
const string WP_TAG_SHARALYN_INIT = "WP_cut_sharsway_sharalyn_init";
const string WP_TAG_SHARALYN_HILRAD = "WP_cut_hilrad_sharalyn_init";

const string WP_TAG_PC_INIT = "WP_cut_sharsway_pc_init";

const string DOOR_TAG_INN_TO_UPPER = "Swaying2_To_Swaying3";

const string LVAR_QUEST_UPDATE_DONCE = "cut_sharsway_donce";


// Updates Quest at shot 1
void updateQuest1(object oPC)
{
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 1)
    {
        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 1);
    }
}


void updateQuestEnd(object oPC)
{
    // Ensure Sharalyn is set to "spoken to" in case of cancelled dialog
    SetLocalInt(oPC, "sharalynbough", 1);
}


void setupActors(object oPC)
{
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    // A little messy due to quest changes/ not knowing where Sharalyn exactly is
    oActor = CutsceneGetActor(NPC_TAG_SHARALYN);
    oWaypoint = GetWaypointByTag(WP_TAG_SHARALYN_INIT);
    if (!GetIsObjectValid(oActor))
    {
        oActor = GetNearestObjectByTag(NPC_TAG_SHARALYN, oWaypoint);
        if (!GetIsObjectValid(oActor))
            oActor = GetObjectByTag(NPC_TAG_SHARALYN);
        if (!GetIsObjectValid(oActor))
            oActor = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_SHARALYN, GetLocation(oWaypoint));
        AssignCommand(oActor, ClearAllActions(TRUE));
        AssignCommand(oActor, JumpToLocation(GetLocation(oWaypoint)));
        CutsceneAddActor(NPC_TAG_SHARALYN, oActor);
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

    updateQuest1(oPC);

    oWaypoint = GetWaypointByTag(WP_TAG_SHARALYN_HILRAD);
    oActor = GetObjectByTag(NPC_TAG_SHARALYN);
    AssignCommand(oActor, ClearAllActions());
    AssignCommand(oActor, ActionJumpToLocation(GetLocation(oWaypoint)));
}


void end()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    updateQuestEnd(oPC);

    DeleteLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE);
}


// Shot 0: Create Sharalyn at door
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    // Waypoints
    object oWpPlayerInit = GetWaypointByTag(WP_TAG_PC_INIT);
    // Door
    object oDoor = GetObjectByTag(DOOR_TAG_INN_TO_UPPER);

    if (fTime == 0.0)
    {

        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionMoveToLocation(GetLocation(oWpPlayerInit), FALSE));

        CutsceneCameraSetup(2.0, 270.0, 5.0, 67.0, CAMERA_TRANSITION_TYPE_MEDIUM);

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_OPEN1));

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        setupActors(oPC);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oActorSharalyn, ActionStartConversation(oPC));

        // Called from dialog
        //CutsceneNextShot();
    }
}


// Shot 1: Make Sharalyn leave
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    // Waypoints
    object oWpSharalynHilrad = GetWaypointByTag(WP_TAG_SHARALYN_HILRAD);
    // Door
    object oDoor = GetObjectByTag(DOOR_TAG_INN_TO_UPPER);

    if (fTime == 0.0)
    {
        updateQuest1(oPC);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oActorSharalyn, 5.0f);
        AssignCommand(oActorSharalyn, ActionMoveToLocation(GetLocation(oDoor), FALSE));

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oActorSharalyn, ActionJumpToLocation(GetLocation(oWpSharalynHilrad)));

        CutsceneNext(3.0);
    }
    else if (fTime >= 3.0)
    {
        CutsceneNextShot();
    }
}


// Shot 2: End cutscene
void next2(float fTime)
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
        if (nShot >= 2) next2(fTime);
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
