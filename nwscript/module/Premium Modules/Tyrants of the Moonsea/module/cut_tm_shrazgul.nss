//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_shrazgul
// DATE: October 29, 2005
// AUTH: Luke Scull
// NOTE: Cutscene and dialogue with Shrazgul.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"


const string PLC_TAG_VOICE = "VoicefromtheDarkness";

const string NPC_TAG_SHRAZGUL = "Shrazgul";
const string NPC_TAG_GUARD1 = "ShrazgulGuard1";
const string NPC_TAG_GUARD2 = "ShrazgulGuard2";

const string WP_TAG_PLAYER = "WP_Shrazgul_Player";
const string WP_TAG_SHRAZGUL_MOVE = "WP_Shrazgul_Move";
const string WP_TAG_DIREGUARD1_MOVE1 = "WP_Direguard1_Move1";
const string WP_TAG_DIREGUARD1_MOVE2 = "WP_Direguard1_Move2";
const string WP_TAG_DIREGUARD2_MOVE1 = "WP_Direguard2_Move1";
const string WP_TAG_DIREGUARD2_MOVE2 = "WP_Direguard2_Move2";

const string LVAR_SPELL_PRECAST_DONCE = "cut_shrazg_donce";


// Pre-Buff sequence on NPC (makes sure it is only done once)
void setupSpellPrecast(object oTarget)
{
    if (GetLocalInt(oTarget, LVAR_SPELL_PRECAST_DONCE) == 0)
    {
        AssignCommand(oTarget, ActionCastSpellAtObject(SPELL_REGENERATE, oTarget,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
        AssignCommand(oTarget, ActionCastSpellAtObject(SPELL_BATTLETIDE, oTarget,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
        AssignCommand(oTarget, ActionCastSpellAtObject(SPELL_TRUE_SEEING, oTarget,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
        AssignCommand(oTarget, ActionCastSpellAtObject(SPELL_DIVINE_POWER, oTarget,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
        AssignCommand(oTarget, ActionCastSpellAtObject(SPELL_STONE_BONES, oTarget,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
        AssignCommand(oTarget, ActionCastSpellAtObject(SPELL_ENTROPIC_SHIELD, oTarget,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
        AssignCommand(oTarget, ActionCastSpellAtObject(SPELL_SHIELD_OF_FAITH, oTarget,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
        SetLocalInt(oTarget, LVAR_SPELL_PRECAST_DONCE, 1);
    }
}


void setupActors(object oPC)
{
    object oActor;

    oActor = GetObjectInArea(PLC_TAG_VOICE, oPC);
    CutsceneAddActor(PLC_TAG_VOICE, oActor);

    oActor = GetObjectInArea(NPC_TAG_SHRAZGUL, oPC);
    CutsceneAddActor(NPC_TAG_SHRAZGUL, oActor);

    oActor = GetObjectInArea(NPC_TAG_GUARD1, oPC);
    CutsceneAddActor(NPC_TAG_GUARD1, oActor);

    oActor = GetObjectInArea(NPC_TAG_GUARD2, oPC);
    CutsceneAddActor(NPC_TAG_GUARD2, oActor);
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
    // Actors
    object oActorShrazgul = CutsceneGetActor(NPC_TAG_SHRAZGUL);
    object oActorGuard1 = CutsceneGetActor(NPC_TAG_GUARD1);
    object oActorGuard2 = CutsceneGetActor(NPC_TAG_GUARD2);
    // Waypoints
    object oShrazgulWP = GetObjectInArea(WP_TAG_SHRAZGUL_MOVE, oPC);
    object oGuard1WP = GetObjectInArea(WP_TAG_DIREGUARD1_MOVE2, oPC);
    object oGuard2WP = GetObjectInArea(WP_TAG_DIREGUARD2_MOVE2, oPC);

    // Jump characters into position
    AssignCommand(oActorShrazgul, ClearAllActions());
    AssignCommand(oActorShrazgul, ActionJumpToObject(oShrazgulWP));
    AssignCommand(oActorGuard1, ClearAllActions());
    AssignCommand(oActorGuard1, ActionJumpToObject(oGuard1WP));
    AssignCommand(oActorGuard2, ClearAllActions());
    AssignCommand(oActorGuard2, ActionJumpToObject(oGuard2WP));

    // Make sure Shrazgul has been buffed
    setupSpellPrecast(oActorShrazgul);
}


void end()
{
    object oPC = CutsceneGetPC();

    object oActorVoice = CutsceneGetActor(PLC_TAG_VOICE);
    if (GetIsObjectValid(oActorVoice))
    {
        SetPlotFlag(oActorVoice, FALSE);
        DestroyObject(oActorVoice, 0.1f);
    }

    DelayCommand(1.0, ExecuteScript("exe_tm_shrazgul", oPC));
}


// Shot 0: Initiate Dialog
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorVoice = CutsceneGetActor(PLC_TAG_VOICE);
    object oActorShrazgul = CutsceneGetActor(NPC_TAG_SHRAZGUL);
    // Waypoint (get only on demand)
    object oPlayerWP = OBJECT_INVALID;

    if (fTime == 0.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FASTEST);

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        // Setup during black screen
        setupActors(oPC);

        oPlayerWP = GetObjectInArea(WP_TAG_PLAYER, oPC);
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionJumpToObject(oPlayerWP));

        CutsceneNext(2.0);
    }
    else if (fTime >= 2.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        AssignCommand(oActorVoice, ActionStartConversation(oPC, "", FALSE, FALSE));
        CutsceneCameraSetup(0.0, 347.0, 2.5, 80.0, CAMERA_TRANSITION_TYPE_SNAP);

        // Called from dialog
        // CutsceneNextShot();
    }
}


// Shot 1: Move Enemies into position
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorShrazgul = CutsceneGetActor(NPC_TAG_SHRAZGUL);
    object oActorGuard1 = CutsceneGetActor(NPC_TAG_GUARD1);
    object oActorGuard2 = CutsceneGetActor(NPC_TAG_GUARD2);
    // Waypoint (get only on demand)
    object oShrazgulWP = OBJECT_INVALID;
    object oGuard1WP = OBJECT_INVALID;
    object oGuard2WP = OBJECT_INVALID;

    if (fTime == 0.0)
    {
        oGuard1WP = GetObjectInArea(WP_TAG_DIREGUARD1_MOVE1, oPC);
        oGuard2WP = GetObjectInArea(WP_TAG_DIREGUARD2_MOVE1, oPC);

        AssignCommand(oActorGuard1, ActionMoveToObject(oGuard1WP, TRUE));
        AssignCommand(oActorGuard2, ActionMoveToObject(oGuard2WP, TRUE));

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        oGuard1WP = GetObjectInArea(WP_TAG_DIREGUARD1_MOVE2, oPC);
        oGuard2WP = GetObjectInArea(WP_TAG_DIREGUARD2_MOVE2, oPC);

        AssignCommand(oActorGuard1, ActionMoveToObject(oGuard1WP, TRUE));
        AssignCommand(oActorGuard2, ActionMoveToObject(oGuard2WP, TRUE));

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        object oShrazgulWP = GetObjectInArea(WP_TAG_SHRAZGUL_MOVE, oPC);

        AssignCommand(oActorShrazgul, ClearAllActions());
        AssignCommand(oActorShrazgul, ActionMoveToObject(oShrazgulWP, FALSE));

        CutsceneNext(6.0);
    }
    else if (fTime >= 6.0)
    {
        setupSpellPrecast(oActorShrazgul);

        CutsceneNextShot();
    }
}


// Shot 2: End Cutscene
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
