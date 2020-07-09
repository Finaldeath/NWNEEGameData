//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_arena4b
//:: DATE: February 28, 2006
//:: AUTH: Luke Scull
//:: NOTE: Hillsfar Arena cutscene
//::////////////////////////////////////////////////////
//:: Post fight cutscene in 4th arena sequence
//:: (Minotaur)
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "hf_in_util"

#include "cut_tm_arena_inc"


void updateQuestEnd(object oPC)
{
    AddJournalQuestEntry("TheArena", 100, oPC);
    SetLocalInt(oPC, "arena", 4);

    // Setup Blizzard in Cells
    PlotLevelSet(NPC_TAG_BLIZZARD, 5);
    object oBlizzardCellsWP = GetWaypointByTag(WP_TAG_GARTH_CELLS);
    object oBlizzardCells = GetObjectInArea(NPC_TAG_BLIZZARD, oBlizzardCellsWP);
    if (GetIsObjectValid(oBlizzardCells))
    {
        // Blizzard has recovered
        AssignCommand(oBlizzardCells, ClearAllActions(TRUE));
        // DelayCommand(0.5f, AssignCommand(oBlizzardCells, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 1800.0)));
    }

    // Destroy Garth in Arena
    object oGarthArenaWP = GetWaypointByTag(WP_TAG_GARTH_INIT);
    object oGarthArena = GetObjectInArea(NPC_TAG_GARTH, oGarthArenaWP);
    if (GetIsObjectValid(oGarthArena))
        DestroyObject(oGarthArena);

    // Setup Elf in the Cells
    object oElfArenaWP = GetWaypointByTag(WP_TAG_ELF_INIT);
    object oElfArena = GetObjectInArea(NPC_TAG_ELF, oElfArenaWP);
    if (PlotLevelGet("Elf-Arena-Outcome") == 0)
    {
        if ( GetIsObjectValid(oElfArena) && !GetIsDead(oElfArena) )
        {
            object oElfCellsWP = GetWaypointByTag(WP_TAG_ELF_CELLS);
            object oElfCells = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_ELF, GetLocation(oElfCellsWP), FALSE, NPC_TAG_ELF);
        }
    }

    // Destroy Elf in Arena
    if (GetIsObjectValid(oElfArena))
        DestroyObject(oElfArena);

}


// Spawn as many Red Plumes as there are waypoints for them (in pairs of two)
void spawnGuards(object oPC, int nCnt=0)
{
    // Spawn two guards if there are waypoint for them
    object oWpDestinationA = GetWaypointByTag(WP_TAG_GUARDx_DESTINATION + IntToString(nCnt));
    object oWpDestinationB = GetWaypointByTag(WP_TAG_GUARDx_DESTINATION + IntToString(nCnt+1));

    object oGuard = OBJECT_INVALID;
    object oWpSpawn = OBJECT_INVALID;

    if (GetIsObjectValid(oWpDestinationA) && GetIsObjectValid(oWpDestinationB) && (nCnt < 20))
    {
        oWpSpawn = GetWaypointByTag(WP_TAG_MAIN_GATE_A);
        oGuard = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_GUARD, GetLocation(oWpSpawn), FALSE, NPC_TAG_GUARDx + IntToString(nCnt));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oGuard, 8.0);
        AssignCommand(oGuard, ActionMoveToObject(oWpDestinationA, TRUE, 0.1));
        AssignCommand(oGuard, ActionDoCommand(SetFacing(GetFacing(oWpDestinationA))));

        oWpSpawn = GetWaypointByTag(WP_TAG_MAIN_GATE_B);
        oGuard = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_GUARD, GetLocation(oWpSpawn), FALSE, NPC_TAG_GUARDx + IntToString(nCnt+1));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oGuard, 8.0);
        AssignCommand(oGuard, ActionMoveToObject(oWpDestinationB, TRUE, 0.1));
        AssignCommand(oGuard, ActionDoCommand(SetFacing(GetFacing(oWpDestinationB))));
    }

    DelayCommand(1.0f, spawnGuards(oPC, nCnt+2));
}


// Get rid of all Guards
void deleteGuards(object oPC)
{
    int i = 0;
    object oGuard = OBJECT_INVALID;
    for (i = 0; i<22; i++)
    {
        oGuard = GetObjectByTag(NPC_TAG_GUARDx + IntToString(i));
        if (GetIsObjectValid(oGuard))
            DestroyObject(oGuard);
    }
}


void setupActors(object oPC)
{
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    oActor = GetObjectByTag(NPC_TAG_ANNOUNCER);
    CutsceneAddActor(NPC_TAG_ANNOUNCER, oActor);

    oActor = GetObjectByTag(NPC_TAG_GARTH);
    CutsceneAddActor(NPC_TAG_GARTH, oActor);

    oActor = GetObjectByTag(NPC_TAG_MINOTAUR);
    CutsceneAddActor(NPC_TAG_MINOTAUR, oActor);

    // Jump Elf out of the way but keep in current area (if still alive)
    object oElf = GetNearestObjectByTag(NPC_TAG_ELF, oPC);
    if (GetIsObjectValid(oElf) && !GetIsDead(oElf))
    {
        oWaypoint = GetWaypointByTag(WP_TAG_PLAYER_GATE);
        AssignCommand(oElf, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oElf, JumpToLocation(GetLocation(oWaypoint))));
        CutsceneAddActor(NPC_TAG_ELF, oElf);
    }

    object oMaalthirWP = GetWaypointByTag(WP_TAG_MAALTHIR_INIT);
    object oMaalthir = CutsceneGetActor(NPC_TAG_MAALTHIR);
    if (!GetIsObjectValid(oMaalthir))
    {
        oMaalthir = GetObjectInArea(NPC_TAG_MAALTHIR, oMaalthirWP);
        AssignCommand(oMaalthir, ClearAllActions(TRUE));

        CutsceneAddActor(NPC_TAG_MAALTHIR, oMaalthir);
    }

    object oInnovatorWP = GetWaypointByTag(WP_TAG_INNOVATOR_INIT);
    object oInnovator = CutsceneGetActor(NPC_TAG_INNOVATOR);
    if (!GetIsObjectValid(oInnovator))
    {
        oInnovator = GetObjectInArea(NPC_TAG_INNOVATOR, oInnovatorWP);
        AssignCommand(oInnovator, ClearAllActions(TRUE));

        CutsceneAddActor(NPC_TAG_INNOVATOR, oInnovator);
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

    BlackScreen(oPC);
    setupActors(oPC);

    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
}


void end()
{
    object oPC = CutsceneGetPC();

    updateQuestEnd(oPC);

    // Ensure Minotaur is removed (should be dead)
    object oMinotaur = GetObjectByTag(NPC_TAG_MINOTAUR);
    if (GetIsObjectValid(oMinotaur))
        DestroyObject(oMinotaur);

    // Get rid of spawned in guards
    deleteGuards(oPC);

    // Close Main Gate
    object oDoor = GetObjectByTag(DOOR_TAG_ARENA_MAIN);
    AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
    DelayCommand(1.0f, SetLocked(oDoor, TRUE));

    // Destroy Arena Maalthir
    object oMaalthirWP = GetWaypointByTag(WP_TAG_MAALTHIR_TALK);
    object oMaalthir = GetObjectInArea(NPC_TAG_MAALTHIR, oMaalthirWP);
    if (GetIsObjectValid(oMaalthir))
        DestroyObject(oMaalthir);

    // Destroy Arena Innovator
    object oInnovatorWP = GetWaypointByTag(WP_TAG_INNOVATOR_TALK);
    object oInnovator = GetObjectInArea(NPC_TAG_INNOVATOR, oInnovatorWP);
    if (GetIsObjectValid(oInnovator))
        DestroyObject(oInnovator);

    // Destroy Cells Innovator
    object oInnovatorCellWP = GetWaypointByTag(WP_TAG_PLAYER_CELLS);
    object oInnovatorCell = GetObjectInArea(NPC_TAG_INNOVATOR, oInnovatorCellWP);
    if (GetIsObjectValid(oInnovatorCell))
        DestroyObject(oInnovatorCell);

    // Destroy Arena Elf
    object oElfWP = GetWaypointByTag(WP_TAG_ELF_INIT);
    object oElf = GetObjectInArea(NPC_TAG_ELF, oElfWP);
    if (GetIsObjectValid(oElf))
        DestroyObject(oElf);

    // Spawn Red Plume Officer at Cells to take PC to Maalthir
    object oRedPlumeWp = GetWaypointByTag(WP_TAG_PLUMEOFF_SPAWN);
    object oRedPlume = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_PLUMEOFF, GetLocation(oRedPlumeWp));

    // Jump player back to cells
    object oPlayerWP = GetWaypointByTag(WP_TAG_PLAYER_CELLS);
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionJumpToLocation(GetLocation(oPlayerWP)));
}


// Shot 0: Setup cutscene and have Maalthir initiate dialog with
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorMaalthir = CutsceneGetActor(NPC_TAG_MAALTHIR);
    object oActorInnovator = CutsceneGetActor(NPC_TAG_INNOVATOR);
    // Arena gate
    object oGateMain = OBJECT_INVALID;
    // Waypoints
    object oWpPlayer = GetWaypointByTag(WP_TAG_PLAYER_TALK_MAALTHIR);
    object oWpGateMainA = GetWaypointByTag(WP_TAG_MAIN_GATE_A);
    object oWpGateMainB = GetWaypointByTag(WP_TAG_MAIN_GATE_B);
    object oWpMaalthirTalk = GetWaypointByTag(WP_TAG_MAALTHIR_TALK);
    object oWpInnovatorTalk = GetWaypointByTag(WP_TAG_INNOVATOR_TALK);

    if (fTime == 0.0)
    {
        // Disable spectator sound effects
        SoundObjectPlay(GetObjectByTag(SND_TAG_CHEER));
        SoundObjectStop(GetObjectByTag(SND_TAG_TAUNT));

        FadeToBlack(oPC, FADE_SPEED_FASTEST);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        setupActors(oPC);

        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, JumpToLocation(GetLocation(oWpPlayer)));

        CutsceneCameraSetup(0.0, 20.0, 3.0, 75.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        oGateMain = GetObjectByTag(DOOR_TAG_ARENA_MAIN);

        // Open gate
        SetLocked(oGateMain, FALSE);
        DelayCommand(0.5f, AssignCommand(oGateMain, ActionPlayAnimation(ANIMATION_DOOR_OPEN1)));

        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        spawnGuards(oPC);

        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        AssignCommand(oActorMaalthir, ClearAllActions());
        AssignCommand(oActorMaalthir, JumpToLocation(GetLocation(oWpGateMainB)));
        DelayCommand(0.5f, AssignCommand(oActorMaalthir, ActionMoveToObject(oWpMaalthirTalk, FALSE, 0.1)));

        CutsceneNext(11.0);
    }
    else if (fTime == 11.0)
    {
        AssignCommand(oActorInnovator, ClearAllActions());
        AssignCommand(oActorInnovator, JumpToLocation(GetLocation(oWpGateMainA)));
        DelayCommand(0.5f, AssignCommand(oActorInnovator, ActionMoveToObject(oWpInnovatorTalk, FALSE, 0.1)));

        CutsceneNext(15.0);
    }
    else if (fTime >= 15.0)
    {
        AssignCommand(oActorMaalthir, ClearAllActions());
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oActorMaalthir, 3.0f);
        AssignCommand(oActorMaalthir, ActionStartConversation(oPC, "", FALSE, FALSE));

        // Called from dialog
        //CutsceneNextShot();
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
