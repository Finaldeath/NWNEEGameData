//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_ambush
// DATE: February 25, 2006
// AUTH: Luke Scull
// NOTE: Ambush cutscene.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"


const string WP_TAG_PLAYER_INIT = "WP_cut_ambush_pc_init";

const string PLC_VFX_TARGET = "DracolichEffect";

const string NPC_RESREF_ORDER_WARRIOR = "ambushorderwarri";
const string NPC_TAG_ORDER_WARRIOR = "AmbushOrderWarrior";
const string WP_TAG_ORDER_WARRIOR_INIT = "WP_OrderWarrior_Spawn";
const string WP_TAG_ORDER_WARRIOR_MOVE = "WP_Order_Move";

const string NPC_RESREF_ORDER_WIZARD = "ambushorderwizar";
const string NPC_TAG_ORDER_WIZARD = "AmbushOrderWizard";
const string WP_TAG_ORDER_WIZARD_INIT = "WP_OrderMage_Spawn";

const string NPC_RESREF_ORDER_PRIEST = "ambushorderpries";
const string NPC_TAG_ORDER_PRIEST = "AmbushOrderPriest";
const string WP_TAG_ORDER_PRIEST_INIT = "WP_OrderPriest_Spawn";

const string NPC_RESREF_KARANDAS = "karandas";
const string NPC_TAG_KARANDAS = "Karandas";
const string WP_TAG_KARANDAS_INIT = "WP_Karandas_Spawn";
const string WP_TAG_KARANDAS_MOVE = "WP_Karandas_Flee";
const string WP_TAG_KARANDAS_FINAL = "WP_cut_ambush_karandas_jump";

const string NPC_RESREF_DRACOLICH = "dracolich";
const string NPC_TAG_DRACOLICH = "Dracolich";
const string WP_TAG_DRACOLICH_INIT = "WP_Dracolich_Spawn";
const string WP_TAG_DRACOLICH_MOVE = "WP_Dracolich_Approach";

const string NPC_TAG_CRASTER = "Craster";
const string NPC_TAG_RANGER1 = "craster_ranger1";
const string NPC_TAG_RANGER2 = "craster_ranger2";

const string LVAR_QUEST_UPDATE_DONCE = "cut_ambush_donce";


void questUpdate(object oPC)
{
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 1)
    {
        AddJournalQuestEntry("TheElvenHamlet", 40, oPC);

        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 1);
    }
}


// Kill the NPC in the elven camp
void killElvenCamp()
{
    object oCreature = OBJECT_INVALID;

    oCreature = GetObjectByTag(NPC_TAG_CRASTER);
    if (GetIsObjectValid(oCreature))
    {
        SetPlotFlag(oCreature, FALSE);
        SetImmortal(oCreature, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oCreature);
    }
    oCreature = GetObjectByTag(NPC_TAG_RANGER1);
    if (GetIsObjectValid(oCreature))
    {
        SetPlotFlag(oCreature, FALSE);
        SetImmortal(oCreature, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oCreature);
    }
    oCreature = GetObjectByTag(NPC_TAG_RANGER2);
    if (GetIsObjectValid(oCreature))
    {
        SetPlotFlag(oCreature, FALSE);
        SetImmortal(oCreature, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oCreature);
    }
}


void setupActors(object oPC)
{
    CutsceneSpawnActor(NPC_RESREF_KARANDAS, NPC_TAG_KARANDAS, WP_TAG_KARANDAS_INIT);
    CutsceneSpawnActor(NPC_RESREF_DRACOLICH, NPC_TAG_DRACOLICH, WP_TAG_DRACOLICH_INIT);
    CutsceneSpawnActor(NPC_RESREF_ORDER_WARRIOR, NPC_TAG_ORDER_WARRIOR, WP_TAG_ORDER_WARRIOR_INIT);
    CutsceneSpawnActor(NPC_RESREF_ORDER_WIZARD, NPC_TAG_ORDER_WIZARD, WP_TAG_ORDER_WIZARD_INIT);
    CutsceneSpawnActor(NPC_RESREF_ORDER_PRIEST, NPC_TAG_ORDER_PRIEST, WP_TAG_ORDER_PRIEST_INIT);
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

    setupActors(oPC);

    // Karandas is in Craster's camp
    oActor = CutsceneGetActor(NPC_TAG_KARANDAS);
    oWaypoint = GetWaypointByTag(WP_TAG_KARANDAS_FINAL);
    if (GetIsObjectValid(oActor))
    {
         AssignCommand(oActor, JumpToObject(oWaypoint));
    }

    // Karandas kills Caster and his ranger friends
    killElvenCamp();

    oActor = CutsceneGetActor(NPC_TAG_DRACOLICH);
    oWaypoint = GetWaypointByTag(WP_TAG_DRACOLICH_MOVE);
    AssignCommand(oActor, ActionJumpToLocation(GetLocation(oWaypoint)));
}


void end()
{
    object oPC = CutsceneGetPC();
    DeleteLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE);

    // Karandas kills Caster and his ranger friends
    killElvenCamp();

    ExecuteScript("exe_tm_order", oPC);
}


// Shot 0:
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorKarandas = CutsceneGetActor(NPC_TAG_KARANDAS);
    object oActorDracolich = CutsceneGetActor(NPC_TAG_DRACOLICH);
    object oActorOrderWarrior = CutsceneGetActor(NPC_TAG_ORDER_WARRIOR);
    // Waypoints
    object oWpPlayerInit = GetWaypointByTag(WP_TAG_PLAYER_INIT);
    object oWpDracolichMove = GetWaypointByTag(WP_TAG_DRACOLICH_MOVE);
    object oWpOrderWarriorMove = GetWaypointByTag(WP_TAG_ORDER_WARRIOR_MOVE);
    object oWpKarandasMove = GetWaypointByTag(WP_TAG_KARANDAS_MOVE);
    object oWpKarandasFinal = GetWaypointByTag(WP_TAG_KARANDAS_FINAL);

    object oEffectTarget = GetObjectByTag(PLC_VFX_TARGET);

    if (fTime == 0.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FASTEST);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // Black screen
        setupActors(oPC);

        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWpPlayerInit)));
        //cs_CameraUseCameraWaypoint(0.0, 1, FALSE, OBJECT_SELF, 1);
        CutsceneCameraSetup(0.0, 107.0, 10.0, 89.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_UNDEAD_DRAGON), oEffectTarget, 10.0);

        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        AssignCommand(oActorDracolich, ActionMoveToObject(oWpDracolichMove));

        CutsceneNext(21.0);
    }
    else if (fTime == 21.0)
    {
        // cs_CameraSetFacing(10.0, 30.0, 10.0, 75.0, CAMERA_TRANSITION_TYPE_SLOW);
        CutsceneCameraSetup(0.0, 30.0, 10.0, 75.0, CAMERA_TRANSITION_TYPE_SLOW);

        CutsceneNext(23.0);
    }
    else if (fTime == 23.0)
    {
        AssignCommand(oActorOrderWarrior, ActionMoveToObject(oWpOrderWarriorMove, TRUE));

        CutsceneNext(27.0);
    }
    else if (fTime == 27.0)
    {
        AssignCommand(oPC, SetFacing(90.0));

        CutsceneNext(28.0);
    }
    else if (fTime == 28.0)
    {
        AssignCommand(oActorKarandas, PlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 4.0));
        AssignCommand(oActorKarandas, SpeakString("Maganus said you were unusually strong. No matter. My mother, the Crippled Fang, comes now. You will die here."));
        AssignCommand(oPC, PlaySound("vs_karandas_063"));  // Karandas is too far away, use PC to play sound

        CutsceneNext(41.0);
    }
    else if (fTime == 41.0)
    {
        AssignCommand(oActorKarandas, ActionMoveToObject(oWpKarandasMove, TRUE));

        CutsceneNext(43.0);
    }
    else if (fTime == 43.0)
    {
        // cs_CameraSetFacing(2.5, 110.0, 7.5, 70.0, CAMERA_TRANSITION_TYPE_SLOW);
        CutsceneCameraSetup(0.0, 110.0, 7.5, 70.0, CAMERA_TRANSITION_TYPE_SLOW);

        CutsceneNext(45.0);
    }
    else if (fTime == 45.0)
    {
        AssignCommand(oActorKarandas, JumpToObject(oWpKarandasFinal));

        CutsceneNext(47.0);
    }
    else if (fTime >= 47.0)
    {
        CutsceneNextShot();
    }
}


// Shot 1: Ends cutscene
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
