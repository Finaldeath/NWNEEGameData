//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_marel0
//:: DATE: January 28, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Marel Random encounter cutscene
//:: Have the Marel speak some lines
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"
#include "hf_in_plot"
#include "hf_in_npc"
#include "hf_in_friend"


const string NPC_TAG_UNDERW_MAREL = "CR_cut_marel_uw_soldier";
const string WP_TAG_UNDERW_MAREL_SPAWN = "WP_cut_marel_uw_marel_spawn";

const string NPC_RESREF_MAREL_LEADER = "tm_cr_marel3";
const string NPC_TAG_UNDERW_MAREL_LEADER = "CR_cut_marel_uw_leader";
const string WP_TAG_UNDERW_MAREL_LEADER_SPAWN = "WP_cut_marel_uw_lead_spawn";

const string WP_TAG_PLAYER_UNDERW_INIT = "WP_cut_marel_uw_pc_init";
const string WP_TAG_PLAYER_SHIP_INIT   = "WP_cut_marel_sh_pc_init";

const string NPC_TAG_KETTIA = "CaptainKettia";

const string LVAR_MAREL_DONT_COUNT = "re_marel_dont_count";
const string PVAR_MAREL_CURRENT_WAVE = "re_marel_wave_cnt";




void updateQuestStart(object oPC)
{
    int nCurrentWave = PlotLevelGet(PVAR_MAREL_CURRENT_WAVE);
    PlotLevelSet(PVAR_MAREL_CURRENT_WAVE, nCurrentWave+1);
}


void updateQuestEnd(object oPC)
{

}


// Spawn Marels at underwater locations
void MarelUnderwaterSpawn(object oPC)
{
    if (!GetIsObjectValid(GetObjectByTag(NPC_TAG_UNDERW_MAREL)))
    {
        int nNth = 0;
        object oWaypoint = GetObjectByTag(WP_TAG_UNDERW_MAREL_SPAWN, nNth);
        string sResRef = "";
        object oMarel = OBJECT_INVALID;
        while (GetIsObjectValid(oWaypoint))
        {
            sResRef = GetLocalString(oWaypoint, "resref");
            oMarel = CreateObject(OBJECT_TYPE_CREATURE, sResRef, GetLocation(oWaypoint), FALSE, NPC_TAG_UNDERW_MAREL);

            SetLocalInt(oMarel, LVAR_MAREL_DONT_COUNT, 1);

            nNth++;
            oWaypoint = GetObjectByTag(WP_TAG_UNDERW_MAREL_SPAWN, nNth);
        }
    }
}


// Make the Marel play their dissappear animation to simulate surfacing
void MarelSurface(object oPC, int nMaxCnt = 5)
{
    int nNth = 0;
    object oMarel = GetObjectByTag(NPC_TAG_UNDERW_MAREL, nNth);
    effect eDisappear = EffectDisappear();
    while (GetIsObjectValid(oMarel) && (nNth < nMaxCnt))
    {
        AssignCommand(oMarel, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oMarel, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDisappear, oMarel)));

        DestroyObject(oMarel, 3.0f);

        nNth++;
        oMarel = GetObjectByTag(NPC_TAG_UNDERW_MAREL, nNth);
    }
}


// Marel Leader says some words after every wave
string GetMarelString()
{
    int nCurrentWave = PlotLevelGet(PVAR_MAREL_CURRENT_WAVE);
    string sStringToSpeak = "ERROR";
    switch (nCurrentWave)
    {
        case 3:  sStringToSpeak = "Fools! I will do this myself. The air-breathers will perish here!"; break;
        case 2:  sStringToSpeak = "Do not let them escape! Attack! Attack!"; break;
        case 1: sStringToSpeak = "Look above, my brothers and sisters! Umberlee blesses us with new victims. Kill them! We shall deliver their heads to King Uhlmor!"; break;
        default:  sStringToSpeak = "Do not let them escape! Attack! Attack!"; break;
    }
    return sStringToSpeak;

}


void setupActors(object oPC)
{

    object oMarelLeaderWP = GetWaypointByTag(WP_TAG_UNDERW_MAREL_LEADER_SPAWN);
    object oMarelLeader = GetObjectInArea(NPC_TAG_UNDERW_MAREL_LEADER, oMarelLeaderWP);
    if (!GetIsObjectValid(oMarelLeader))
    {
        oMarelLeader = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_MAREL_LEADER, GetLocation(oMarelLeaderWP), FALSE, NPC_TAG_UNDERW_MAREL_LEADER);
    }
    CutsceneAddActor(NPC_TAG_UNDERW_MAREL_LEADER, oMarelLeader);

    object oPlayerWP = GetWaypointByTag(WP_TAG_PLAYER_SHIP_INIT);
    object oKettia = GetObjectInArea(NPC_TAG_KETTIA, oPlayerWP);
    FriendSetMaster(oPC, oKettia);

    MarelUnderwaterSpawn(oPC);
}


void start()
{
    object oPC = CutsceneGetPC();

    updateQuestStart(oPC);

    CutsceneStart(TRUE, FALSE, "", FALSE);
}


void abort()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;

    BlackScreen(oPC);
    setupActors(oPC);

    MarelSurface(oPC, 5);
}


void end()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    updateQuestEnd(oPC);

    oWaypoint = GetWaypointByTag(WP_TAG_PLAYER_SHIP_INIT);
    AssignCommand(oPC, JumpToLocation(GetLocation(oWaypoint)));

}


// Shot 0: Spawn in actors, start conversation
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oMarelLeader = CutsceneGetActor(NPC_TAG_UNDERW_MAREL_LEADER);

    if (fTime == 0.0)
    {
        BlackScreen(oPC);

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        setupActors(oPC);

        CutsceneCameraSetup(2.0, 230.0, 12.0, 70.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FAST);

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oMarelLeader, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 6.0));
        AssignCommand(oMarelLeader, SpeakString(GetMarelString(), TALKVOLUME_SHOUT));

        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        MarelSurface(oPC, 5);

        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FAST);

        CutsceneNext(13.0);
    }
    else if (fTime >= 13.0)
    {
        CutsceneNextShot();
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

