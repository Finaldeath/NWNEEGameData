//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_arena6
//:: DATE: March 23, 2006
//:: AUTH: Luke Scull
//:: NOTE: Hillsfar Arena cutscene
//::////////////////////////////////////////////////////
//:: Post fight cutscene in 5th arena sequence
//:: (Onehand)
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "cut_tm_arena_inc"


void updateQuestStart(object oPC)
{
    SetLocalInt(oPC, "onehandfight", 1);
}


void updateQuestEnd(object oPC)
{

}


void setupActors(object oPC)
{
    object oActor;
    object oWaypoint;

    object oKalor = GetNearestObjectByTag(NPC_TAG_ONEHAND, oPC);
    if (GetIsObjectValid(oKalor))
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oKalor);
        DestroyObject(oKalor);
    }
    CutsceneSpawnActor(NPC_RESREF_ONEHAND_DYING, NPC_TAG_ONEHAND_DYING, WP_TAG_ONEHAND_DYING);

    oActor = GetNearestObjectByTag(NPC_TAG_ANNOUNCER, oPC);
    CutsceneAddActor(NPC_TAG_ANNOUNCER, oActor);

    oActor = GetNearestObjectByTag(NPC_TAG_SPECTATOR1, oPC);
    CutsceneAddActor(NPC_TAG_SPECTATOR1, oActor);
    oActor = GetNearestObjectByTag(NPC_TAG_SPECTATOR2, oPC);
    CutsceneAddActor(NPC_TAG_SPECTATOR2, oActor);
    oActor = GetNearestObjectByTag(NPC_TAG_SPECTATOR3, oPC);
    CutsceneAddActor(NPC_TAG_SPECTATOR3, oActor);
    oActor = GetNearestObjectByTag(NPC_TAG_SPECTATOR4, oPC);
    CutsceneAddActor(NPC_TAG_SPECTATOR4, oActor);
}


void start()
{
    object oPC = CutsceneGetPC();

    updateQuestStart(oPC);

    CutsceneStart(FALSE, FALSE, "", FALSE);
}


void abort()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;

    BlackScreen(oPC);
    setupActors(oPC);

    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));

    // Kill Onehand
    oActor = CutsceneGetActor(NPC_TAG_ONEHAND_DYING);
    SetPlotFlag(oActor, FALSE);
    SetImmortal(oActor, FALSE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oActor);

    // Remove Father Garth (Ghost)
    oActor = CutsceneGetActor(NPC_TAG_GARTH);
    if (GetIsObjectValid(oActor))
    {
        DestroyObject(oActor);
    }
}


void end()
{
    object oPC = CutsceneGetPC();
    object oWaypoint = GetWaypointByTag(WP_TAG_PLAYER_TEMPLE);

    updateQuestEnd(oPC);

    AmbientSoundPlay(GetArea(oPC));

    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, JumpToObject(oWaypoint));
}


// Shot 0: Initiate Onehand death dialog
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorAnnouncer = CutsceneGetActor(NPC_TAG_ANNOUNCER);
    object oActorOnehand = CutsceneGetActor(NPC_TAG_ONEHAND_DYING);
    // Waypoints
    object oWpPlayer = GetWaypointByTag(WP_TAG_PLAYER_CENTER);

    if (fTime == 0.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FASTEST);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        setupActors(oPC);

        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, JumpToLocation(GetLocation(oWpPlayer)));

        CutsceneCameraSetup(2.0, 120.0, 5.0, 70.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oActorOnehand, ClearAllActions());
        AssignCommand(oActorOnehand, ActionStartConversation(oPC, "", FALSE, FALSE));
        //AssignCommand(oActorOnehand, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 1800.0));

        // Called from dialog
        //CutsceneNextShot();
    }
}


// Shot 1: Pause Conversation, Ghost of Father Garth appears, Arena Falls silent
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorAnnouncer = CutsceneGetActor(NPC_TAG_ANNOUNCER);
    object oActorOnehand = CutsceneGetActor(NPC_TAG_ONEHAND_DYING);
    object oActorGarth = CutsceneGetActor(NPC_TAG_GARTH);

    if (fTime == 0.0)
    {
        // Everything silent
        SoundObjectStop(GetObjectByTag(SND_TAG_CHEER));
        SoundObjectStop(GetObjectByTag(SND_TAG_TAUNT));
        AmbientSoundStop(GetArea(oPC));

        AssignCommand(oPC, ActionPauseConversation());

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        oActorGarth = CutsceneSpawnActor(NPC_RESREF_GARTH, NPC_TAG_GARTH, WP_TAG_GARTH_INIT);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GHOST_TRANSPARENT), oActorGarth);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GHOST_SMOKE_2), oActorGarth);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_HEAL), oActorOnehand);

        CutsceneNext(3.0);
    }
    else if (fTime >= 3.0)
    {
        AssignCommand(oPC, ActionResumeConversation());

        // Called from dialog
        //CutsceneNextShot();
    }
}


// Shot 2: Onehand dies, Ghost of Father Garth vanishes
void next2(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorOnehand = CutsceneGetActor(NPC_TAG_ONEHAND_DYING);
    object oActorGarth = CutsceneGetActor(NPC_TAG_GARTH);

    if (fTime == 0.0)
    {
        CutsceneCameraSetup(2.0, 270.0, 15.0, 25.0, CAMERA_TRANSITION_TYPE_SLOW);

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        // Onehand dies
        SetPlotFlag(oActorOnehand, FALSE);
        SetImmortal(oActorOnehand, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oActorOnehand);
        
        FadeToBlack(oPC, FADE_SPEED_SLOWEST);
        
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // Father Garth vanishes
        DestroyObject(oActorGarth);

        

        CutsceneNext(12.0);
    }
    else if (fTime >= 12.0)
    {
        CutsceneNextShot();
    }
}


// Shot 3: Ends the cutscene
void next3(float fTime)
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
        if (nShot == 2) next2(fTime);
        if (nShot >= 3) next3(fTime);
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
