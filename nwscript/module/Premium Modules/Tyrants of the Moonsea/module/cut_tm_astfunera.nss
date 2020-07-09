//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_astfunera
//:: DATE: January 04, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Astar's death cutscene
//:: The trigger for this cutscene is inactive by
//:: default and is activated in "cut_tm_astdeath"
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "hf_in_util"

const string NPC_RESREF_LYRESSA = "lyressa";
const string NPC_TAG_LYRESSA = "Lyressa";
const string WP_TAG_LYRESSA_INIT = "WP_cut_astfunera_lyressa_init";

const string NPC_RESREF_SHARALYN_HENCH = "sharalynhenchman";
const string NPC_TAG_SHARALYN_HENCH = "SharalynHenchman";

const string NPC_RESREF_SHARALYN = "sharalynelventre";
const string NPC_TAG_SHARALYN = "SharalynElventree";
const string WP_TAG_SHARALYN_INIT = "WP_cut_astfunera_sharalyn_init";
const string WP_TAG_SHARALYN_FINAL = "WP_Sharalyn_Swaying";

const string NPC_RESREF_HILRAD  = "hilradthepatient";
const string NPC_TAG_HILRAD = "HilradthePatient";
const string WP_TAG_HILRAD_INIT = "WP_cut_astfunera_hilrad_init";

const string NPC_TAG_ARCHER = "CR_cut_astfunera_archer";
const string WP_TAG_ARCHER_INIT = "WP_cut_astfunera_archer_spawn";

const string PLC_TAG_ARCHER_TARGET = "PL_cut_astfunera_target";

const string PLC_RESREF_BOAT = "tm_pl_astarboat0";
const string PLC_TAG_BOAT = "PL_cut_astfunera_boat";
const string WP_TAG_BOAT_SPAWN = "WP_cut_astfunera_boat_spawn";

const string WP_TAG_PLAYER_INIT = "WP_cut_astfunera_pc_init";
const string WP_TAG_PLAYER_FINAL = "WP_Player_Swaying";


// Switches "Sharalyn" to "SharalynHench" to make her available as henchman
void switchSharalyn(object oPC)
{
    int nNth = 0;
    object oObjectToRemove = OBJECT_INVALID;

    // Remove all occurences of "Sharalyn" from the module
    nNth = 0;
    oObjectToRemove = GetObjectByTag("Sharalyn", nNth);
    while (GetIsObjectValid(oObjectToRemove))
    {
        DestroyObject(oObjectToRemove);

        nNth++;
        oObjectToRemove = GetObjectByTag("Sharalyn", nNth);
    }

    // Remove all occurences of "SharalynElventree" from the module
    nNth = 0;
    oObjectToRemove = GetObjectByTag("SharalynElventree", nNth);
    while (GetIsObjectValid(oObjectToRemove))
    {
        DestroyObject(oObjectToRemove);

        nNth++;
        oObjectToRemove = GetObjectByTag("SharalynElventree", nNth);
    }

    // Create SharalynHenchman
    object oWaypoint = GetWaypointByTag(WP_TAG_SHARALYN_FINAL);
    CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_SHARALYN_HENCH, GetLocation(oWaypoint));
}


// Updates quest variable at the end of the cutscene
void updateQuestEnd(object oPC)
{
    // Finish Elven Hamlet Quest
    AddJournalQuestEntry("TheElvenHamlet", 80, oPC);
    GiveXPToCreature(oPC, GetJournalQuestExperience("TheElvenHamlet"));

    CreateItemOnObject("harperpin", oPC);
}


void setupActors(object oPC)
{
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    // Boat Astar's body is laying on
    oActor = GetObjectByTag(PLC_TAG_BOAT);
    if (!GetIsObjectValid(oActor))
    {
        oWaypoint = GetWaypointByTag(WP_TAG_BOAT_SPAWN);
        CreateObject(OBJECT_TYPE_PLACEABLE, PLC_RESREF_BOAT, GetLocation(oWaypoint), FALSE, PLC_TAG_BOAT);
    }

    // Add Lyressa
    oWaypoint = GetWaypointByTag(WP_TAG_LYRESSA_INIT);
    oActor = GetObjectInArea(NPC_TAG_LYRESSA, oWaypoint);
    if (!GetIsObjectValid(oActor))
    {
        oActor = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_LYRESSA, GetLocation(oWaypoint));

        CutsceneAddActor(NPC_TAG_LYRESSA, oActor);
    }

    // Add Hilrad
    oWaypoint = GetWaypointByTag(WP_TAG_HILRAD_INIT);
    oActor = GetObjectInArea(NPC_TAG_HILRAD, oWaypoint);
    if (!GetIsObjectValid(oActor))
    {
        oActor = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_HILRAD, GetLocation(oWaypoint));

        CutsceneAddActor(NPC_TAG_HILRAD, oActor);
    }

    // Add Sharalyn
    oWaypoint = GetWaypointByTag(WP_TAG_SHARALYN_INIT);
    oActor = GetObjectInArea(NPC_TAG_SHARALYN, oWaypoint);
    if (!GetIsObjectValid(oActor))
    {
        oActor = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_SHARALYN, GetLocation(oWaypoint));

        CutsceneAddActor(NPC_TAG_SHARALYN, oActor);
    }

    // Add an archer
    oActor = CutsceneGetActor(NPC_TAG_ARCHER);
    if (!GetIsObjectValid(oActor))
    {
        oActor = GetObjectByTag(NPC_TAG_ARCHER);
        CutsceneAddActor(NPC_TAG_ARCHER, oActor);

        AssignCommand(oActor, ClearAllActions(TRUE));
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

    setupActors(oPC);
}


void end()
{
    object oPC = CutsceneGetPC();
    object oWaypoint = GetWaypointByTag(WP_TAG_PLAYER_INIT);

    // Get rid of Astars funeral boat
    object oBoat = GetObjectByTag(PLC_TAG_BOAT);
    if (GetIsObjectValid(oBoat))
    {
        DestroyObject(oBoat);
    }

    // Destroy Hilrad in current area/ cutscene
    object oHilrad = GetObjectInArea(NPC_TAG_HILRAD, oWaypoint);
    if (GetIsObjectValid(oHilrad))
    {
        DestroyObject(oHilrad, 1.0f);
    }

    // Destroy Lyressa in current area/ cutscene
    object oLyressa = GetObjectInArea(NPC_TAG_LYRESSA, oWaypoint);
    if (GetIsObjectValid(oLyressa))
    {
        DestroyObject(oLyressa, 1.0f);
    }

    // Will take care of all Sharalyn instances
    switchSharalyn(oPC);

    updateQuestEnd(oPC);

     // Jump player back to  Elventree
    oWaypoint = GetWaypointByTag(WP_TAG_PLAYER_FINAL);
    AssignCommand(oPC, ClearAllActions(TRUE));
    DelayCommand(1.0f, AssignCommand(oPC, JumpToLocation(GetLocation(oWaypoint))));
}


// Shot 0:
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Waypoints
    object oWpPlayerInit = GetWaypointByTag(WP_TAG_PLAYER_INIT);

    if (fTime == 0.0)
    {
        BlackScreen(oPC);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        setupActors(oPC);

        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWpPlayerInit)));
        CutsceneCameraSetup(2.0, 70.0, 10.0, 55.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_SLOW);

        CutsceneNext(5.0);
    }
    else if (fTime >= 5.0)
    {
        CutsceneNextShot();
    }
}


// Shot 1: Boat starts to move
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorLyressa = CutsceneGetActor(NPC_TAG_LYRESSA);
    object oActorArcher = CutsceneGetActor(NPC_TAG_ARCHER);
    // Waypoints
    object oWpPlayerInit = GetWaypointByTag(WP_TAG_PLAYER_INIT);
    object oArcherTargetPlc = GetObjectByTag(PLC_TAG_ARCHER_TARGET);

    if (fTime == 0.0)
    {
        // Boat moves a distance of 40m (at 1 m/s with default animation speed)
        object oBoat = GetObjectByTag(PLC_TAG_BOAT);
        AssignCommand(oBoat, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE, 0.5));

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        CutsceneCameraSetup(2.0, 90.0, 8.0, 85.0, CAMERA_TRANSITION_TYPE_VERY_SLOW);

        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        //AssignCommand(oActorArcher, ActionCastFakeSpellAtObject(SPELL_TRAP_ARROW, oArcherTargetPlc, PROJECTILE_PATH_TYPE_HOMING));
        //AssignCommand(oActorArcher, ActionCastSpellAtObject(
        //    SPELL_FLAME_ARROW, oArcherTargetPlc, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_HOMING, TRUE));
        AssignCommand(oActorArcher, ClearAllActions(TRUE));
        AssignCommand(oActorArcher, ActionAttack(oArcherTargetPlc));

        CutsceneNext(26.0);
    }
    else if (fTime == 26.0)
    {
        FadeToBlack(oPC, FADE_SPEED_SLOWEST);

        CutsceneNext(32.0);
    }

    else if (fTime >= 32.0)
    {
        CutsceneNextShot();
    }
}


// Shot 2: Ends cutscene
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

