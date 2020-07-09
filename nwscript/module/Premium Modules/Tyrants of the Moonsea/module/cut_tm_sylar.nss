//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_sylar
//:: DATE: December 28, 2018
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Cutscene in Zhent quarter with Sylar the
//:: totally trustworthy (yes, really)
//::////////////////////////////////////////////////////

#include "nw_i0_generic"

#include "hf_in_cutscene"
#include "hf_in_util"
#include "hf_in_plot"


const string NPC_RESREF_SYLAR = "sylarthetrustwor";
const string NPC_TAG_SYLAR = "SylartheTrustworthy";
const string WP_TAG_SYLAR_SPAWN = "WP_cut_sylar_syl_spawn";
const string WP_TAG_SYLAR_AMBUSH_JUMP = "WP_cut_sylar_ambush_syl_jump";
const string WP_TAG_SYLAR_AMBUSH_MOVE = "WP_cut_sylar_ambush_syl_move";
const string WP_TAG_SYLAR_FINAL = "WP_cut_sylar_syl_final";

const string NPC_RESREF_THUG = "cr_tm_sylargang0";
const string NPC_TAG_THUG = "cr_tm_sylargang_";
const string WP_TAG_THUG_SPAWN_A = "WP_cut_sylar_thugA";
const string WP_TAG_THUG_SPAWN_B = "WP_cut_sylar_thugB";

const string WP_TAG_PLAYER_INIT = "WP_cut_sylar_pc_init";
const string WP_TAG_PLAYER_AMBUSH_JUMP = "WP_cut_sylar_ambush_pc_jump";
const string WP_TAG_PLAYER_AMBUSH_MOVE = "WP_cut_sylar_ambush_pc_move";

const string NPC_RESREF_ASSOCIATE = "tm_cr_sylarassoc";
const string NPC_TAG_ASSOCIATE = "tm_cr_sylarassoc";
const string WP_TAG_ASSOCIATE_SPAWN = "WP_cut_sylar_asc_spawn";

const string WP_TAG_LEAVE = "WP_cut_sylar_leave";

const string LVAR_THUGS_SPAWNED = "cut_tm_sylar_thug_s";


// Create a thug for every waypoint, the set of waypoints used depends on player location
void thugSpawn(string sWPBasetag, object oPC)
{
    if (GetLocalInt(oPC, LVAR_THUGS_SPAWNED) > 0)
        return;
    SetLocalInt(oPC, LVAR_THUGS_SPAWNED, 1);


    object oThug = OBJECT_INVALID;
    string sThugTag = "";

    int nNth = 0;
    object oWaypoint = GetObjectByTag(sWPBasetag + IntToString(nNth));
    while (GetIsObjectValid(oWaypoint))
    {
        sThugTag = NPC_TAG_THUG + IntToString(nNth);
        oThug = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_THUG, GetLocation(oWaypoint), FALSE, sThugTag);
        CutsceneAddActor(sThugTag, oThug);

        nNth++;
        oWaypoint = GetObjectByTag(sWPBasetag + IntToString(nNth));
    }
}


// Move Thugs closer to player (or any other target)
void thugMove(object oMoveTarget, float fDistance)
{
    int nNth = 0;
    object oThug = CutsceneGetActor(NPC_TAG_THUG + IntToString(nNth));
    while (GetIsObjectValid(oThug))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oThug, 3.0);
        AssignCommand(oThug, ClearAllActions(TRUE));
        AssignCommand(oThug, ActionMoveToObject(oMoveTarget, FALSE, fDistance));

        nNth++;
        oThug = CutsceneGetActor(NPC_TAG_THUG + IntToString(nNth));
    }
}


// Make thugs attack player (or any other target)
void thugAttack(object oAttackTarget)
{
    int nNth = 0;
    object oThug = CutsceneGetActor(NPC_TAG_THUG + IntToString(nNth));
    while (GetIsObjectValid(oThug))
    {
        ExecuteScript("hf_ut_hostile", oThug);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oThug, 0.9);

        DelayCommand(1.0, AssignCommand(oThug, ClearAllActions(TRUE)));
        DelayCommand(1.2, AssignCommand(oThug, ActionAttack(oAttackTarget)));

        nNth++;
        oThug = CutsceneGetActor(NPC_TAG_THUG + IntToString(nNth));
    }
}


// Makes Sylar flee the scene and create a new one at his final location
void sylarFlee(object oPC)
{
    object oSylar = CutsceneGetActor(NPC_TAG_SYLAR);
    object oWpSylarFlee = GetNearestObjectByTag(WP_TAG_LEAVE, oPC);
    object oWpSylarRespawn = GetWaypointByTag(WP_TAG_SYLAR_FINAL);
    if (GetIsObjectValid(oSylar))
    {
        AssignCommand(oPC, PlaySound("vs_sylar_001"));
        AssignCommand(oSylar, SpeakString("Kill them and loot the body. We'll sell the corpse to Pusk the Necromancer."));

        SetLocalInt(oSylar, "nBusy", 1);
        AssignCommand(oSylar, ClearAllActions(TRUE));

        // Sylar flees
        SetLocalString(oSylar, "HF_EXIT_NAME", WP_TAG_LEAVE);
        SetLocalInt(oSylar, "HF_EXIT_RUN", 1);
        DelayCommand(1.0f, ExecuteScript("hf_cs_exit", oSylar));
        // Create new Sylar at final WP
        CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_SYLAR, GetLocation(oWpSylarRespawn), FALSE, NPC_TAG_SYLAR);
    }
}


void setupActors(object oPC)
{
    // CutsceneSpawnActor(NPC_RESREF_SYLAR, NPC_TAG_SYLAR, WP_TAG_SYLAR_SPAWN);
    object oSylarWP = GetWaypointByTag(WP_TAG_SYLAR_SPAWN);
    object oActorSylar = GetObjectInArea(NPC_TAG_SYLAR, oSylarWP);
    if (!GetIsObjectValid(oActorSylar))
    {
        oActorSylar = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_SYLAR, GetLocation(oSylarWP));
    }
    CutsceneAddActor(NPC_TAG_SYLAR, oActorSylar);
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

    AssignCommand(oPC, ActionResumeConversation());

    // Spawn thugs using a waypoint as the nearest object.
    // This is safer than using the player, who may be in the process of being jumped there
    int nDoAmbush = PlotLevelCheckEquals(NPC_TAG_SYLAR, 1);
    if (nDoAmbush)
    {
         thugSpawn(WP_TAG_THUG_SPAWN_A, oPC);

        AssignCommand(oPC, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oPC, JumpToLocation(GetLocation(oWaypoint))));
    }
    else
    {
         thugSpawn(WP_TAG_THUG_SPAWN_B, oPC);
    }
    DelayCommand(1.0f, thugMove(oPC, 5.0));
}


void JumpInHenchmen(object oPC, object oJumpTarget)
{
    object oAssociate = GetFirstFactionMember(oPC, FALSE);

    effect eEffect;
    object oEffectCreator = CutsceneGetScene();

    while (GetIsObjectValid(oAssociate))
    {
        if (GetDistanceBetween(oAssociate, oPC) > 5.0f)
        {
            eEffect = GetFirstEffect(oAssociate);
            while (GetIsEffectValid(eEffect))
            {
                if (GetEffectCreator(eEffect) == oEffectCreator)
                {
                    RemoveEffect(oAssociate, eEffect);
                }
                eEffect = GetNextEffect(oAssociate);
            }

            AssignCommand(oAssociate, JumpToLocation(GetLocation(oJumpTarget)));
        }
        oAssociate = GetNextFactionMember(oPC, FALSE);
    }
}


void end()
{
    object oPC = CutsceneGetPC();

    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));

    sylarFlee(oPC);
    PlotLevelSet(NPC_TAG_SYLAR, 2); // Set dialog branch
    DelayCommand(3.0f, thugAttack(oPC));

    // Spawn Sylar's Associate
    object oAssocWP = GetWaypointByTag(WP_TAG_ASSOCIATE_SPAWN);
    CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_ASSOCIATE, GetLocation(oAssocWP));

    // Jump in henchmen if ambush
    object oWpHenchAmbush = GetWaypointByTag(WP_TAG_PLAYER_AMBUSH_JUMP);
    if (GetDistanceBetween(oWpHenchAmbush, oPC) < 30.0f)
        DelayCommand(2.5f, JumpInHenchmen(oPC, oWpHenchAmbush));

    DeleteLocalInt(oPC, LVAR_THUGS_SPAWNED);
}


// Shot 0: Sylar appears and offer to guide the player
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorSylar = CutsceneGetActor(NPC_TAG_SYLAR);
    // Waypoint
    object oWpPCInit = OBJECT_INVALID;

    if (fTime == 0.0)
    {
        BlackScreen(oPC);

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        setupActors(oPC);

        oWpPCInit = GetWaypointByTag(WP_TAG_PLAYER_INIT);
        AssignCommand(oPC, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oPC, JumpToLocation(GetLocation(oWpPCInit))));

        CutsceneCameraSetup(2.0, 270.0, 8.0, 70.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        oWpPCInit = GetWaypointByTag(WP_TAG_PLAYER_INIT);

        AssignCommand(oActorSylar, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oActorSylar, ActionStartConversation(oPC, "", FALSE, FALSE)));

        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        // Called from conversation
        //CutsceneNextShot();
    }
}


// Shot 1: Decide the course of the scene
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorSylar = CutsceneGetActor(NPC_TAG_SYLAR);

    int nDoAmbush = PlotLevelCheckEquals(NPC_TAG_SYLAR, 1);
    if (nDoAmbush)
    {
        // PC follows Sylar, gets ambushes in a map corner
        object oWpLeave = GetWaypointByTag(WP_TAG_LEAVE);
        object oWpPCAmbush = OBJECT_INVALID;
        object oWpSylarAmbush = OBJECT_INVALID;

        if (fTime == 0.0)
        {
            thugSpawn(WP_TAG_THUG_SPAWN_A, oPC);

            CutsceneNext(1.0);
        }
        else if (fTime == 1.0)
        {
            AssignCommand(oActorSylar, ClearAllActions(TRUE));
            AssignCommand(oActorSylar, ActionMoveToLocation(GetLocation(oWpLeave), FALSE));

            CutsceneCameraSetup(2.0, 300.0, 8.0, 70.0, CAMERA_TRANSITION_TYPE_SLOW);

            CutsceneNext(3.0);
        }
        else if (fTime == 3.0)
        {
            AssignCommand(oPC, ClearAllActions(TRUE));
            AssignCommand(oPC, ActionMoveToLocation(GetLocation(oWpLeave), FALSE));

            FadeToBlack(oPC, FADE_SPEED_MEDIUM);

            CutsceneNext(6.0);
        }
        else if (fTime == 6.0)
        {
            oWpPCAmbush = GetWaypointByTag(WP_TAG_PLAYER_AMBUSH_JUMP);
            AssignCommand(oPC, ClearAllActions(TRUE));
            DelayCommand(0.5, AssignCommand(oPC, JumpToLocation(GetLocation(oWpPCAmbush))));

            oWpSylarAmbush = GetWaypointByTag(WP_TAG_SYLAR_AMBUSH_JUMP);
            AssignCommand(oActorSylar, ClearAllActions(TRUE));
            DelayCommand(0.5, AssignCommand(oActorSylar, JumpToLocation(GetLocation(oWpSylarAmbush))));

            CutsceneCameraSetup(2.0, 315.0, 5.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);

            CutsceneNext(7.0);
        }
        else if (fTime == 7.0)
        {
            oWpPCAmbush = GetWaypointByTag(WP_TAG_PLAYER_AMBUSH_MOVE);
            AssignCommand(oPC, ClearAllActions(TRUE));
            AssignCommand(oPC, ActionMoveToLocation(GetLocation(oWpPCAmbush)));

            oWpSylarAmbush = GetWaypointByTag(WP_TAG_SYLAR_AMBUSH_MOVE);
            AssignCommand(oActorSylar, ClearAllActions(TRUE));
            AssignCommand(oActorSylar, ActionMoveToLocation(GetLocation(oWpSylarAmbush)));

            FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

            CutsceneNext(13.0);
        }
        else if (fTime == 13.0)
        {
            AssignCommand(oPC, PlaySound("vs_sylar_002"));
            AssignCommand(oActorSylar, SpeakString("Ah, we do appear to have gotten lost."));

            CutsceneNext(15.0);
        }
        else if (fTime == 15.0)
        {
            CutsceneCameraSetup(2.0, 130.0, 9.0, 60.0, CAMERA_TRANSITION_TYPE_SLOW);

            CutsceneNext(20.0);
        }
        else if (fTime == 20.0)
        {
            oWpSylarAmbush = GetWaypointByTag(WP_TAG_SYLAR_AMBUSH_MOVE);
            AssignCommand(oActorSylar, ActionDoCommand(SetFacing(GetFacing(oWpSylarAmbush))));

            thugMove(oPC, 4.0);

            CutsceneNext(24.0);
        }
        else if (fTime == 24.0)
        {
            AssignCommand(oPC, PlaySound("vs_sylar_003"));
            AssignCommand(oActorSylar, SpeakString("Who are these menacing figures melting out of the shadows?", TALKVOLUME_TALK));

            CutsceneNext(29.0);
        }
        else if (fTime == 29.0)
        {
            AssignCommand(oPC, PlaySound("vs_sylar_004"));
            AssignCommand(oActorSylar, SpeakString("Why, it's my old gang! Terribly sorry, friend, but the stupid deserve to die.", TALKVOLUME_TALK));

            CutsceneNext(35.0);
        }
        else if (fTime >= 35.0)
        {
            CutsceneNextShot();
        }
    }
    else
    {
        // PC gets attacked right were he is
        if (fTime == 0.0)
        {
            thugSpawn(WP_TAG_THUG_SPAWN_B, oPC);

            CutsceneNext(1.0);
        }
        else if (fTime == 1.0)
        {
            thugMove(oPC, 5.0);

            CutsceneNext(6.0);
        }
        else if (fTime >= 6.0)
        {
            CutsceneNextShot();
        }
    }
}


// Shot 2: Ends the cutscene
void next2(float fTime)
{
    object oPC = CutsceneGetPC();

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
