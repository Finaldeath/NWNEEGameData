//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_diamond
// DATE: January 1, 2006
// AUTH: Luke Scull
// NOTE: Diamond in the Dung cutscene.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"


const string WP_TAG_PLAYER = "WP_cut_diamond_pc1";
const string WP_TAG_ARENA_JUMP = "WP_hfcells_pc_arrival";

const string NPC_RESREF_WAK = "taverncrazedoldm";
const string NPC_TAG_WAK = "TavernCrazedOldMan";
const string WP_TAG_WAK_SPAWN = "WP_cut_diamond_wak_spawn";
const string WP_TAG_WAK_MOVE = "WP_cut_diamond_wak_move";

const string NPC_RESREF_REDPLUME = "redplumemerce002";
const string NPC_TAG_REDPLUMEx = "CR_cut_diamond_plum"; // Append number
const string WP_TAG_REDPLUMEx_SPAWN = "WP_cut_diamond_plume_spawn"; // Append number
const string WP_TAG_REDPLUMEx_MOVE = "WP_cut_diamond_plume_move"; // Append number

const string NPC_TAG_ONEHAND = "KalorOnehand";
const string WP_TAG_ONEHAND_INIT = "WP_Onehand_Diamond";

const string LVAR_QUEST_UPDATE_DONCE = "cut_diamond_donce";


// Resets Non-Human appearance models to the right one
// (originally set in tag_tm_scrollill)
void illusionScrollEffectRemove(object oTarget)
{
    int nRacialType = GetRacialType(oTarget);
    int nAppearanceType = APPEARANCE_TYPE_HUMAN;
    switch (nRacialType)
    {
        case RACIAL_TYPE_GNOME:
        {
            nAppearanceType = APPEARANCE_TYPE_GNOME;
            break;
        }
        case RACIAL_TYPE_ELF:
        {
            nAppearanceType = APPEARANCE_TYPE_ELF;
            break;
        }
        case RACIAL_TYPE_DWARF:
        {
            nAppearanceType = APPEARANCE_TYPE_DWARF;
            break;
        }
        case RACIAL_TYPE_HALFLING:
        {
            nAppearanceType = APPEARANCE_TYPE_HALFLING;
            break;
        }
        case RACIAL_TYPE_HALFORC:
        {
            nAppearanceType = APPEARANCE_TYPE_HALF_ORC;
            break;
        }
        case RACIAL_TYPE_HALFELF:
        {
            nAppearanceType = APPEARANCE_TYPE_HALF_ELF;
            break;
        }
        default:
        {
            return;
        }
    }

    if (GetAppearanceType(oTarget) != nAppearanceType)
        SetCreatureAppearanceType(oTarget, nAppearanceType);
    DeleteLocalInt(oTarget, "HF_POLY_CREATURE_TYPE");
}


// Updates quests at Shot 1
void updateQuest1(object oPC)
{
    // from cac_tm_crazed 5
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 1)
    {
        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 1);

        AddJournalQuestEntry("CrazedOldMan", 20, oPC);
    }
}


// Updates quests at Shot 2
void updateQuest2(object oPC)
{
    // from cac_tm_crazed 4
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 2)
    {
        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 2);

        AddJournalQuestEntry("TheCityofHillsfar", 30, oPC);
        illusionScrollEffectRemove(oPC);
    }
}


// Spawn as many Red Plumes as there are waypoints for them
void setupGuards(object oPC)
{
    int i = 1;
    string sTagRedPlume = NPC_TAG_REDPLUMEx + IntToString(i);
    string sWpRedPlume = WP_TAG_REDPLUMEx_SPAWN + IntToString(i);
    while (GetIsObjectValid(GetWaypointByTag(sWpRedPlume)))
    {
        CutsceneSpawnActor(NPC_RESREF_REDPLUME, sTagRedPlume, sWpRedPlume);
        i++;
        sTagRedPlume = NPC_TAG_REDPLUMEx + IntToString(i);
        sWpRedPlume = WP_TAG_REDPLUMEx_SPAWN + IntToString(i);
    }
}


// Move Guards to their  waypoints
void moveGuards(object oPC)
{
    int i = 1;
    object oActorRedPlume = CutsceneGetActor(NPC_TAG_REDPLUMEx + IntToString(i));
    object oWpRedPlume = GetWaypointByTag(WP_TAG_REDPLUMEx_MOVE + IntToString(i));
    while (GetIsObjectValid(oWpRedPlume))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oActorRedPlume, 4.0);
        AssignCommand(oActorRedPlume, ActionMoveToObject(oWpRedPlume, FALSE));
        AssignCommand(oActorRedPlume, ActionDoCommand(SetFacing(GetFacing(oWpRedPlume))));

        i++;
        oActorRedPlume = CutsceneGetActor(NPC_TAG_REDPLUMEx + IntToString(i));
        oWpRedPlume = GetWaypointByTag(WP_TAG_REDPLUMEx_MOVE + IntToString(i));
    }
    oActorRedPlume = OBJECT_INVALID;
}


void setupActors(object oPC)
{
    object oActor;
    object oSpawnWP;

    oActor = GetObjectInArea(NPC_TAG_ONEHAND, oPC);
    CutsceneAddActor(NPC_TAG_ONEHAND, oActor);

    CutsceneSpawnActor(NPC_RESREF_WAK, NPC_TAG_WAK, WP_TAG_WAK_SPAWN);
    setupGuards(oPC);

}


void start()
{
    object oPC = CutsceneGetPC();

    CutsceneStart(FALSE, FALSE, "", FALSE);
}


// Called when the cutscene is aborted to ensure post conditions
void abort()
{
    object oPC = CutsceneGetPC();
    setupActors(oPC);

    updateQuest1(oPC);
    updateQuest2(oPC);
}


void end()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    // Get rid of all Red Plumes
    int i = 1;
    oActor = GetObjectByTag(NPC_TAG_REDPLUMEx + IntToString(i));
    while (GetIsObjectValid(oActor))
    {
        DestroyObject(oActor);
        i++;
        oActor = GetObjectByTag(NPC_TAG_REDPLUMEx + IntToString(i));
    }

    // Don't leave any traces on PC
    DeleteLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE);

    // The player needs to be jumped to the arena
    oWaypoint = GetWaypointByTag(WP_TAG_ARENA_JUMP);
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, JumpToLocation(GetLocation(oWaypoint)));
}


// Shot 0: Spawn Wak and some red plumes, intiate convo
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorOnehand = CutsceneGetActor(NPC_TAG_ONEHAND);
    object oActorWak = CutsceneGetActor(NPC_TAG_WAK);
    // Waypoints
    object oWpPlayer = GetObjectInArea(WP_TAG_PLAYER, oPC);
    object oWpWak = GetObjectInArea(WP_TAG_WAK_MOVE, oPC);

    if (fTime == 0.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FASTEST);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        setupActors(oPC);

        // Make sure the PC is at the proper location
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionJumpToObject(oWpPlayer, FALSE));

        CutsceneCameraSetup(0.0, 20.0, 3.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // Wak moves towards PC
        AssignCommand(oActorWak, ActionMoveToObject(oWpWak, FALSE, 0.2));

        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        // The plumes follow
        moveGuards(oPC);

        CutsceneNext(7.0);
    }
    else if (fTime >= 7.0)
    {
        updateQuest1(oPC);
        AssignCommand(oActorWak, ActionStartConversation(oPC, "", FALSE, FALSE));

        // Called from dialog
        //CutsceneNextShot();
    }
}


// Shot 1: Onehand hits player, unconscious
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorOnehand = CutsceneGetActor(NPC_TAG_ONEHAND);
    // Waypoints
    object oPlayerWP = GetWaypointByTag(WP_TAG_PLAYER);

    if (fTime == 0.0)
    {
        AssignCommand(oPC, ActionPauseConversation());
        updateQuest1(oPC);

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        // Onehand runs towards player
        AssignCommand(oActorOnehand, ActionMoveToObject(oPlayerWP, TRUE));
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // Onehand draws Weapon (using this as substitute for an actual hit)
        AssignCommand(oActorOnehand, ActionEquipMostDamagingMelee());

        CutsceneNext(3.0);
    }
    else if (fTime >= 3.0)
    {
        // Unconscious
        AssignCommand(oPC, ActionResumeConversation());
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 60.0));

        // Called from dialog
        //CutsceneNextShot();
    }
}


// Shot 2: Ends the cutscene
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
