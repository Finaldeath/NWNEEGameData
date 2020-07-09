//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_unseen1
//:: DATE: January 26, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: The Unseen
//:: Cutscene in Melvaunt warehouse
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_plot"


// The malaugrym Amarune
const string NPC_RESREF_AMARUNE = "tm_cr_amarune0";
const string NPC_TAG_AMARUNE   = "tm_cr_amarune0";
const string WP_TAG_AMARUNE_SPAWN = "WP_cut_unseen1_amarune_init";

// The mind flayer Ootamal
const string NPC_RESREF_OOTAMAL = "tm_cr_ootamal0";
const string NPC_TAG_OOTAMAL   = "tm_cr_ootamal0";
const string WP_TAG_OOTAMAL_SPAWN = "WP_cut_unseen1_ootamal_init";

// The doppelganger Sabarak
const string NPC_RESREF_SABARAK = "tm_cr_sabarak0";
const string NPC_TAG_SABARAK   = "tm_cr_sabarak0";
const string WP_TAG_SABARAK_SPAWN = "WP_cut_unseen1_sabarak_init";

// Doppelgagner enemies (spawn one for every waypoint)
const string NPC_RESREF_DOPPELGANGER = "greaterdoppelgan";
const string NPC_TAG_DOPPELGANGER = "CR_cut_unseen1_doppelganger";
const string WP_TAG_DOPPELGANGER = "WP_cut_unseen1_doppelganger";

const string WP_TAG_PLAYER_INIT = "WP_cut_unseen1_pc_init";
const string WP_TAG_PLAYER_MOVE = "WP_cut_unseen1_pc_move";


void npcAttack(object oAttackTarget)
{
    // Create Doppelgangers and have them attack the PC
    int nNth = 0;
    object oWaypoint = GetObjectByTag(WP_TAG_DOPPELGANGER, nNth);
    object oCreature = OBJECT_INVALID;
    while (GetIsObjectValid(oWaypoint))
    {
        oCreature = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_DOPPELGANGER, GetLocation(oWaypoint), FALSE, NPC_TAG_DOPPELGANGER);
        AssignCommand(oCreature, ClearAllActions(TRUE));
        AssignCommand(oCreature, ActionAttack(oAttackTarget));

        nNth++;
        oWaypoint = GetObjectByTag(WP_TAG_DOPPELGANGER, nNth);
    }

    // Ooatmal and Sabarak attack
    oCreature = CutsceneGetActor(NPC_TAG_OOTAMAL);
    if (GetIsObjectValid(oCreature))
    {
        ExecuteScript("hf_ut_hostile", oCreature);
    }

    oCreature = CutsceneGetActor(NPC_TAG_SABARAK);
    if (GetIsObjectValid(oCreature))
    {
        ExecuteScript("hf_ut_hostile", oCreature);
    }
}


void setupActors(object oPC)
{
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    CutsceneSpawnActor(NPC_RESREF_AMARUNE, NPC_TAG_AMARUNE, WP_TAG_AMARUNE_SPAWN);
    CutsceneSpawnActor(NPC_RESREF_OOTAMAL, NPC_TAG_OOTAMAL, WP_TAG_OOTAMAL_SPAWN);
    CutsceneSpawnActor(NPC_RESREF_SABARAK, NPC_TAG_SABARAK, WP_TAG_SABARAK_SPAWN);
}


void start()
{
    object oPC = CutsceneGetPC();

    CutsceneStart(TRUE, FALSE, "", TRUE);
}


void abort()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;

    BlackScreen(oPC);
    setupActors(oPC);

    // Amarune needs to be destroyed (supposed to be teleported away)
    oActor = CutsceneGetActor(NPC_TAG_AMARUNE);
    if (GetIsObjectValid(oActor))
    {
        DestroyObject(oActor);
    }
}


void end()
{
    object oPC = CutsceneGetPC();
    AssignCommand(oPC, JumpToLocation(GetLocation(GetWaypointByTag(WP_TAG_PLAYER_INIT))));

    DelayCommand(1.5, npcAttack(oPC));
}


// Shot 0: Dialog
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorAmarune = CutsceneGetActor(NPC_TAG_AMARUNE);
    object oActorSabarak = CutsceneGetActor(NPC_TAG_SABARAK);
    object oActorOotamal = CutsceneGetActor(NPC_TAG_OOTAMAL);
    // Waypoints
    object oWpPlayerInit = GetWaypointByTag(WP_TAG_PLAYER_INIT);
    object oWpPlayerMove = GetWaypointByTag(WP_TAG_PLAYER_MOVE);

    if (fTime == 0.0)
    {
        BlackScreen(oPC);

        AssignCommand(oPC, JumpToLocation(GetLocation(oWpPlayerInit)));
        CutsceneCameraSetup(2.0, 90.0, 2.0, 89.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        setupActors(oPC);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        // Move WP is 10.0 away, takes 5.0s to reach at default PC walk speed
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionMoveToLocation(GetLocation(oWpPlayerMove), FALSE));

        CutsceneCameraSetup(2.0, 80.0, 4.0, 70.0, CAMERA_TRANSITION_TYPE_SLOW);

        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        AssignCommand(oActorSabarak, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0));
        AssignCommand(oActorSabarak, SpeakString("Your son is a liability, Shadowmaster Amarune! He answers to no one except himself! Where is he now? Where is your daughter? Hlaavin will not be pleased.", TALKVOLUME_TALK));
        AssignCommand(oPC, PlaySound("vs_dopplegan_001"));

        CutsceneNext(24.0);
    }
    else if (fTime == 24.0)
    {
        AssignCommand(oActorAmarune, SpeakString("I care not for Hlaavin! I will deal with Eremuth. Now cease your prattle - there are intruders here!", TALKVOLUME_TALK));
        AssignCommand(oPC, PlaySound("vs_malaugrym_001"));

        CutsceneNext(30.0);
    }
    else if (fTime == 30.0)
    {
        AssignCommand(oActorAmarune, ActionCastFakeSpellAtObject(SPELL_CURE_MINOR_WOUNDS, oActorAmarune));

        CutsceneNext(31.0);
    }
    else if (fTime == 31.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1), oActorAmarune);
        DestroyObject(oActorAmarune);

        CutsceneNext(33.0);
    }
    else if (fTime >= 33.0)
    {
        CutsceneNextShot();
    }
}


// Shot 1: End cutscene
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
