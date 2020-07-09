// this is the cutscene where the griffons kill wikkers

#include "hf_in_cutscene"
#include "hf_in_util"

// remove wandering NPCs in cutscene area
void ClearCutsceneArea(object oPC)
{
    object oTrigger = GetObjectByTag("pm_cs_subarea");
    object oInTrigger = GetFirstInPersistentObject(oTrigger, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oInTrigger))
    {
        if ((!GetIsPC(oInTrigger)) && (!GetFactionEqual(oInTrigger, oPC)))
        {
            SetCommandable(TRUE, oInTrigger);
            AssignCommand(oInTrigger, ClearAllActions(TRUE));
            AssignCommand(oInTrigger, ActionJumpToObject(GetObjectInArea("pm_cs_subarea_jump", oInTrigger),FALSE));
        }
        oInTrigger = GetNextInPersistentObject(oTrigger, OBJECT_TYPE_CREATURE);
    }
}

// create the NPCs used in this scene
void SpawnNPCs(object oPC)
{
    location lGuard1 = GetLocation(GetObjectInArea("WP_CS_E_GUARD1", oPC));
    location lGuard2 = GetLocation(GetObjectInArea("WP_CS_E_GUARD2", oPC));
    location lGuard3 = GetLocation(GetObjectInArea("WP_CS_E_GUARD3", oPC));
    location lWikker = GetLocation(GetObjectInArea("WP_CS_E_WICKER", oPC));
    object oGuard1 = CreateObject(OBJECT_TYPE_CREATURE, "pm_griffon", lGuard1, FALSE,"cs_guard1");
    CutsceneAddActor("cs_guard1", oGuard1);
    object oGuard2 = CreateObject(OBJECT_TYPE_CREATURE, "pm_griffon", lGuard2, FALSE,"cs_guard2");
    CutsceneAddActor("cs_guard2", oGuard2);
    object oGuard3 = CreateObject(OBJECT_TYPE_CREATURE, "pm_griffon", lGuard3, FALSE,"cs_guard3");
    CutsceneAddActor("cs_guard3", oGuard3);
    object oWikker = CreateObject(OBJECT_TYPE_CREATURE, "pm_wikkers", lWikker, FALSE,"cs_wikker");
    CutsceneAddActor("cs_wikker", oWikker);
    SetLootable(oWikker, TRUE);
    SetImmortal(oWikker, FALSE);
    SetPlotFlag(oWikker, FALSE);
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE, "WP_CS_E_CAM1");
    ClearCutsceneArea(oPC);
    SpawnNPCs(oPC);
    SetLocalInt(GetArea(oPC), "HF_DISABLE_AM", TRUE);
}

// wikkers runs away from guards
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oWikkers = CutsceneGetActor("cs_wikker");
    object oGuard1  = CutsceneGetActor("cs_guard1");
    object oGuard2  = CutsceneGetActor("cs_guard2");
    object oGuard3  = CutsceneGetActor("cs_guard3");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneCameraSetup(-1.0, 200.0, 15.0, 50.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oGuard2, PlaySound("as_pl_panicgrp2"));
        AssignCommand(oGuard1, ActionSpeakString(q+"Stop him!"+q));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        MusicBattlePlay(GetArea(oPC));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        // wikkers runs from guards
        object oDest = GetObjectInArea("WP_CS_E_ATTACK", oPC);
        AssignCommand(oWikkers, ActionMoveToObject(oDest, TRUE));
        AssignCommand(oGuard3, ActionMoveToObject(oDest, TRUE));
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        // guards give chase
        object oDest1 = GetObjectInArea("WP_CS_E_ATTACK1", oPC);
        AssignCommand(oGuard1, ActionMoveToObject(oDest1, TRUE));
        object oDest2 = GetObjectInArea("WP_CS_E_ATTACK2",oPC);
        AssignCommand(oGuard2, ActionMoveToObject(oDest2, TRUE));
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        // wikkers begs for mercy
        AssignCommand(oWikkers, SetFacingPoint(GetPosition(oGuard1)));
        AssignCommand(oWikkers, PlaySound("as_pl_despairm1"));
        AssignCommand(oWikkers, ActionSpeakString(q+"Please let me alone! Please!"+q));
        AssignCommand(oWikkers, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 5.0));
        CutsceneNext(13.0);
    }
    else if (fTime == 13.0)
    {
        AssignCommand(oGuard1, ActionSpeakString(q+"No mercy for you, Wikkers!"+q));
        AssignCommand(oGuard1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 2.0));
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        // guards kill wikkers
        ChangeToStandardFaction(oWikkers, STANDARD_FACTION_HOSTILE);
        AssignCommand(oGuard1, ActionAttack(oWikkers));
        AssignCommand(oGuard2, ActionAttack(oWikkers));
        AssignCommand(oGuard3, ActionAttack(oWikkers));
        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        // wikkers is dead
        MusicBattleStop(GetArea(oPC));
        CutsceneMusic(55);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(400), oWikkers);
        ChangeToStandardFaction(oWikkers, STANDARD_FACTION_DEFENDER);
        CreateObject(OBJECT_TYPE_PLACEABLE, "wikkers_blood", GetLocation(oWikkers));
        AssignCommand(oGuard1, ClearAllActions(TRUE));
        AssignCommand(oGuard2, ClearAllActions(TRUE));
        AssignCommand(oGuard3, ClearAllActions(TRUE));
        CutsceneNextShot();
    }
}

// guards search wikkers' body
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oWikkers = CutsceneGetActor("cs_wikker");
    object oGuard1  = CutsceneGetActor("cs_guard1");
    object oGuard2  = CutsceneGetActor("cs_guard2");
    object oGuard3  = CutsceneGetActor("cs_guard3");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneCameraSetup(-1.0, 150.0, 8.0, 60.0, CAMERA_TRANSITION_TYPE_MEDIUM);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // guards search wikkers' body
        AssignCommand(oGuard1, ActionMoveToObject(oWikkers, FALSE, 0.0));
        AssignCommand(oGuard1, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 8.0));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        AssignCommand(oGuard2, SetFacingPoint(GetPosition(oGuard1)));
        AssignCommand(oGuard3, SetFacingPoint(GetPosition(oGuard1)));
        AssignCommand(oGuard3, ActionSpeakString(q+"Does Wikkers have the book?"+q));
        CutsceneNext(11.0);
    }
    else if (fTime == 11.0)
    {
        AssignCommand(oGuard1, SetFacingPoint(GetPosition(oGuard2)));
        AssignCommand(oGuard1, ActionSpeakString(q+"Yes! I found the book!"+q));
        CutsceneNext(16.0);
    }
    else if (fTime == 16.0)
    {
        AssignCommand(oGuard2, ActionSpeakString(q+"Report to Captain Dratharion immediately!"+q));
        AssignCommand(oGuard1, SetFacingPoint(GetPosition(oGuard2)));
        AssignCommand(oGuard3, SetFacingPoint(GetPosition(oGuard2)));
        CutsceneNext(19.0);
    }
    else if (fTime == 19.0)
    {
        AssignCommand(oGuard3, PlaySound("as_pl_soldierm3"));
        AssignCommand(oGuard3, ActionSpeakString(q+"Yes, sir!"+q));
        AssignCommand(oGuard3, ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE));
        CutsceneNext(22.0);
    }
    else if (fTime == 22.0)
    {
        // guards run away!
        object oDest = GetObjectInArea("WP_CS_E_GUARD3", oPC);
        AssignCommand(oGuard1, ActionMoveToObject(oDest, TRUE));
        AssignCommand(oGuard2, ActionMoveToObject(oDest, TRUE));
        AssignCommand(oGuard3, ActionMoveToObject(oDest, TRUE));
        CutsceneNext(25.0);
    }
    else if (fTime == 25.0)
    {
        CutsceneNextShot();
    }
}

// focus on wikker's body
void next2(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        object oDest = GetObjectInArea("WP_CS_E_ATTACK", oPC);
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionJumpToObject(oDest, FALSE));
        CutsceneCameraSetup(-1.0,   0.0, 15.0, 0.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneCameraSetup(-1.0, 90.0,  5.0, 0.0, CAMERA_TRANSITION_TYPE_MEDIUM);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        CutsceneEnd();
    }
}

// wikkers is dead; guards are gone
void end()
{
    object oPC = GetFirstPC();
    object oWikkers = CutsceneGetActor("cs_wikker");
    object oGuard1  = CutsceneGetActor("cs_guard1");
    object oGuard2  = CutsceneGetActor("cs_guard2");
    object oGuard3  = CutsceneGetActor("cs_guard3");

    // wikkers is dead
    if (!GetIsDead(oWikkers))
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(400), oWikkers);
    }

    // guards are gone
    DestroyObject(oGuard1);
    DestroyObject(oGuard2);
    DestroyObject(oGuard3);

    // enable the ambient system for this area
    DeleteLocalInt(GetArea(oPC), "HF_DISABLE_AM");
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
    }
    else if (nEvent == CUTSCENE_EVENT_END)
    {
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
