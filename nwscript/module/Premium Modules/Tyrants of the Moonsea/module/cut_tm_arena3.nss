//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_arena3
//:: DATE: February 28, 2006
//:: AUTH: Luke Scull
//:: NOTE: Hillsfar arena cutscene.
//::////////////////////////////////////////////////////
//:: Pre fight cutscene in 3rd arena sequence
//:: (Magic Golem)
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "cut_tm_arena_inc"


// Updates Quest at the end of cutscene
void updateQuestEnd(object oPC)
{
    PlotLevelSet(NPC_TAG_BLIZZARD, 4);
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

    oNPC = GetObjectByTag(NPC_TAG_DRIDER0);
    if (GetIsObjectValid(oNPC))
        DestroyObject(oNPC);

    oNPC = GetObjectByTag(NPC_TAG_DRIDER1);
    if (GetIsObjectValid(oNPC))
        DestroyObject(oNPC);

    oNPC = GetObjectByTag(NPC_TAG_DRIDER2);
    if (GetIsObjectValid(oNPC))
        DestroyObject(oNPC);
}


void setupActors(object oPC)
{
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    CutsceneSpawnActor(NPC_RESREF_GOLEM, NPC_TAG_GOLEM, WP_TAG_GOLEM_SPAWN);

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

    object oBlizzard = CutsceneGetActor(NPC_TAG_BLIZZARD);
    if (!GetIsObjectValid(oBlizzard))
    {
        // Destroy Blizzard in Arena Cells
        object oBlizzardWP = GetWaypointByTag(WP_TAG_BLIZZARD_CELLS);
        oBlizzard = GetNearestObjectByTag(NPC_TAG_BLIZZARD, GetWaypointByTag(WP_TAG_BLIZZARD_CELLS));
        if (GetIsObjectValid(oBlizzard))
            DestroyObject(oBlizzard);

        oBlizzard = CutsceneSpawnActor(NPC_RESREF_BLIZZARD, NPC_TAG_BLIZZARD, WP_TAG_BLIZZARD_INIT);
    }
}


void start()
{
    object oPC = CutsceneGetPC();

    // Store camera for post scene fight
    AssignCommand(oPC, SetCameraFacing(110.0, 8.0, 60.0, CAMERA_TRANSITION_TYPE_SNAP));
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
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;
    object oDoor = OBJECT_INVALID;

    BlackScreen(oPC);
    setupActors(oPC);

    // Jump Opponent directly to final destination
    oActor = CutsceneGetActor(NPC_TAG_GOLEM);
    AssignCommand(oActor, ClearAllActions(TRUE));

    // Jump player directly to final destination
    oWaypoint = GetWaypointByTag(WP_TAG_PLAYER_CENTER);
    AssignCommand(oPC, ClearAllActions(TRUE));
    DelayCommand(0.5f, AssignCommand(oPC, JumpToLocation(GetLocation(oWaypoint))));

    // Disable Blizzard
    oActor = GetNearestObjectByTag(NPC_TAG_BLIZZARD, oPC);
    AssignCommand(oActor, ClearAllActions(TRUE));
    DelayCommand(0.5f, AssignCommand(oActor, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 1800.0)));

    // Make sure arena gates are closed
    oDoor = GetObjectByTag(DOOR_TAG_ARENA_PLAYER);
    AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
    DelayCommand(1.0, AssignCommand(oDoor, SetLocked(oDoor, TRUE)));
}


void end()
{
    object oPC = CutsceneGetPC();

    updateQuestEnd(oPC);

    DelayCommand(2.0, ExecuteScript("exe_tm_magicglm", oPC));
    MusicBattlePlay(GetArea(oPC));
    // Jump Familiars, Summons, etc. to outside of Gate
    DelayCommand(3.0f, CheckAssociateLocations(GetFirstPC()));
}


// Shot 0
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorAnnouncer = CutsceneGetActor(NPC_TAG_ANNOUNCER);
    object oActorGolem = CutsceneGetActor(NPC_TAG_GOLEM);
    object oActorBlizzard = CutsceneGetActor(NPC_TAG_BLIZZARD);
    object oActorSpectator = OBJECT_INVALID;
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

        // Some fake buff vfx for Blizzard
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROTECTION_ELEMENTS), oActorBlizzard, 28.0f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_SPELLTURNING), oActorBlizzard, 28.0f);

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // Open arena gates
        oDoorPlayer = GetObjectByTag(DOOR_TAG_ARENA_PLAYER);
        SetLocked(oDoorPlayer, FALSE);
        DelayCommand(0.5, AssignCommand(oDoorPlayer, ActionPlayAnimation(ANIMATION_DOOR_OPEN1)));

        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionMoveToLocation(GetLocation(oWpPlayerCenter), FALSE));

        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
         // Close arena gate
        oDoorPlayer = GetObjectByTag(DOOR_TAG_ARENA_PLAYER);
        AssignCommand(oDoorPlayer, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
        DelayCommand(1.0f, SetLocked(oDoorPlayer, TRUE));

        CutsceneCameraSetup(-1.0, 120.0, 5.2, 70.0, CAMERA_TRANSITION_TYPE_VERY_SLOW);

        AssignCommand(oActorBlizzard, ActionCastFakeSpellAtObject(SPELL_ICE_STORM, oActorGolem, PROJECTILE_PATH_TYPE_DEFAULT));
        DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_ICESTORM), oActorGolem));

        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        AssignCommand(oActorBlizzard, ActionCastFakeSpellAtObject(SPELL_ICE_DAGGER, oActorGolem, PROJECTILE_PATH_TYPE_DEFAULT));
        DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_COLD), oActorGolem));

        CutsceneNext(21.0);
    }
    else if (fTime == 21.0)
    {
        AssignCommand(oPC, PlaySound("vs_blizzard_050"));
        AssignCommand(oActorBlizzard, SpeakString("What manner of creature are you?", TALKVOLUME_TALK));

        CutsceneNext(24.0);
    }
    else if (fTime == 24.0)
    {
        AssignCommand(oActorGolem, ActionMoveToObject(oActorBlizzard, TRUE));

        CutsceneNext(27.0);
    }
    else if (fTime == 27.0)
    {
        AssignCommand(oActorGolem, ActionCastFakeSpellAtObject(SPELL_ENERVATION, oActorBlizzard));

        CutsceneNext(29.0);
    }
    else if (fTime == 29.0)
    {
        AssignCommand(oActorBlizzard, ClearAllActions(TRUE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DISPEL), oActorBlizzard);
        AssignCommand(oActorBlizzard, ActionPlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, 1.5));

        CutsceneNext(31.0);
    }
    else if (fTime == 31.0)
    {
        AssignCommand(oActorBlizzard, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 1800.0));

        CutsceneNext(34.0);
    }
    else if (fTime == 34.0)
    {
        CutsceneCameraSetup(-1.0, 150.0, 7.0, 89.0, CAMERA_TRANSITION_TYPE_MEDIUM);

        CutsceneNext(37.0);
    }
    else if (fTime == 37.0)
    {
        AssignCommand(oPC, PlaySound("vs_announcer_008"));
        AssignCommand(oActorAnnouncer, SpeakString("Blizzard has fallen! But what is this?", TALKVOLUME_SHOUT));

        CutsceneNext(42.0);
    }
    else if (fTime == 42.0)
    {
        AssignCommand(oPC, PlaySound("vs_announcer_009"));
        AssignCommand(oActorAnnouncer, SpeakString("The vile Harper spy wishes to challenge her vanquisher!", TALKVOLUME_SHOUT));

        CutsceneNext(49.0);
    }
    else if (fTime == 49.0)
    {
        oActorSpectator = CutsceneGetActor(NPC_TAG_SPECTATOR2);

        AssignCommand(oPC, PlaySound("vs_farena4_001"));
        AssignCommand(oActorSpectator, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3));
        AssignCommand(oActorSpectator, SpeakString("Finish it off!", TALKVOLUME_SHOUT));

        CutsceneNext(55.0);
    }
    else if (fTime == 55.0)
    {
        oActorSpectator = CutsceneGetActor(NPC_TAG_SPECTATOR1);

        AssignCommand(oPC, PlaySound("vs_marena4_001"));
        AssignCommand(oActorSpectator, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 5.0));
        AssignCommand(oActorSpectator, SpeakString("Come on! I bet good gold on you!", TALKVOLUME_SHOUT));

        CutsceneNext(62.0);
    }
    else if (fTime == 62.0)
    {
        AssignCommand(oPC, PlaySound("vs_announcer_010"));
        AssignCommand(oActorAnnouncer, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3));
        AssignCommand(oActorAnnouncer, SpeakString("So be it! Let the battle begin!", TALKVOLUME_SHOUT));

        CutsceneNext(69.0);
    }
    else if (fTime == 69.0)
    {
        // StoreCamera
        CutsceneCameraSetup(0.0, 110.0, 9.0, 50.0, CAMERA_TRANSITION_TYPE_MEDIUM);

        CutsceneNext(72.0);
    }
    else if (fTime >= 72.0)
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
