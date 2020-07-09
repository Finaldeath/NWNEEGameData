// this is the cutscene where elveronne kills his sisters

#include "hf_in_cutscene"
#include "hf_in_util"

// create the NPCs used in this scene
void SpawnNPCs(object oPC)
{
    // spawn elveronne
    object oElveronne = GetObjectByTag("ac_elveronne");
    DestroyObject(oElveronne);
    object oWP = GetWaypointByTag("WP_AR0701A_CUT1_ELVERONNE");
    oElveronne = CreateObject(OBJECT_TYPE_CREATURE, "ac_elveronne", GetLocation(oWP));
    SetImmortal(oElveronne, TRUE);
    SetLocalInt(oElveronne, "no_banter", 1);
    AssignCommand(oElveronne, ClearAllActions(TRUE));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectHaste(), oElveronne);
    CutsceneAddActor("ac_elveronne", oElveronne);

    // move alicine into position
    object oMuriel = GetObjectInArea("ac_muriel", oPC);
    CutsceneAddActor("ac_muriel", oMuriel);
    oWP = GetWaypointByTag("WP_AR0701A_CUT1_MURIEL");
    SetLocalInt(oMuriel, "no_banter", 1);
    AssignCommand(oMuriel, ClearAllActions());
    AssignCommand(oMuriel, ActionMoveToObject(oWP, TRUE, 0.0));

    // move muriel into position
    oWP = GetWaypointByTag("WP_AR0701A_CUT1_ALICINE");
    object oAlicine = GetObjectInArea("ac_alicine", oPC);
    CutsceneAddActor("ac_alicine", oAlicine);
    SetLocalInt(oAlicine, "no_banter", 1);
    AssignCommand(oAlicine, ClearAllActions());
    AssignCommand(oAlicine, ActionMoveToObject(oWP, TRUE, 0.0));
}

// party guests flee in terror when elveronne appears
void GuestsFlee(object oPC)
{
    // talking turns to screaming
    object oSnd = GetObjectInArea("ac_snd_nobles", oPC);
    SoundObjectStop(oSnd);
    oSnd = GetObjectInArea("ac_snd_nobles2", oPC);
    SoundObjectStop(oSnd);
    AssignCommand(oPC, PlaySound("as_pl_panicgrp4"));

    // guests flee
    object oExit = GetWaypointByTag("WP_AR0701A_CUT1_EXIT");
    int i = 1;
    object oGuest = GetObjectInArea("ac_partyguest", oPC, i);
    while (GetIsObjectValid(oGuest))
    {
        SetLocalInt(oGuest, "no_banter", 1);
        AssignCommand(oGuest, ClearAllActions());
        DelayCommand(0.1, AssignCommand(oGuest, ActionMoveToObject(oExit, TRUE)));
        DelayCommand(4.0, DestroyObject(oGuest));
        oGuest = GetObjectInArea("ac_partyguest", oPC, ++i);
    }
}

// start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE, "WP_AR0701A_CUT1_START", FALSE);
    CutsceneMusic(TRACK_CRYPT2);
    SpawnNPCs(oPC);
}

// elveronne comes up from the basement
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oElveronne = CutsceneGetActor("ac_elveronne");

    if (fTime == 0.0)
    {
        // allow some time for the camera to settle down
        CutsceneNext(3.0);
        object oDoor = GetObjectByTag("C1AR0701A_C1AR0701C_EXIT");
        SetLocked(oDoor, FALSE);
        AssignCommand(oDoor, ActionOpenDoor(oDoor));
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC);
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 4.0, 65.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // elveronne climbs up the stairs
        object o1 = GetObjectByTag("WP_AR0701A_CUT1_ELVERONNE_1");
        AssignCommand(oElveronne, PlaySound("c_zombie_bat1"));
        AssignCommand(oElveronne, ActionMoveToObject(o1));
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 4.0, 75.0, CAMERA_TRANSITION_TYPE_FAST);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        // elveronne heads into the room
        object o2 = GetObjectByTag("WP_AR0701A_CUT1_ELVERONNE_2");
        AssignCommand(oElveronne, ActionMoveToObject(o2, TRUE));
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        AssignCommand(oElveronne, PlaySound("c_zombie_atk1"));
        CutsceneNextShot();
    }
}

// the sisters drink the poison
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oElveronne = CutsceneGetActor("ac_elveronne");
    object oMuriel    = CutsceneGetActor("ac_muriel");
    object oAlicine   = CutsceneGetActor("ac_alicine");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // move to next camera
        CutsceneMoveTo("WP_AR0701A_CUT1_CAM1");
        CutsceneCameraSetup(-1.0, 40.0, 4.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        SetPlotFlag(oAlicine, FALSE);
        SetPlotFlag(oMuriel, FALSE);
        AssignCommand(oAlicine, ClearAllActions());
        AssignCommand(oAlicine, SetFacingPoint(GetPosition(oMuriel)));
        AssignCommand(oMuriel, SetFacingPoint(GetPosition(oAlicine)));
        AssignCommand(oAlicine, ActionSpeakString("Cheers!"));
        AssignCommand(oAlicine, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        AssignCommand(oAlicine, ActionWait(1.0));
        //AssignCommand(oAlicine, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 1.0));
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oMuriel, ClearAllActions());
        AssignCommand(oMuriel, ActionSpeakString("Bottoms up!"));
        AssignCommand(oMuriel, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        AssignCommand(oMuriel, ActionWait(1.0));
        //AssignCommand(oMuriel, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 1.0));
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oAlicine, ClearAllActions());
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oAlicine);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oMuriel, ClearAllActions());
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oMuriel);
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        CutsceneNextShot();
    }
}

// elveronne appears, roars, and guests flee in terror
void next2(float fTime)
{
    object oPC = GetFirstPC();
    object oElveronne = CutsceneGetActor("ac_elveronne");
    object oMuriel    = CutsceneGetActor("ac_muriel");
    object oAlicine   = CutsceneGetActor("ac_alicine");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // move to next camera
        CutsceneMoveTo("WP_AR0701A_CUT1_CAM1");
        CutsceneCameraSetup(-1.0, 150.0, 1.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        // elveronne roars in the doorway
        AssignCommand(oElveronne, PlaySound("c_zombie_bat2"));
        AssignCommand(oElveronne, ActionSpeakString(q+"RAAWWGGGH!!"+q));
        AssignCommand(oElveronne, ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        // guests flee in terror
        CutsceneCameraSetup(-1.0, 40.0, 19.0, 60.0, CAMERA_TRANSITION_TYPE_FAST);
        GuestsFlee(oPC);
        AssignCommand(oMuriel, ClearAllActions());
        AssignCommand(oMuriel, SetFacingPoint(GetPosition(oElveronne)));
        AssignCommand(oAlicine, ClearAllActions());
        AssignCommand(oAlicine, SetFacingPoint(GetPosition(oElveronne)));
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        // elveronne moves towards sisters
        CutsceneCameraSetup(-1.0, 40.0, 4.0, 80.0, CAMERA_TRANSITION_TYPE_FAST);
        object oWP = GetWaypointByTag("WP_AR0701A_CUT1_ELVERONNE_3");
        AssignCommand(oElveronne, ActionMoveToObject(oWP, TRUE, 0.0));
        CutsceneNext(16.0);
    }
    else if (fTime == 16.0)
    {
        CutsceneNextShot();
    }
}

// elveronne confronts his sisters
void next3(float fTime)
{
    object oPC = GetFirstPC();
    object oElveronne = CutsceneGetActor("ac_elveronne");
    object oMuriel    = CutsceneGetActor("ac_muriel");
    object oAlicine   = CutsceneGetActor("ac_alicine");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        AssignCommand(oPC, PlaySound("c_zombie_bat1"));
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        AssignCommand(oMuriel, ActionSpeakString(q+"Oh my word! Elveronne!"+q));
        AssignCommand(oMuriel, ActionPlayAnimation(ANIMATION_FIREFORGET_SPASM));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oAlicine, ActionSpeakString(q+"Wait! I can explain..."+q));
        AssignCommand(oAlicine, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 4.0));
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        CutsceneNextShot();
    }
}

// elveronne kills sisters
void next4(float fTime)
{
    object oPC = GetFirstPC();
    object oElveronne = CutsceneGetActor("ac_elveronne");
    object oMuriel    = CutsceneGetActor("ac_muriel");
    object oAlicine   = CutsceneGetActor("ac_alicine");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // elveronne attacks muriel
        MusicBattlePlay(GetArea(oPC));
        ChangeToStandardFaction(oMuriel, STANDARD_FACTION_HOSTILE);
        AssignCommand(oElveronne, PlaySound("c_zombie_bat2"));
        AssignCommand(oElveronne, ActionAttack(oMuriel));
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        // muriel dies
        SetPlotFlag(oMuriel, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oMuriel);
        ChangeToStandardFaction(oMuriel, STANDARD_FACTION_DEFENDER);
        CreateObject(OBJECT_TYPE_PLACEABLE, "am_floorblood3", GetLocation(oMuriel));
        AssignCommand(oElveronne, ClearAllActions(TRUE));
        AssignCommand(oElveronne, ActionWait(3.1));
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // elveronne attacks alicine
        ChangeToStandardFaction(oAlicine, STANDARD_FACTION_HOSTILE);
        AssignCommand(oElveronne, PlaySound("c_zombie_bat1"));
        AssignCommand(oElveronne, ActionAttack(oAlicine));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        // alicine dies
        SetPlotFlag(oAlicine, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oAlicine);
        ChangeToStandardFaction(oAlicine, STANDARD_FACTION_DEFENDER);
        CreateObject(OBJECT_TYPE_PLACEABLE, "am_floorblood3", GetLocation(oAlicine));
        AssignCommand(oElveronne, ClearAllActions(TRUE));
        AssignCommand(oElveronne, ActionWait(3.0));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        MusicBattleStop(GetArea(oPC));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        CutsceneNextShot();
    }
}

// elveronne takes the necklace and leaves
void next5(float fTime)
{
    object oPC = GetFirstPC();
    object oElveronne = CutsceneGetActor("ac_elveronne");
    object oMuriel    = CutsceneGetActor("ac_muriel");
    object oAlicine   = CutsceneGetActor("ac_alicine");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // elveronne celebrates
        AssignCommand(oElveronne, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        // elveronne takes the necklace
        AssignCommand(oElveronne, ActionMoveToObject(oAlicine, FALSE, 0.5));
        AssignCommand(oElveronne, ActionDoCommand(AssignCommand(oPC, PlaySound("c_zombie_atk2"))));
        AssignCommand(oElveronne, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 4.0));
        AssignCommand(oElveronne, ActionDoCommand(AssignCommand(oPC, PlaySound("it_jewelry"))));
        AssignCommand(oElveronne, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3));
        AssignCommand(oElveronne, ActionSpeakString(q+"...MY NECKLASSS!!!..."+q));
        AssignCommand(oElveronne, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
        AssignCommand(oElveronne, ActionDoCommand(PlaySound("c_zombie_atk1")));
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        // elveronne leaves
        object oWP = GetWaypointByTag("WP_AR0701A_CUT1_EXIT");
        AssignCommand(oElveronne, ActionMoveToObject(oWP));
        CutsceneNext(13.0);
    }
    else if (fTime == 13.0)
    {
        CutsceneEnd();
    }
}

// sisters are dead; elveronne is gone; guests are gone
void end()
{
    object oPC = GetFirstPC();
    object oElveronne = CutsceneGetActor("ac_elveronne");
    object oMuriel    = CutsceneGetActor("ac_muriel");
    object oAlicine   = CutsceneGetActor("ac_alicine");

    // sisters are dead
    if (!GetIsDead(oAlicine))
    {
        SetPlotFlag(oAlicine, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oAlicine);
        if (GetLocalInt(oPC, "sisters_dead") == 0)
        {
            CreateObject(OBJECT_TYPE_PLACEABLE, "am_floorblood3", GetLocation(oAlicine));
        }
    }
    if (!GetIsDead(oMuriel))
    {
        SetPlotFlag(oMuriel, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oMuriel);
        if (GetLocalInt(oPC, "sisters_dead") == 0)
        {
            CreateObject(OBJECT_TYPE_PLACEABLE, "am_floorblood3", GetLocation(oMuriel));
        }
    }

    // elveronne is gone
    DestroyObject(oElveronne);

    // party guests are gone
    int i = 1;
    object oGuest = GetObjectInArea("ac_partyguest", oPC, i);
    while (GetIsObjectValid(oGuest))
    {
        DestroyObject(oGuest);
        oGuest = GetObjectInArea("ac_partyguest", oPC, ++i);
    }

    // close his coffin back in the graveyard
    object oC = GetObjectByTag("ac_sarcophagus2");
    AssignCommand(oC, PlayAnimation(ANIMATION_PLACEABLE_CLOSE));

    // Set Journal
    // if sisters killed by zombie, else if player poisoned them first
    if (GetLocalInt(GetFirstPC(), "sisters_dead") == 0)
        AddJournalQuestEntry("j53", 7, oPC);
    else
        AddJournalQuestEntry("j53", 8, oPC);

    // update plot
    SetLocalInt(oPC, "sisters_dead", 1);
    SetLocalInt(oPC, "moris_quest", 5);
    SetLocalInt(oPC, "elveronne_quest", 7);
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
        if (GetLocalInt(GetFirstPC(), "sisters_dead") == 0)
        {
            // elveronne comes out of the basement
            if (nShot == 0) next0(fTime);
            if (nShot == 1) next2(fTime);
            if (nShot == 2) next3(fTime);
            if (nShot == 3) next4(fTime);
            if (nShot == 4) next5(fTime);
        }
        else
        {
            // the player poisoned the sisters
            if (nShot == 0) next0(fTime);
            if (nShot == 1) next1(fTime);
            if (nShot == 2) next2(fTime);
            if (nShot == 3) next5(fTime);
        }
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
