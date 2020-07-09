//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_hilraddom
//:: DATE: December 7, 2018
//::////////////////////////////////////////////////////
//:: Start cutscene in Elventree (Swaying Bough inn)
//:: Sentinel arrives to help with Dominion
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"
#include "hf_in_henchman"


const string WP_TAG_PLAYER_INIT = "WP_cut_hilrad_pc_init";
const string WP_TAG_PLAYER_ZALAZAR = "WP_cut_zalazar_pc_init"; // jumping here will trigger "cut_tm_zalazar"

const string NPC_TAG_LYRESSA = "Lyressa";
const string WP_TAG_LYRESSA_INIT = "WP_cut_hilrad_lyressa_init";
const string WP_TAG_LYRESSA_NEXT_CS = "WP_cut_astdeath_lyressa_init";

const string NPC_TAG_EREMUTH = "Eremuth";
const string WP_TAG_EREMUTH_INIT = "WP_cut_hilrad_eremuth_init";

const string NPC_TAG_ASTAR = "Astar";
const string WP_TAG_ASTAR_INIT = "WP_cut_hilrad_astar_init";

const string NPC_TAG_SHARALYN = "SharalynElventree";
const string WP_TAG_SHARALYN_INIT = "WP_cut_hilrad_sharalyn_init";
const string WP_TAG_SHARALYN_MOVE = "WP_cut_hilrad_sharalyn_move";

const string NPC_TAG_SENTINEL = "TheSentinel";
const string WP_TAG_SENTINEL_INIT = "WP_cut_hilrad_sentinel_init";
const string WP_TAG_SENTINEL_MOVE = "WP_cut_hilrad_sentinel_move";

const string NPC_TAG_HILRAD = "HilradthePatient";

const string WP_TAG_EXIT_ALL = "WP_cut_hilrad_exit_all";

const string LVAR_QUEST_UPDATE_DONCE = "cut_hilraddom_donce";


// Quest update at shot 1 (Sentinel initiates Dialog)
void updateQuestShot1(object oPC)
{
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 1)
    {
        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 1);

        AddJournalQuestEntry("OrderoftheCrippledFang", 42, oPC);
    }
}


// Quest update at shot 2
void updateQuestShot2(object oPC)
{
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 2)
    {
        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 2);

        SetLocalInt(oPC, "zalazar", 1);
    }
}


// Quest update at shot 4
void updateQuestShot4(object oPC)
{
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 3)
    {
        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 3);

        SetLocalInt(oPC, "elventreeattacked", 1);
    }
}


void moveNearHenchmen(object oPC, string sHenchmanTag, string sWaypointTag)
{
    object oHench = CutsceneGetActor(sHenchmanTag);
    if (!GetIsObjectValid(oHench))
    {
        oHench = GetNearestObjectByTag(sHenchmanTag, oPC);
    }

    object oWaypoint = GetWaypointByTag(sWaypointTag);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oHench);
    AssignCommand(oHench, ClearAllActions(TRUE));
    DelayCommand(0.5f, AssignCommand(oHench, JumpToLocation(GetLocation(oWaypoint))));
    DelayCommand(0.6f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneImmobilize(), oHench)); // 32.0f

}


void RemoveAllEffects(object oTarget, object oEffectCreator)
{
    effect eEffect = GetFirstEffect(oTarget);
    while (GetIsEffectValid(eEffect))
    {
        if (GetEffectCreator(eEffect) == oEffectCreator)
        {
            RemoveEffect(oTarget, eEffect);
        }
        eEffect = GetNextEffect(oTarget);
    }
}


// Removes henchmen only
void RemoveAllHenchmen(object oPC)
{
    object oEffectCreator = CutsceneGetScene();

    object oHench = OBJECT_INVALID;
    int i = 0;
    for (i=16; i>0; i--)
    {
        oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, i);
        if (GetIsObjectValid(oHench))
        {
            RemoveAllEffects(oHench, oEffectCreator);
        }
        DelayCommand(1.0f, RemoveHenchman(oPC, oHench));
        SetActionMode(oHench, ACTION_MODE_STEALTH, FALSE);
    }
}


void ClearAssociateCutsceneEffects(object oPC)
{
    object oEffectCreator = CutsceneGetScene();
    effect eEffect;

    int i = 0;
    object oHench = OBJECT_INVALID;
    for (i=16; i>0; i--)
    {
        oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, i);
        if (GetIsObjectValid(oHench))
        {
            eEffect = GetFirstEffect(oHench);
            while (GetIsEffectValid(eEffect))
            {
                RemoveEffect(oHench, eEffect);
                eEffect = GetNextEffect(oHench);
            }
        }
    }
}


void setupActors(object oPC)
{
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    oActor = CutsceneGetActor(NPC_TAG_SHARALYN);
    if (!GetIsObjectValid(oActor))
    {
        oActor = GetNearestObjectByTag(NPC_TAG_SHARALYN, oPC);
        if (!GetIsObjectValid(oActor))
            oActor = GetObjectByTag(NPC_TAG_SHARALYN);
        AssignCommand(oActor, ClearAllActions(TRUE));
        CutsceneAddActor(NPC_TAG_SHARALYN, oActor);
    }

    oActor = CutsceneGetActor(NPC_TAG_LYRESSA);
    if (!GetIsObjectValid(oActor))
    {
        oActor = GetNearestObjectByTag(NPC_TAG_LYRESSA, oPC);
        if (!GetIsObjectValid(oActor))
            oActor = GetObjectByTag(NPC_TAG_LYRESSA);
        AssignCommand(oActor, ClearAllActions(TRUE));

        CutsceneAddActor(NPC_TAG_LYRESSA, oActor);
    }

    oActor = CutsceneGetActor(NPC_TAG_HILRAD);
    if (!GetIsObjectValid(oActor))
    {
        oActor = GetNearestObjectByTag(NPC_TAG_HILRAD, oPC);

        if (!GetIsObjectValid(oActor))
            oActor = GetObjectByTag(NPC_TAG_HILRAD);
        AssignCommand(oActor, ClearAllActions(TRUE));

        CutsceneAddActor(NPC_TAG_HILRAD, oActor);
    }

    oActor = CutsceneGetActor(NPC_TAG_SENTINEL);
    if (!GetIsObjectValid(oActor))
    {
        oActor = GetObjectByTag(NPC_TAG_SENTINEL);
        oWaypoint = GetWaypointByTag(WP_TAG_SENTINEL_INIT);

        AssignCommand(oActor, ClearAllActions(TRUE));
        DelayCommand(1.0f, AssignCommand(oActor, JumpToLocation(GetLocation(oWaypoint))));

        CutsceneAddActor(NPC_TAG_SENTINEL, oActor);
    }
}


void start()
{
    object oPC = CutsceneGetPC();

    // RemoveAllHenchmen(oPC);
    CutsceneStart(FALSE, FALSE, "", FALSE);

    ClearAssociateCutsceneEffects(oPC);

}


void abort()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;

    BlackScreen(oPC);
    setupActors(oPC);

    updateQuestShot1(oPC);
    updateQuestShot2(oPC);
    updateQuestShot4(oPC);
}


void end()
{
    object oPC = CutsceneGetPC();
    object oWaypoint = OBJECT_INVALID;
    object oTrigger = OBJECT_INVALID;

    // Activate trigger for next cutscene
    oTrigger = GetObjectByTag("tr_cut_zalazar");
    SetLocalInt(oTrigger, "nDone", 0);

    // Destroy Sentinel
    object oSentinel = CutsceneGetActor(NPC_TAG_SENTINEL);
    if (!GetIsObjectValid(oSentinel))
        oSentinel = GetObjectInArea(NPC_TAG_SENTINEL, oPC);
    if (GetIsObjectValid(oSentinel))
    {
        oWaypoint = GetWaypointByTag(WP_TAG_EXIT_ALL);
        AssignCommand(oSentinel, ActionMoveToObject(oWaypoint, TRUE));
        DestroyObject(oSentinel, 1.0f);
    }

    // Destroy Sharalyn
    object oSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    if (!GetIsObjectValid(oSharalyn))
        oSharalyn = GetObjectInArea(NPC_TAG_SHARALYN, oPC);
    if (GetIsObjectValid(oSharalyn))
    {
        oWaypoint = GetWaypointByTag(WP_TAG_EXIT_ALL);
        AssignCommand(oSharalyn, ActionMoveToObject(oWaypoint, TRUE));
        DestroyObject(oSharalyn, 1.0f);
    }

    // Destroy Hilrad
    object oHilrad = CutsceneGetActor(NPC_TAG_HILRAD);
    if (!GetIsObjectValid(oHilrad))
        oHilrad = GetObjectInArea(NPC_TAG_HILRAD, oPC);
    if (GetIsObjectValid(oHilrad))
    {
        oWaypoint = GetWaypointByTag(WP_TAG_EXIT_ALL);
        DelayCommand(0.5f, AssignCommand(oHilrad, ActionMoveToObject(oWaypoint, TRUE)));
        DestroyObject(oHilrad, 1.5f);
    }

    // Move Lyressa
    object oWpLyressa = GetWaypointByTag(WP_TAG_LYRESSA_NEXT_CS);
    object oLyressa = CutsceneGetActor(NPC_TAG_LYRESSA);
    if (!GetIsObjectValid(oLyressa))
        oLyressa = GetObjectInArea(NPC_TAG_LYRESSA, oWpLyressa);
    if (GetIsObjectValid(oLyressa))
    {
        AssignCommand(oLyressa, ClearAllActions(TRUE));
        RemoveAllEffects(oLyressa, CutsceneGetScene());
        DelayCommand(1.0f, AssignCommand(oLyressa, JumpToLocation(GetLocation(oWpLyressa))));
    }

    // Remove leftover effects from eremuth (no need to move him)
    object oEremuth = GetObjectInArea(NPC_TAG_EREMUTH, oPC);
    if (GetIsObjectValid(oEremuth))
    {
        RemoveAllEffects(oEremuth, CutsceneGetScene());

        // No longer need to remove Eremuth here, he will join the PC in the defense of Elventree
        // AssignCommand(oEremuth, SetIsDestroyable(TRUE, FALSE, FALSE));
        // SetPlotFlag(oEremuth, FALSE);
        // DestroyObject(oEremuth, 1.0f);
    }

    // Remove leftover effects from Astar (no need to move him)
    object oAstar = GetObjectInArea(NPC_TAG_ASTAR, oPC);
    if (GetIsObjectValid(oAstar))
    {
        RemoveAllEffects(oAstar, CutsceneGetScene());
    }

    // Jump PC onto trigger
    oWaypoint = GetWaypointByTag(WP_TAG_PLAYER_ZALAZAR);
    DelayCommand(1.0, AssignCommand(oPC, JumpToObject(oWaypoint)));

    DeleteLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE);
}


// Shot 0: Sharalyn leaves to retrieve Sentinel
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    // Waypoints
    object oWpSharalynMove = GetWaypointByTag(WP_TAG_SHARALYN_MOVE);

    if (fTime == 0.0)
    {
        setupActors(oPC);

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        AssignCommand(oActorSharalyn, ActionMoveToObject(oWpSharalynMove, TRUE));
        FadeToBlack(oPC, FADE_SPEED_SLOW);

        CutsceneNext(3.0);
    }
    else if (fTime >= 3.0)
    {
        CutsceneNextShot();
    }
}


// Shot 1: Sentinel arrives and initiates conversation
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    object oActorSentinel = CutsceneGetActor(NPC_TAG_SENTINEL);
    object oActorHilrad = CutsceneGetActor(NPC_TAG_HILRAD);
    // Waypoints
    object oWpPlayerInit = GetWaypointByTag(WP_TAG_PLAYER_INIT);
    object oWpSharalynInit = GetWaypointByTag(WP_TAG_SHARALYN_INIT);
    object oWpSentinelMove = GetWaypointByTag(WP_TAG_SENTINEL_MOVE);

    if (fTime == 0.0)
    {
        updateQuestShot1(oPC);

        CutsceneCameraSetup(2.0, 170.0, 9.0, 70.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        vector vNPCFacing = GetPosition(oWpPlayerInit);

        AssignCommand(oActorSharalyn, ClearAllActions(TRUE));
        AssignCommand(oActorSharalyn, JumpToLocation(GetLocation(oWpSharalynInit)));
        AssignCommand(oActorSharalyn, SetFacingPoint(vNPCFacing));

        AssignCommand(oActorSentinel, ClearAllActions(TRUE));
        AssignCommand(oActorSentinel, JumpToLocation(GetLocation(oWpSentinelMove)));

        AssignCommand(oActorHilrad, ClearAllActions(TRUE));
        AssignCommand(oActorHilrad, SetFacingPoint(vNPCFacing));

        AssignCommand(oPC, JumpToLocation(GetLocation(oWpPlayerInit)));

        moveNearHenchmen(oPC, NPC_TAG_ASTAR, WP_TAG_ASTAR_INIT);
        moveNearHenchmen(oPC, NPC_TAG_EREMUTH, WP_TAG_EREMUTH_INIT);
        moveNearHenchmen(oPC, NPC_TAG_LYRESSA, WP_TAG_LYRESSA_INIT);

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_SLOW);

        CutsceneNext(6.0);
    }
    else if (fTime >= 6.0)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oActorSentinel, 3.0f);
        AssignCommand(oActorSentinel, ActionStartConversation(oPC));

        // Called from conversation
        //CutsceneNextShot();
    }
}


// Shot 2: Elventree is attacked, Hilrad is knocked down
void next2(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    object oActorHilrad = CutsceneGetActor(NPC_TAG_HILRAD);

    if (fTime == 0.0)
    {
        updateQuestShot2(oPC);
        AssignCommand(oPC, ActionPauseConversation());

        effect eVFX = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oPC, 3.0);

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        AssignCommand(oActorHilrad, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 600.0));

        CutsceneNext(3.0);
    }
    else if (fTime >= 3.0)
    {
        AssignCommand(oPC, ActionResumeConversation());

        // Called from conversation
        //CutsceneNextShot();
    }
}


// Shot 3: Sharalyn helps Hilrad back up
void next3(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorHilrad = CutsceneGetActor(NPC_TAG_HILRAD);

    if (fTime == 0.0)
    {
        AssignCommand(oActorHilrad, ClearAllActions(TRUE));

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        // Called from conversation
        //CutsceneNextShot();
    }
}


// Shot 4: Ends Cutscene
void next4(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    object oActorHilrad = CutsceneGetActor(NPC_TAG_HILRAD);
    // Waypoints
    object oWpExit = GetWaypointByTag(WP_TAG_EXIT_ALL);

    if (fTime == 0.0)
    {
        CutsceneCameraSetup(2.0, 200.0, 3.0, 70.0, CAMERA_TRANSITION_TYPE_SLOW);

        updateQuestShot4(oPC);

        AssignCommand(oActorSharalyn, ClearAllActions(TRUE));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oActorSharalyn, 12.0f);
        DelayCommand(0.5f, AssignCommand(oActorSharalyn, ActionMoveToObject(oWpExit, TRUE)));

        AssignCommand(oActorHilrad, ClearAllActions(TRUE));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oActorHilrad, 12.0f);
        DelayCommand(0.5f, AssignCommand(oActorHilrad, ActionMoveToObject(oWpExit, TRUE)));

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FAST);

        CutsceneNext(3.0);
    }
    else if (fTime >= 2.0)
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
