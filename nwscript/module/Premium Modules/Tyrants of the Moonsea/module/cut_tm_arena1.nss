//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_arena1
//:: DATE: February 25, 2006
//:: AUTH: Luke Scull
//:: NOTE: Hillsfar arena cutscene.
//::////////////////////////////////////////////////////
//:: Pre fight cutscene in 1st arena sequence
//:: (Tanarukk)
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "cut_tm_arena_inc"


// Updates Quest at the end of cutscene
void updateQuestEnd(object oPC)
{
    PlotLevelSet(NPC_TAG_BLIZZARD, 2);
    PlotLevelSet(NPC_TAG_ELF, 2);
    PlotLevelSet(NPC_TAG_GARTH, 2);
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


void setupActors(object oPC)
{
    object oActor;

    CutsceneSpawnActor(NPC_RESREF_TANARUKK, NPC_TAG_TANARUKK, WP_TAG_TANARUKK_SPAWN);

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
    AssignCommand(oPC, SetCameraFacing(110.0, 8.0, 60.0, CAMERA_TRANSITION_TYPE_SNAP));
    AssignCommand(oPC, StoreCameraFacing());
    // Prepare camera for cutscene to prevent weirdness in the narrow corridor
    CutsceneCameraSetup(1.8, 90.0, 0.8, 89.0, CAMERA_TRANSITION_TYPE_SNAP);

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

    // Jump Opponent directly to final destination
    oActor = CutsceneGetActor(NPC_TAG_TANARUKK);
    oWaypoint = GetWaypointByTag(WP_TAG_TANARUKK_CENTER);
    AssignCommand(oActor, ClearAllActions(TRUE));
    DelayCommand(0.5f, AssignCommand(oActor, JumpToLocation(GetLocation(oWaypoint))));

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

    // Jump Father Garth to offscreen location
    oActor = GetObjectByTag(NPC_TAG_GARTH);
    oWaypoint = GetWaypointByTag(WP_TAG_GARTH_OFFSCREEN);
    AssignCommand(oActor, ClearAllActions(TRUE));
    AssignCommand(oActor, ActionJumpToObject(oWaypoint, FALSE));

    DelayCommand(1.0, ExecuteScript("exe_tm_tanarukk", oPC));
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
    object oActorTanarukk = CutsceneGetActor(NPC_TAG_TANARUKK);
    object oActorSpectator = OBJECT_INVALID;
    // Arena gates
    object oDoorPlayer = OBJECT_INVALID;
    object oDoorOpponent = OBJECT_INVALID;
    // Waypoints
    object oWpPlayerGate = GetWaypointByTag(WP_TAG_PLAYER_GATE);
    object oWpPlayerCenter = GetWaypointByTag(WP_TAG_PLAYER_CENTER);
    object oWpTanarukkCenter = GetWaypointByTag(WP_TAG_TANARUKK_CENTER);

    if (fTime == 0.0)
    {
        // Spectators are cheering
        SoundObjectPlay(GetObjectByTag(SND_TAG_CHEER));
        SoundObjectStop(GetObjectByTag(SND_TAG_TAUNT));

        BlackScreen(oPC);

        AssignCommand(oPC, ActionJumpToObject(oWpPlayerGate, FALSE));
        CutsceneCameraSetup(1.8, 90.0, 0.9, 89.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        setupActors(oPC);

        // Camera behind player, pointing toward arena gate
        CutsceneCameraSetup(1.8, 90.0, 2.4, 88.8, CAMERA_TRANSITION_TYPE_SNAP);

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

        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        // Note: Distance to center is 15.0,
        //       This takes 7.5s at normal PC walk speed (2.0/s)
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionMoveToLocation(GetLocation(oWpPlayerCenter), FALSE));

        AssignCommand(oActorTanarukk, ClearAllActions(TRUE));
        AssignCommand(oActorTanarukk, ActionMoveToLocation(GetLocation(oWpTanarukkCenter), FALSE));

        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        // Close arena gates
        oDoorPlayer = GetObjectByTag(DOOR_TAG_ARENA_PLAYER);
        AssignCommand(oDoorPlayer, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
        DelayCommand(1.0f, SetLocked(oDoorPlayer, TRUE));

        oDoorOpponent = GetObjectByTag(DOOR_TAG_ARENA_OPPONENT);
        AssignCommand(oDoorOpponent, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
        DelayCommand(1.0f, SetLocked(oDoorOpponent, TRUE));

        // Note: We want a 300° clockwise camera rotation (from 90° to 150°)
        //       To ensure clockwise: Split into 160°+140°, i.e. rotate to 290° first, then to 150°
        //       This takes 7.5s at MEDIUM speed (40°/s) or 15.0s at SLOW speed (20°/s)
        CutsceneCameraSetup(-1.0, 290.0, 5.5, -1.0, CAMERA_TRANSITION_TYPE_SLOW);

        CutsceneNext(17.0);
    }
    else if (fTime == 17.0)
    {
        // Second part of camera rotation
        CutsceneCameraSetup(-1.0, 150.0, 7.0, -1.0, CAMERA_TRANSITION_TYPE_SLOW);

        CutsceneNext(26.0);
    }
    else if (fTime == 26.0)  // rotation is complete
    {
        AssignCommand(oPC, PlaySound("vs_announcer_001"));
        AssignCommand(oActorAnnouncer, ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE));
        AssignCommand(oActorAnnouncer, SpeakString("Ladies and gentlemen, I present to you the newest acquisition of the Arena!", TALKVOLUME_SHOUT));

        CutsceneNext(33.0);
    }
    else if (fTime == 33.0)
    {
        // Spectators booing
        SoundObjectStop(GetObjectByTag(SND_TAG_CHEER));
        SoundObjectPlay(GetObjectByTag(SND_TAG_TAUNT));

        AssignCommand(oPC, PlaySound("vs_announcer_002"));
        AssignCommand(oActorAnnouncer, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        AssignCommand(oActorAnnouncer, SpeakString("A devious ally of the Harpers!", TALKVOLUME_SHOUT));

        CutsceneNext(39.0);
    }
    else if (fTime == 39.0)
    {
        AssignCommand(oPC, PlaySound("vs_announcer_003"));
        AssignCommand(oActorAnnouncer, SpeakString("It was only the unfaltering watchfulness of the esteemed Keeper of the Peace that stopped this foul spy from placing the security of your city at risk!", TALKVOLUME_SHOUT));

        CutsceneNext(50.0);
    }
    else if (fTime == 50.0)
    {
        AssignCommand(oPC, PlaySound("vs_announcer_004"));
        AssignCommand(oActorAnnouncer, SpeakString("As punishment, the wretch is sentenced to a life or death struggle against a Tanarukk!", TALKVOLUME_SHOUT));

        CutsceneNext(54.0);
    }
    else if (fTime == 54.0)
    {
        AssignCommand(oActorTanarukk, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        AssignCommand(oPC, PlaySound("c_orcchf_bat1"));

        CutsceneNext(57.0);
    }
    else if (fTime == 57.0)
    {
        oActorSpectator = CutsceneGetActor(NPC_TAG_SPECTATOR1);

        AssignCommand(oPC, PlaySound("vs_marena1_001"));
        AssignCommand(oActorSpectator, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        AssignCommand(oActorSpectator, SpeakString("Harper scum! I hope you die a painful death!", TALKVOLUME_SHOUT));

        CutsceneNext(62.0);
    }
    else if (fTime == 62.0)
    {
        oActorSpectator = CutsceneGetActor(NPC_TAG_SPECTATOR2);

        AssignCommand(oPC, PlaySound("vs_farena1_001"));
        AssignCommand(oActorSpectator, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        AssignCommand(oActorSpectator, SpeakString("How dare you threaten our wonderful city, you... VILE person!", TALKVOLUME_SHOUT));

        CutsceneNext(68.0);
    }
    else if (fTime == 68.0)
    {
        oActorSpectator = CutsceneGetActor(NPC_TAG_SPECTATOR3);

        AssignCommand(oPC, PlaySound("vs_farena2_001"));
        AssignCommand(oActorSpectator, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        AssignCommand(oActorSpectator, SpeakString("You're a dog! A dog, you hear?", TALKVOLUME_SHOUT));

        CutsceneNext(73.0);
    }
    else if (fTime == 73.0)
    {
        oActorSpectator = CutsceneGetActor(NPC_TAG_SPECTATOR4);

        AssignCommand(oPC, PlaySound("vs_marena2_001"));
        AssignCommand(oActorSpectator, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        AssignCommand(oActorSpectator, SpeakString("Bah! Scum of the earth! To the Abyss with you!", TALKVOLUME_SHOUT));

        CutsceneNext(78.0);
    }
    else if (fTime == 78.0)
    {
        AssignCommand(oPC, PlaySound("vs_announcer_005"));
        AssignCommand(oActorAnnouncer, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3));
        AssignCommand(oActorAnnouncer, SpeakString("Let the battle begin!", TALKVOLUME_SHOUT));

        CutsceneNext(84.0);
    }
    else if (fTime == 84.0)
    {
        // StoreCamera
        CutsceneCameraSetup(0.0, 110.0, 9.0, 50.0, CAMERA_TRANSITION_TYPE_MEDIUM);

        CutsceneNext(87.0);
    }
    else if (fTime >= 87.0)
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
