//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_artemis
//::////////////////////////////////////////////////////
//:: Artemis Entreri cutscene on Shind Road
//:: Artemis attacks Astar if present on map
//::////////////////////////////////////////////////////

#include "nw_i0_generic"

#include "hf_in_cutscene"
#include "hf_in_util"
#include "hf_in_plot"

const string NPC_RESREF_ARTEMIS = "artemisentreri";
const string NPC_TAG_ARTEMIS = "ArtemisEntreri";
const string WP_TAG_ARTEMIS_SPAWN = "WP_cut_artemis_art_spawn";
const string WP_TAG_ARTEMIS_MOVE = "WP_cut_artemis_art_move";

const string NPC_RESREF_OPPONENT0 = "tm_cr_art_slaadb";
const string NPC_TAG_OPPONENT0 = "cr_cut_artemis_oppo0";
const string WP_TAG_OPPONENT0_SPAWN = "WP_cut_artemis_opponent0_spawn";
const string WP_TAG_OPPONENT0_MOVE = "WP_cut_artemis_opponent0_move";

const string NPC_RESREF_OPPONENT1 = "tm_cr_art_slaadr";
const string NPC_TAG_OPPONENT1 = "cr_cut_artemis_oppo1";
const string WP_TAG_OPPONENT1_SPAWN = "WP_cut_artemis_opponent1_spawn";
const string WP_TAG_OPPONENT1_MOVE = "WP_cut_artemis_opponent1_move";

const string NPC_RESREF_OPPONENT2 = "tm_cr_art_slaadr";
const string NPC_TAG_OPPONENT2 = "cr_cut_artemis_oppo2";
const string WP_TAG_OPPONENT2_SPAWN = "WP_cut_artemis_opponent2_spawn";
const string WP_TAG_OPPONENT2_MOVE = "WP_cut_artemis_opponent2_move";

const string WP_TAG_PLAYER_INIT = "WP_cut_artemis_pc_init";


// Artemis will only draw his weapons when he notices the enemies
void artemisEquipWeapons(object oTarget)
{
    object oItem = OBJECT_INVALID;

    // Right Hand
    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
    if (!GetIsObjectValid(oItem))
    {
        oItem = GetItemPossessedBy(oTarget, "CharonsClaw");
        AssignCommand(oTarget, ActionEquipItem(oItem, INVENTORY_SLOT_RIGHTHAND));
    }

    // Left Hand
    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
    if (!GetIsObjectValid(oItem))
    {
        oItem = GetItemPossessedBy(oTarget, "4VampiricDefendingDagger");
        AssignCommand(oTarget, ActionEquipItem(oItem, INVENTORY_SLOT_LEFTHAND));
    }
}


// This will prevent the cutscene battle from taking too much time.
void damageEnemy(object oTarget, int nLeftoverHP)
{
    if (GetIsObjectValid(oTarget) && (nLeftoverHP > 0))
    {
        int nCurrentHP = GetCurrentHitPoints(oTarget);
        if ((nCurrentHP > nLeftoverHP))
        {
            int nDamage = nCurrentHP - nLeftoverHP;
            effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_ENERGY);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);

            effect eACDecrease = EffectACDecrease(10, AC_DODGE_BONUS);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eACDecrease, oTarget);
        }
    }
}


void removeAllEffects(object oTarget)
{
    if (GetIsObjectValid(oTarget))
    {
        effect eEffect = GetFirstEffect(oTarget);
        while (GetIsEffectValid(eEffect))
        {
            RemoveEffect(oTarget, eEffect);
            eEffect = GetNextEffect(oTarget);
        }
    }
}


void setupActors(object oPC)
{
    object oActor = OBJECT_INVALID;

    CutsceneSpawnActor(NPC_RESREF_ARTEMIS, NPC_TAG_ARTEMIS, WP_TAG_ARTEMIS_SPAWN);

    // Damage the Enemies so the battle doesn't take forever
    oActor = CutsceneSpawnActor(NPC_RESREF_OPPONENT0, NPC_TAG_OPPONENT0, WP_TAG_OPPONENT0_SPAWN);
    damageEnemy(oActor, 6);
    oActor = CutsceneSpawnActor(NPC_RESREF_OPPONENT1, NPC_TAG_OPPONENT1, WP_TAG_OPPONENT1_SPAWN);
    damageEnemy(oActor, 6);
    oActor = CutsceneSpawnActor(NPC_RESREF_OPPONENT2, NPC_TAG_OPPONENT2, WP_TAG_OPPONENT2_SPAWN);
    damageEnemy(oActor, 6);

}


void start()
{
    object oPC = CutsceneGetPC();

    AssignCommand(oPC, SetCameraFacing(280.0, 6.0, 65.0, CAMERA_TRANSITION_TYPE_SNAP));
    AssignCommand(oPC, StoreCameraFacing());

    CutsceneStart(TRUE, FALSE, "", FALSE);
}


void abort()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    BlackScreen(oPC);
    setupActors(oPC);

    // Kill the Slaadi (they should leave a corpse)
    oActor = CutsceneGetActor(NPC_TAG_OPPONENT0);
    if (GetIsObjectValid(oActor))
    {
        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(FALSE, TRUE), oActor));
    }

    oActor = CutsceneGetActor(NPC_TAG_OPPONENT1);
    if (GetIsObjectValid(oActor))
    {
        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(FALSE, TRUE), oActor));
    }

    oActor = CutsceneGetActor(NPC_TAG_OPPONENT2);
    if (GetIsObjectValid(oActor))
    {
        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(FALSE, TRUE), oActor));
    }

    // Jump Artemis directly to final dest.
    oActor = CutsceneGetActor(NPC_TAG_ARTEMIS);
    oWaypoint = GetWaypointByTag(WP_TAG_ARTEMIS_MOVE);
    AssignCommand(oActor, ClearAllActions(TRUE));
    AssignCommand(oActor, JumpToLocation(GetLocation(oWaypoint)));
}


void end()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;
}


// Shot 0: Artemis walks along the road
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorArtemis = CutsceneGetActor(NPC_TAG_ARTEMIS);
    object oActorOpponent0 = CutsceneGetActor(NPC_TAG_OPPONENT0);
    object oActorOpponent1 = CutsceneGetActor(NPC_TAG_OPPONENT1);
    object oActorOpponent2 = CutsceneGetActor(NPC_TAG_OPPONENT2);
    // Waypoint
    object oWpPlayerInit = OBJECT_INVALID;
    object oWpArtemisMove = OBJECT_INVALID;
    object oWpOpponent0Move = GetWaypointByTag(WP_TAG_OPPONENT0_MOVE);
    object oWpOpponent1Move = GetWaypointByTag(WP_TAG_OPPONENT1_MOVE);
    object oWpOpponent2Move = GetWaypointByTag(WP_TAG_OPPONENT2_MOVE);

    if (fTime == 0.0)
    {
        BlackScreen(oPC);

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        setupActors(oPC);

        oWpPlayerInit = GetWaypointByTag(WP_TAG_PLAYER_INIT);
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, JumpToLocation(GetLocation(oWpPlayerInit)));

        CutsceneCameraSetup(3.0, 280.0, 6.0, 65.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        oWpArtemisMove = GetWaypointByTag(WP_TAG_ARTEMIS_MOVE);
        AssignCommand(oActorArtemis, ClearAllActions(TRUE));
        AssignCommand(oActorArtemis, ActionMoveToObject(oWpArtemisMove));

        FadeFromBlack(oPC, FADE_SPEED_SLOWEST);

        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        // Enemies approach
        oWpOpponent0Move = GetWaypointByTag(WP_TAG_OPPONENT0_MOVE);
        oWpOpponent1Move = GetWaypointByTag(WP_TAG_OPPONENT1_MOVE);
        oWpOpponent2Move = GetWaypointByTag(WP_TAG_OPPONENT2_MOVE);

        AssignCommand(oActorOpponent0, ClearAllActions(TRUE));
        AssignCommand(oActorOpponent0, ActionMoveToObject(oWpOpponent0Move));

        AssignCommand(oActorOpponent1, ClearAllActions(TRUE));
        AssignCommand(oActorOpponent1, ActionMoveToObject(oWpOpponent1Move));

        AssignCommand(oActorOpponent2, ClearAllActions(TRUE));
        AssignCommand(oActorOpponent2, ActionMoveToObject(oWpOpponent2Move));

        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        // Artemis arrived at waypoint
        AssignCommand(oPC, PlaySound("vs_entreri_066"));
        AssignCommand(oActorArtemis, SpeakString("Pathetic."));


        CutsceneNext(13.0);
    }
    else if (fTime == 13.0)
    {
        AssignCommand(oActorArtemis, artemisEquipWeapons(oActorArtemis));

        CutsceneNext(14.0);
    }
    else if (fTime >= 14.0)
    {
        CutsceneNextShot();
    }
}


// Shot 1: Battle begins
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorArtemis = CutsceneGetActor(NPC_TAG_ARTEMIS);
    object oActorOpponent0 = CutsceneGetActor(NPC_TAG_OPPONENT0);
    object oActorOpponent1 = CutsceneGetActor(NPC_TAG_OPPONENT1);
    object oActorOpponent2 = CutsceneGetActor(NPC_TAG_OPPONENT2);

    if (fTime == 0.0)
    {
        AssignCommand(oActorOpponent0, ClearAllActions(TRUE));
        AssignCommand(oActorOpponent0, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        AssignCommand(oPC, PlaySound("c_orcchf_bat1"));

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        ChangeToStandardFaction(oActorOpponent0, STANDARD_FACTION_HOSTILE);
        ChangeToStandardFaction(oActorOpponent1, STANDARD_FACTION_HOSTILE);
        ChangeToStandardFaction(oActorOpponent2, STANDARD_FACTION_HOSTILE);

        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oActorArtemis, DetermineCombatRound());
        AssignCommand(oActorArtemis, ActionAttack(oActorOpponent0));

        AssignCommand(oActorOpponent0, DetermineCombatRound());
        AssignCommand(oActorOpponent0, ActionAttack(oActorArtemis));

        AssignCommand(oActorOpponent1, DetermineCombatRound());
        AssignCommand(oActorOpponent1, ActionAttack(oActorArtemis));

        AssignCommand(oActorOpponent2, DetermineCombatRound());
        AssignCommand(oActorOpponent2, ActionAttack(oActorArtemis));

        CutsceneNext(7.0);
    }
    else if (fTime >= 7.0)
    {
        CutsceneNextShot();
    }
}


// Shot 2: End cutscene
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
