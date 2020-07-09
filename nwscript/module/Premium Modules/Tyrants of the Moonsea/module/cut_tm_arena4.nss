//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_arena4
//:: DATE: February 28, 2006
//:: AUTH: Luke Scull
//:: NOTE: Hillsfar Arena cutscene
//::////////////////////////////////////////////////////
//:: Pre fight cutscene in 4th arena sequence
//:: (Minotaur)
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "hf_in_util"
#include "hf_in_friend"

#include "cut_tm_arena_inc"


// Updates Quest at the end of cutscene
void updateQuestEnd(object oPC)
{
    // Done in cut_tm_arena4b
}


void CheckAssociateLocations(object oPC)
{
    object oAssociate = GetFirstFactionMember(oPC, FALSE);
    object oAssociateJump = GetWaypointByTag(WP_TAG_PLAYER_ASSOCIATES);

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

            AssignCommand(oAssociate, JumpToLocation(GetLocation(oAssociateJump)));
        }
        oAssociate = GetNextFactionMember(oPC, FALSE);
    }
}


// Clean up corpses from previous arena fight
void arenaCleanup(object oPC)
{
    object oNPC = OBJECT_INVALID;

    oNPC = GetObjectByTag(NPC_TAG_GOLEM);
    if (GetIsObjectValid(oNPC))
        DestroyObject(oNPC);
}


void setupActors(object oPC)
{
    CutsceneSpawnActor(NPC_RESREF_MINOTAUR, NPC_TAG_MINOTAUR, WP_TAG_MINOTAUR_SPAWN);
    CutsceneSpawnActor(NPC_RESREF_MAALTHIR, NPC_TAG_MAALTHIR, WP_TAG_MAALTHIR_INIT);
    CutsceneSpawnActor(NPC_RESREF_INNOVATOR, NPC_TAG_INNOVATOR, WP_TAG_INNOVATOR_INIT);

    object oElf = CutsceneSpawnActor(NPC_RESREF_ELF, NPC_TAG_ELF, WP_TAG_ELF_INIT);
    FriendSetMaster(OBJECT_INVALID, oElf);

    object oAnnouncer = GetNearestObjectByTag(NPC_TAG_ANNOUNCER, oPC);
    CutsceneAddActor(NPC_TAG_ANNOUNCER, oAnnouncer);

    object oGarth = CutsceneSpawnActor(NPC_RESREF_GARTH, NPC_TAG_GARTH, WP_TAG_GARTH_INIT);
}


void start()
{
    object oPC = CutsceneGetPC();

    // Store camera for post scene fight
    AssignCommand(oPC, SetCameraFacing(110.0, 9.0, 50.0, CAMERA_TRANSITION_TYPE_SNAP));
    AssignCommand(oPC, StoreCameraFacing());
    // Prepare camera for cutscene to prevent weirdness in the narrow corridor
    CutsceneCameraSetup(1.8, 90.0, 0.8, 89.0, CAMERA_TRANSITION_TYPE_SNAP);

    arenaCleanup(oPC);

    MusicBattleStop(GetArea(oPC));
    CutsceneStart(FALSE, FALSE, "", FALSE);
}


void abort()
{
    object oPC = CutsceneGetPC();

    BlackScreen(oPC);
    setupActors(oPC);

    object oPlayerWP = GetWaypointByTag(WP_TAG_PLAYER_CENTER);
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
    DelayCommand(0.5f, AssignCommand(oPC, JumpToLocation(GetLocation(oPlayerWP))));

    // Father Garth always dies
    object oGarth = CutsceneGetActor(NPC_TAG_GARTH);
    if (GetIsObjectValid(oGarth))
    {
        DestroyObject(oGarth);
    }

    // Setup Elf and Garth's Journal Entry
    object oElfWP = GetWaypointByTag(WP_TAG_ELF_INIT);
    object oElf = GetObjectInArea(NPC_TAG_ELF, oElfWP);
    if (PlotLevelGet("Elf-Arena-Outcome") == 1)
    {
        if ( GetIsObjectValid(oElf) && !GetIsDead(oElf) )
        {
            SetPlotFlag(oElf, FALSE);
            SetImmortal(oElf, FALSE);
            DelayCommand(0.2f, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oElf));

            AddJournalQuestEntry("HillsfarArenaFatherGarth", 30, oPC);
        }
    }
    else
    {
        // Elf is healed default outcome
        AssignCommand(oElf, ClearAllActions(TRUE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oElf)), oElf);

        AddJournalQuestEntry("HillsfarArenaFatherGarth", 40, oPC);
    }
}


void end()
{
    object oPC = CutsceneGetPC();

    updateQuestEnd(oPC);

    ExecuteScript("exe_tm_minotaur", oPC);
    MusicBattlePlay(GetArea(oPC));

    // Jump Familiars, Summons, etc. to outside of Gate
    DelayCommand(2.0f, CheckAssociateLocations(GetFirstPC()));
}


// Shot 0: Set up arena scene and have Father Garth initiate dialog
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorGarth = CutsceneGetActor(NPC_TAG_GARTH);
    object oActorElf = CutsceneGetActor(NPC_TAG_ELF);
    // Arena gates
    object oDoorPlayer = OBJECT_INVALID;
    // Waypoints
    object oWpPlayerGate = GetWaypointByTag(WP_TAG_PLAYER_GATE);
    object oWpPlayerCenter = GetWaypointByTag(WP_TAG_PLAYER_CENTER);

    if (fTime == 0.0)
    {
        // Spectators are cheering
        SoundObjectPlay(GetObjectByTag(SND_TAG_CHEER));
        SoundObjectStop(GetObjectByTag(SND_TAG_TAUNT));

        BlackScreen(oPC);

        AssignCommand(oPC, ActionJumpToObject(oWpPlayerGate, FALSE));
        CutsceneCameraSetup(1.8, 90.0, 0.9, 88.8, CAMERA_TRANSITION_TYPE_SNAP);

        // Open arena gate on player side
        oDoorPlayer = GetObjectByTag(DOOR_TAG_ARENA_PLAYER);
        SetLocked(oDoorPlayer, FALSE);
        DelayCommand(0.5f, AssignCommand(oDoorPlayer, ActionPlayAnimation(ANIMATION_DOOR_OPEN1)));

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        setupActors(oPC);

        // Camera behind player, pointing toward arena gate
        CutsceneCameraSetup(1.8, 90.0, 2.4, 89.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        AssignCommand(oActorElf, ClearAllActions(TRUE));
        AssignCommand(oActorElf, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 1800.0));

        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionMoveToLocation(GetLocation(oWpPlayerCenter), FALSE));

        CutsceneCameraSetup(-1.0, 120.0, 5.0, 70.0, CAMERA_TRANSITION_TYPE_VERY_SLOW);

        CutsceneNext(11.0);
    }
    else if (fTime >= 11.0)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oActorGarth, 3.0f);
        AssignCommand(oActorGarth, ClearAllActions(TRUE));
        AssignCommand(oActorGarth, ActionStartConversation(oPC, "", FALSE, FALSE));

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
        // Not skippable, dialog has to finish
        // abort();
        // CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "Error: Invalid cutscene event (" + IntToString(nEvent) +")");
        // Try to end gracefully
        abort();
        CutsceneEnd();
    }
}
