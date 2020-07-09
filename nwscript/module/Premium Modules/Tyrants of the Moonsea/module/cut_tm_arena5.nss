 //::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_arena6
//:: DATE: March 21, 2006
//:: AUTH: Luke Scull
//:: NOTE: Hillsfar Arena cutscene
//::////////////////////////////////////////////////////
//:: Pre fight cutscene in 5th arena sequence
//:: (Onehand)
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "cut_tm_arena_inc"

#include "nw_i0_generic"


void updateQuestStart(object oPC)
{
    SetLocalInt(oPC, "hillsfarpass", 1);
}


void updateQuestEnd(object oPC)
{

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


// Get rid of all Guards
void arenaCleanup(object oPC)
{
    // Clean up guards from previous cutscene
    int i = 0;
    object oGuard = OBJECT_INVALID;
    for (i = 0; i<22; i++)
    {
        oGuard = GetObjectByTag(NPC_TAG_GUARDx + IntToString(i));
        if (GetIsObjectValid(oGuard))
            DestroyObject(oGuard);
    }
}


// Adds the special walk property to a targets skin
void addSpecialWalk(object oTarget)
{
    itemproperty ipSpecialWalk = ItemPropertySpecialWalk();
    object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oTarget);
    if (!GetIsObjectValid(oSkin))
    {
        oSkin = CreateItemOnObject("it_emptyskin", oTarget);
        DelayCommand(0.5, AssignCommand(oTarget, ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR)));
    }
    AddItemProperty(DURATION_TYPE_PERMANENT, ipSpecialWalk, oSkin);
}


void setupActors(object oPC)
{
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    oActor = GetNearestObjectByTag(NPC_TAG_ANNOUNCER, oPC);
    CutsceneAddActor(NPC_TAG_ANNOUNCER, oActor);

    oActor = CutsceneSpawnActor(NPC_RESREF_ONEHAND, NPC_TAG_ONEHAND, WP_TAG_ONEHAND_SPAWN);
    if (GetIsObjectValid(oActor))
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(95, DAMAGE_TYPE_DIVINE, DAMAGE_POWER_NORMAL), oActor);
    }

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

    updateQuestStart(oPC);

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
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;
    object oDoor = OBJECT_INVALID;

    BlackScreen(oPC);
    setupActors(oPC);

    // Jump Opponent directly to final destination
    oActor = CutsceneGetActor(NPC_TAG_ONEHAND);
    oWaypoint = GetWaypointByTag(WP_TAG_ONEHAND_CENTER);
    AssignCommand(oActor, ClearAllActions(TRUE));
    AssignCommand(oActor, JumpToLocation(GetLocation(oWaypoint)));

    // Jump player directly to final destination
    oWaypoint = GetWaypointByTag(WP_TAG_PLAYER_CENTER);
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
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
    object oActorOnehand = CutsceneGetActor(NPC_TAG_ONEHAND);

    updateQuestEnd(oPC);

    DelayCommand(0.5, AssignCommand(oActorOnehand, SetIsTemporaryEnemy(oPC)));
    DelayCommand(1.0, AssignCommand(oActorOnehand, DetermineCombatRound(oPC)));
    DelayCommand(1.5, AssignCommand(oActorOnehand, ActionAttack(oPC)));

    MusicBattlePlay(GetArea(oPC));

    // Jump Familiars, Summons, etc. to outside of Gate
    DelayCommand(2.0f, CheckAssociateLocations(GetFirstPC()));
}


// Shot 0: Spawns in Onehand and makes him initiate a conversation
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorAnnouncer = CutsceneGetActor(NPC_TAG_ANNOUNCER);
    object oActorOnehand = CutsceneGetActor(NPC_TAG_ONEHAND);
    object oActorSpectator = OBJECT_INVALID;
    // Arena gates
    object oDoor = OBJECT_INVALID;
    // Waypoints
    object oWpPlayerGate = GetWaypointByTag(WP_TAG_PLAYER_GATE);
    object oWpPlayerCenter = GetWaypointByTag(WP_TAG_PLAYER_CENTER);
    object oWpOnehandCenter = GetWaypointByTag(WP_TAG_ONEHAND_CENTER);

    if (fTime == 0.0)
    {
        // Spectators are cheering
        SoundObjectPlay(GetObjectByTag(SND_TAG_CHEER));
        SoundObjectStop(GetObjectByTag(SND_TAG_TAUNT));

        BlackScreen(oPC);

        AssignCommand(oPC, ActionJumpToObject(oWpPlayerGate, FALSE));
        CutsceneCameraSetup(1.8, 90.0, 0.9, 88.8, CAMERA_TRANSITION_TYPE_SNAP);

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

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // Open arena gates
        oDoor = GetObjectByTag(DOOR_TAG_ARENA_PLAYER);
        SetLocked(oDoor, FALSE);
        DelayCommand(0.5, AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_OPEN1)));

        oDoor = GetObjectByTag(DOOR_TAG_ARENA_OPPONENT);
        SetLocked(oDoor, FALSE);
        DelayCommand(0.5, AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_OPEN1)));

        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        // Note: Distance to center is 15.0,
        //       This takes 7.5s at normal PC walk speed (2.0/s)
        AssignCommand(oPC, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oPC, ActionMoveToLocation(GetLocation(oWpPlayerCenter), FALSE)));

        AssignCommand(oActorOnehand, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oActorOnehand, ActionMoveToLocation(GetLocation(oWpOnehandCenter), FALSE)));

        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        // Close arena gate
        oDoor = GetObjectByTag(DOOR_TAG_ARENA_PLAYER);
        AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
        DelayCommand(1.0f, SetLocked(oDoor, TRUE));

        oDoor = GetObjectByTag(DOOR_TAG_ARENA_OPPONENT);
        AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
        DelayCommand(1.0f, SetLocked(oDoor, TRUE));

        CutsceneCameraSetup(-1.0, 150.0, 7.2, 89.0, CAMERA_TRANSITION_TYPE_SLOW);

        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)  // pc at center
    {
        AssignCommand(oPC, PlaySound("vs_announcer_011"));
        AssignCommand(oActorAnnouncer, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2));
        AssignCommand(oActorAnnouncer, SpeakString("Ladies and gentlemen, today we have something special!", TALKVOLUME_SHOUT));

        AssignCommand(oActorOnehand, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 1800.0));

        CutsceneNext(22.0);
    }
    else if (fTime == 22.0)
    {
        AssignCommand(oPC, PlaySound("vs_announcer_012"));
        AssignCommand(oActorAnnouncer, ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL));
        AssignCommand(oActorAnnouncer, SpeakString("A fight between the vile Harper spy and the traitorous Kalor Onehand!", TALKVOLUME_SHOUT));

        CutsceneNext(29.0);
    }
    else if (fTime == 29.0)
    {
        oActorSpectator = CutsceneGetActor(NPC_TAG_SPECTATOR1);

        AssignCommand(oPC, PlaySound("vs_marena5_001"));
        AssignCommand(oActorSpectator, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        AssignCommand(oActorSpectator, SpeakString("Kill the traitor!", TALKVOLUME_SHOUT));

        CutsceneNext(35.0);
    }
    else if (fTime == 35.0)
    {
        oActorSpectator = CutsceneGetActor(NPC_TAG_SPECTATOR2);

        AssignCommand(oPC, PlaySound("vs_farena5_001"));
        AssignCommand(oActorSpectator, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 5.0));
        AssignCommand(oActorSpectator, SpeakString("How could you do this?!", TALKVOLUME_SHOUT));

        CutsceneNext(41.0);
    }
    else if (fTime == 41.0)
    {
        CutsceneCameraSetup(-1.0, 120.0, 5.0, 70.0, CAMERA_TRANSITION_TYPE_SLOW);

        CutsceneNextShot();
    }
}


// Shot 1: Kalor initiates conversation
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorAnnouncer = CutsceneGetActor(NPC_TAG_ANNOUNCER);
    object oActorOnehand = CutsceneGetActor(NPC_TAG_ONEHAND);

    if (fTime == 0.0)
    {
        AssignCommand(oActorOnehand, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oActorOnehand, ActionMoveToLocation(GetLocation(oPC), FALSE)));

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oActorOnehand, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oActorOnehand, ActionStartConversation(oPC, "", FALSE, FALSE)));

        CutsceneNext(4.0);
    }
    else if (fTime >= 4.0)
    {
        CutsceneCameraSetup(-1.0, 120.0, 5.0, 70.0, CAMERA_TRANSITION_TYPE_SLOW);

        // Called from conversation
        //CutsceneNextShot();
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
