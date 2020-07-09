//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_arena2
//:: DATE: February 25, 2006
//:: AUTH: Luke Scull
//:: NOTE: Hillsfar arena cutscene.
//::////////////////////////////////////////////////////
//:: Pre fight cutscene in 2nd arena sequence
//:: (Driders)
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "cut_tm_arena_inc"


// Updates Quest at the end of cutscene
void updateQuestEnd(object oPC)
{
    PlotLevelSet(NPC_TAG_ELF, 4);
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

    oNPC = GetObjectByTag(NPC_TAG_TANARUKK);
    if (GetIsObjectValid(oNPC))
        DestroyObject(oNPC);

}


// Plaster the PC with apples (every NPC with matching tag throws a single apple)
void throwApples(object oPC)
{
    object oThrower = OBJECT_INVALID;
    location lTarget;
    string sTrashtalk = "";
    float fDelay = 0.0f;
    int i = 0;

    oThrower = GetObjectByTag(NPC_TAG_APPLETHROWER, i);
    while (GetIsObjectValid(oThrower))
    {
        fDelay = fDelay + IntToFloat(30+Random(30))/100.0;

        // Read a line for the NPC to speak from a variable
        sTrashtalk = GetLocalString(oThrower, "trashtalk");
        if (sTrashtalk != "")
            DelayCommand(fDelay, AssignCommand(oThrower, SpeakString(sTrashtalk, TALKVOLUME_SHOUT)));

        // Half of the apples simply miss
        if (i%2 == 0)
        {
            lTarget = GetRandomLocation(GetArea(oPC), oPC, 0.2f);
            DelayCommand(fDelay, AssignCommand(oThrower, ActionCastFakeSpellAtLocation(SPELL_ID_APPLE_THROW, lTarget)));
        }
        else
        {
            DelayCommand(fDelay, AssignCommand(oThrower, ActionCastFakeSpellAtObject(SPELL_ID_APPLE_THROW, oPC)));
        }

        i++;
        oThrower = GetObjectByTag(NPC_TAG_APPLETHROWER, i);
    }
}


void setupActors(object oPC)
{
    object oActor = OBJECT_INVALID;;

    CutsceneSpawnActor(NPC_RESREF_DRIDER0, NPC_TAG_DRIDER0, WP_TAG_DRIDER0_SPAWN);
    CutsceneSpawnActor(NPC_RESREF_DRIDER1, NPC_TAG_DRIDER1, WP_TAG_DRIDER1_SPAWN);
    CutsceneSpawnActor(NPC_RESREF_DRIDER2, NPC_TAG_DRIDER2, WP_TAG_DRIDER2_SPAWN);

    oActor = GetNearestObjectByTag(NPC_TAG_ANNOUNCER, oPC);
    CutsceneAddActor(NPC_TAG_ANNOUNCER, oActor);

    oActor = GetObjectByTag(NPC_TAG_SPECTATOR1);
    CutsceneAddActor(NPC_TAG_SPECTATOR1, oActor);
    oActor = GetObjectByTag(NPC_TAG_SPECTATOR2);
    CutsceneAddActor(NPC_TAG_SPECTATOR2, oActor);
    oActor = GetObjectByTag(NPC_TAG_SPECTATOR3);
    CutsceneAddActor(NPC_TAG_SPECTATOR3, oActor);
    oActor = GetObjectByTag(NPC_TAG_SPECTATOR4);
    CutsceneAddActor(NPC_TAG_SPECTATOR4, oActor);
}


void start()
{
    object oPC = CutsceneGetPC();

    // Store camera for post scene fight
    AssignCommand(oPC, SetCameraFacing(110.0, 9.0, 50.0, CAMERA_TRANSITION_TYPE_SNAP));
    AssignCommand(oPC, StoreCameraFacing());

    arenaCleanup(oPC);

    MusicBattleStop(GetArea(oPC));
    CutsceneStart(FALSE, FALSE, "", FALSE);
}


void abort()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;
    object oDoor = OBJECT_INVALID;

    BlackScreen(oPC);
    setupActors(oPC);

    // Jump Opponents directly to final destination
    oActor = CutsceneGetActor(NPC_TAG_DRIDER0);
    oWaypoint = GetWaypointByTag(WP_TAG_DRIDER0_CENTER);
    AssignCommand(oActor, ClearAllActions(TRUE));
    AssignCommand(oActor, JumpToLocation(GetLocation(oWaypoint)));

    oActor = CutsceneGetActor(NPC_TAG_DRIDER1);
    oWaypoint = GetWaypointByTag(WP_TAG_DRIDER1_CENTER);
    AssignCommand(oActor, ClearAllActions(TRUE));
    AssignCommand(oActor, JumpToLocation(GetLocation(oWaypoint)));

    oActor = CutsceneGetActor(NPC_TAG_DRIDER2);
    oWaypoint = GetWaypointByTag(WP_TAG_DRIDER2_CENTER);
    AssignCommand(oActor, ClearAllActions(TRUE));
    AssignCommand(oActor, JumpToLocation(GetLocation(oWaypoint)));

    // Jump player directly to final destination
    oWaypoint = GetWaypointByTag(WP_TAG_PLAYER_CENTER);
    AssignCommand(oPC, ClearAllActions(TRUE));
    DelayCommand(0.5f, AssignCommand(oPC, JumpToLocation(GetLocation(oWaypoint))));

    // Make sure arena gates are closed
    oDoor = GetObjectByTag(DOOR_TAG_ARENA_PLAYER);
    AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
    DelayCommand(1.0, AssignCommand(oDoor, SetLocked(oDoor, TRUE)));

    oDoor = GetObjectByTag(DOOR_TAG_ARENA_OPPONENT);
    AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
    DelayCommand(1.0, AssignCommand(oDoor, SetLocked(oDoor, TRUE)));
}


void end()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    updateQuestEnd(oPC);

    // Safety check
    // Drider Movement is not 100% reliable due to pathfinding issue
    oActor = CutsceneGetActor(NPC_TAG_DRIDER0);
    oWaypoint = GetWaypointByTag(WP_TAG_DRIDER0_CENTER);
    if (GetDistanceBetween(oActor, oWaypoint) > 1.0)
    {
        AssignCommand(oActor, ClearAllActions(TRUE));
        AssignCommand(oActor, ActionJumpToObject(oWaypoint, FALSE));
    }

    oActor = CutsceneGetActor(NPC_TAG_DRIDER1);
    oWaypoint = GetWaypointByTag(WP_TAG_DRIDER1_CENTER);
    if (GetDistanceBetween(oActor, oWaypoint) > 1.0)
    {
        AssignCommand(oActor, ClearAllActions(TRUE));
        AssignCommand(oActor, ActionJumpToObject(oWaypoint, FALSE));
    }

    oActor = CutsceneGetActor(NPC_TAG_DRIDER2);
    oWaypoint = GetWaypointByTag(WP_TAG_DRIDER2_CENTER);
    if (GetDistanceBetween(oActor, oWaypoint) > 1.0)
    {
        AssignCommand(oActor, ClearAllActions(TRUE));
        AssignCommand(oActor, ActionJumpToObject(oWaypoint, FALSE));
    }

    // Destroy Blizzard in Arena Cells. She is absent until the next fight.
    object oBlizzardWP = GetWaypointByTag(WP_TAG_BLIZZARD_CELLS);
    object oBlizzard = GetNearestObjectByTag(NPC_TAG_BLIZZARD, GetWaypointByTag(WP_TAG_BLIZZARD_CELLS));
    if (GetIsObjectValid(oBlizzard))
        DestroyObject(oBlizzard);

    DelayCommand(1.0, ExecuteScript("exe_tm_driders", oPC));
    MusicBattlePlay(GetArea(oPC));

    // Jump Familiars, Summons, etc. to outside of Gate
    DelayCommand(2.0f, CheckAssociateLocations(GetFirstPC()));
}


// Shot 0
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorAnnouncer = CutsceneGetActor(NPC_TAG_ANNOUNCER);
    object oActorDrider0 = CutsceneGetActor(NPC_TAG_DRIDER0);
    object oActorDrider1 = CutsceneGetActor(NPC_TAG_DRIDER1);
    object oActorDrider2 = CutsceneGetActor(NPC_TAG_DRIDER2);
    object oActorSpectator = OBJECT_INVALID;
    object oAppleThrower = OBJECT_INVALID;
    // Arena gates
    object oDoorPlayer = OBJECT_INVALID;
    object oDoorOpponent = OBJECT_INVALID;
    // Waypoints
    object oWpPlayerGate = GetWaypointByTag(WP_TAG_PLAYER_GATE);
    object oWpPlayerCenter = GetWaypointByTag(WP_TAG_PLAYER_CENTER);
    object oWpDrider0Center = GetWaypointByTag(WP_TAG_DRIDER0_CENTER);
    object oWpDrider1Center = GetWaypointByTag(WP_TAG_DRIDER1_CENTER);
    object oWpDrider2Center = GetWaypointByTag(WP_TAG_DRIDER2_CENTER);

    if (fTime == 0.0)
    {
        // Spectators booing
        SoundObjectStop(GetObjectByTag(SND_TAG_CHEER));
        SoundObjectPlay(GetObjectByTag(SND_TAG_TAUNT));

        BlackScreen(oPC);

        AssignCommand(oPC, ActionJumpToObject(oWpPlayerGate, FALSE));

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        setupActors(oPC);

        // Camera in front of player
        CutsceneCameraSetup(2.0, 270.0, 6.0, 88.8, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // Open arena gates
        oDoorPlayer = GetObjectByTag(DOOR_TAG_ARENA_PLAYER);
        SetLocked(oDoorPlayer, FALSE);
        DelayCommand(0.5, AssignCommand(oDoorPlayer, ActionPlayAnimation(ANIMATION_DOOR_OPEN1)));

        oDoorOpponent = GetObjectByTag(DOOR_TAG_ARENA_OPPONENT);
        SetLocked(oDoorOpponent, FALSE);
        DelayCommand(0.5, AssignCommand(oDoorOpponent, ActionPlayAnimation(ANIMATION_DOOR_OPEN1)));

        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        // Note: Distance to center is 15.0,
        //       This takes 7.5s at normal PC walk speed (2.0/s)
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionMoveToLocation(GetLocation(oWpPlayerCenter), FALSE));

        // Use CutsceneGhost() for multiple opponents to avoid pathfinding issues
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oActorDrider0, 10.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oActorDrider1, 10.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oActorDrider2, 10.0);

        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        // Move drider to center
        AssignCommand(oActorDrider0, ClearAllActions(TRUE));
        AssignCommand(oActorDrider1, ClearAllActions(TRUE));
        AssignCommand(oActorDrider2, ClearAllActions(TRUE));

        DelayCommand(0.5, AssignCommand(oActorDrider0, ActionMoveToObject(oWpDrider0Center, FALSE, 0.1)));
        DelayCommand(1.0, AssignCommand(oActorDrider1, ActionMoveToObject(oWpDrider1Center, FALSE, 0.1)));
        DelayCommand(1.5,  AssignCommand(oActorDrider2, ActionMoveToObject(oWpDrider2Center, FALSE, 0.1)));

        // Start thowing apples at player
        throwApples(oPC);

        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        // Close arena gates on player side
        oDoorPlayer = GetObjectByTag(DOOR_TAG_ARENA_PLAYER);
        AssignCommand(oDoorPlayer, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
        DelayCommand(1.0f, SetLocked(oDoorPlayer, TRUE));

        // Rotate camera towards announcer
        // 270° to 150°
        CutsceneCameraSetup(-1.0, 150.0, 7.2, -1.0, CAMERA_TRANSITION_TYPE_SLOW);

        CutsceneNext(14.0);
    }
    else if (fTime == 14.0) // Player has arrived in arena center
    {
        AssignCommand(oPC, PlaySound("vs_announcer_006"));
        AssignCommand(oActorAnnouncer, ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE));
        AssignCommand(oActorAnnouncer, SpeakString("Once again, ladies and gentlemen, I present the villain for judgment!", TALKVOLUME_SHOUT));

        CutsceneNext(20.0);
    }
    else if (fTime == 20.0)
    {
        // Close arena gates on opponent side
        oDoorOpponent = GetObjectByTag(DOOR_TAG_ARENA_OPPONENT);
        AssignCommand(oDoorOpponent, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
        DelayCommand(1.0f, SetLocked(oDoorOpponent, TRUE));


        AssignCommand(oPC, PlaySound("vs_announcer_007"));
        AssignCommand(oActorAnnouncer, SpeakString("Your most generous arena master has procured a trio of driders from the Underdark to test the mettle of this Harper ally.", TALKVOLUME_SHOUT));

        CutsceneNext(30.0);
    }
    else if (fTime == 30.0)
    {
        oActorSpectator = CutsceneGetActor(NPC_TAG_SPECTATOR3);

        AssignCommand(oPC, PlaySound("vs_farena3_001"));
        AssignCommand(oActorSpectator, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 5.0));
        AssignCommand(oActorSpectator, SpeakString("By the gods, they are ugly!", TALKVOLUME_SHOUT));

        CutsceneNext(36.0);
    }
    else if (fTime == 36.0)
    {
        oActorSpectator = CutsceneGetActor(NPC_TAG_SPECTATOR4);

        AssignCommand(oPC, PlaySound("vs_marena3_001"));
        AssignCommand(oActorSpectator, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        AssignCommand(oActorSpectator, SpeakString("This time for sure, Harper!", TALKVOLUME_SHOUT));

        CutsceneNext(42.0);
    }
    else if (fTime == 42.0)
    {
        AssignCommand(oPC, PlaySound("vs_announcer_005"));
        AssignCommand(oActorAnnouncer, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3));
        AssignCommand(oActorAnnouncer, SpeakString("Let the battle begin!", TALKVOLUME_SHOUT));

        CutsceneNext(45.0);
    }
    else if (fTime == 45.0)
    {
        // StoreCamera
        CutsceneCameraSetup(0.0, 110.0, 8.0, 50.0, CAMERA_TRANSITION_TYPE_MEDIUM);

        CutsceneNext(48.0);
    }
    else if (fTime >= 48.0)
    {
        SoundObjectPlay(GetObjectByTag(SND_TAG_FANFARE));
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
