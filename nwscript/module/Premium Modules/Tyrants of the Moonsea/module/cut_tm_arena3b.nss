//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_arena3b
//:: DATE: November 07, 2018
//:: AUTH: Attila Gyoerkoes
//:: NOTE: Hillsfar arena cutscene.
//::////////////////////////////////////////////////////
//:: Post fight cutscene in 3rd arena sequence
//:: (Magic Golem)
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "hf_in_util"

#include "cut_tm_arena_inc"


void updateQuestEnd(object oPC)
{
    // AddJournalQuestEntry("TheArena", 80, oPC);  // Cut
    SetLocalInt(oPC, "arena", 3);

    PlotLevelSet(NPC_TAG_ELF, 6);
    PlotLevelSet(NPC_TAG_GARTH, 4);

    if (PlotLevelCheckEquals("Blizzard-Arena-Outcome", 2))
    {
        // Blizzard was killed
        AddJournalQuestEntry("HillsfarArenaBlizzard", 30, oPC);
    }
    else
    {
        // Blizzard was spared
        AddJournalQuestEntry("HillsfarArenaBlizzard", 20, oPC);
    }
}


void setupActors(object oPC)
{
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    oActor = CutsceneGetActor(PLC_TAG_ANNOUNCER_DUMMY);
    if (!GetIsObjectValid(oActor))
    {
        oWaypoint = GetWaypointByTag(PLC_TAG_ANNOUNCER_DUMMY_SPAWN);
        oActor = CreateObject(OBJECT_TYPE_PLACEABLE, PLC_RESREF_ANNOUNCER_DUMMY, GetLocation(oWaypoint), FALSE, PLC_TAG_ANNOUNCER_DUMMY);
        CutsceneAddActor(PLC_TAG_ANNOUNCER_DUMMY, oActor);
    }

    oActor = GetNearestObjectByTag(NPC_TAG_BLIZZARD, GetWaypointByTag(WP_TAG_BLIZZARD_INIT));
    CutsceneAddActor(NPC_TAG_BLIZZARD, oActor);

    // May not be in current area
    oActor = GetObjectByTag(NPC_TAG_GARTH);
    CutsceneAddActor(NPC_TAG_GARTH, oActor);

    // Try getting Elf from the arena first and then the arena cells
    oActor = GetNearestObjectByTag(NPC_TAG_ELF, GetWaypointByTag(WP_TAG_ELF_INIT));
    if (!GetIsObjectValid(oActor))
        oActor = GetNearestObjectByTag(NPC_TAG_ELF, GetWaypointByTag(WP_TAG_ELF_CELLS));
    if (!GetIsObjectValid(oActor))
        oActor = GetObjectByTag(NPC_TAG_ELF);
    CutsceneAddActor(NPC_TAG_ELF, oActor);
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
    object oWaypoint = OBJECT_INVALID;

    updateQuestEnd(oPC);

    // Destroy Blizzard in Arena
    object oBlizzardArenaWP = GetWaypointByTag(WP_TAG_BLIZZARD_INIT);
    object oBlizzardArena = GetNearestObjectByTag(NPC_TAG_BLIZZARD, oBlizzardArenaWP);
    if (GetIsObjectValid(oBlizzardArena))
        DestroyObject(oBlizzardArena, 1.0);

    // Re-create her in Cells if she was left alive
    if (PlotLevelGet("Blizzard-Arena-Outcome") == 0)
    {
        object oBlizzardCellsWP = GetWaypointByTag(WP_TAG_BLIZZARD_CELLS);
        object oBlizzardCells = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_BLIZZARD,
                                             GetLocation(oBlizzardCellsWP), FALSE, NPC_TAG_BLIZZARD);
        DelayCommand(1.0f, AssignCommand(oBlizzardCells, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 32767.0)));
    }

    // Remove Garth, he is absent and will be killed in the next arena
    object oGarthWP = GetWaypointByTag(WP_TAG_GARTH_CELLS);
    object oGarth = GetObjectInArea(NPC_TAG_GARTH, oGarthWP);
    DestroyObject(oGarth);

    // Remove Elf, he is absent
    object oElfWP = GetWaypointByTag(WP_TAG_ELF_CELLS);
    object oElf = GetObjectInArea(NPC_TAG_ELF, oElfWP);
    DestroyObject(oElf);

    // Destroy Announcer Dummy
    object oAnnouncerDummy = CutsceneGetActor(PLC_TAG_ANNOUNCER_DUMMY);
    if (GetIsObjectValid(oAnnouncerDummy))
        DestroyObject(oAnnouncerDummy);

    // Jump Innovator into cells for conversation with PC
    object oInnovatorWP = GetWaypointByTag(WP_TAG_INNOVATOR_CELLS);
    object oInnovator = GetObjectInArea(NPC_TAG_INNOVATOR, oInnovatorWP);
    AssignCommand(oInnovator, ClearAllActions(TRUE));
    AssignCommand(oInnovator, JumpToLocation(GetLocation(oInnovatorWP)));

    oWaypoint = GetWaypointByTag(WP_TAG_PLAYER_CELLS);
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, JumpToLocation(GetLocation(oWaypoint)));
}


// Shot 0
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorAnnouncerDummy = CutsceneGetActor(PLC_TAG_ANNOUNCER_DUMMY);
    // Waypoints
    object oWpPlayer = GetWaypointByTag(WP_TAG_PLAYER_CENTER);

    if (fTime == 0.0)
    {
        FadeToBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        setupActors(oPC);

        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionJumpToObject(oWpPlayer));

        CutsceneCameraSetup(2.0, 150.0, 7.0, 89.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(5.0);
    }
    else if (fTime >= 5.0)
    {
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oActorAnnouncerDummy, ActionStartConversation(oPC, "tm_announcer", FALSE, FALSE));
        CutsceneCameraSetup(2.0, 150.0, 7.0, 89.0, CAMERA_TRANSITION_TYPE_SNAP);

        // Called from Dialog
        //CutsceneNextShot();
    }
}


// Shot 1: Ends the cutscene
void next1(float fTime)
{
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        FadeToBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(3.0);
    }
    else if (fTime >= 3.0)
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
