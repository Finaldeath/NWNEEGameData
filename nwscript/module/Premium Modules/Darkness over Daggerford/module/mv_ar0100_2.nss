// this scene occurs right after gorgo's death
// .. tala pops out of the gem
// .. militia soldiers face off against some orcs and the orcs run away

#include "hf_in_cutscene"
#include "hf_in_graphics"
#include "x0_i0_position"
#include "hf_in_npc"
#include "hf_in_util"

// destroy all creatures with a certain tag in this area
void DestroyCreature(string sTag, object oPC)
{
    int i = 1;
    object oCreature = GetObjectInArea(sTag, oPC, i);
    while (GetIsObjectValid(oCreature))
    {
        DestroyObject(oCreature);
        oCreature = GetObjectInArea(sTag, oPC, ++i);
    }
}

// destroys all creatures hostile to player in this area
void DestroyHostileCreatures(object oPC)
{
    int i = 1;
    object oCreature = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oPC, i);
    while (GetIsObjectValid(oCreature))
    {
        if (GetTag(oCreature) != "ks_gorgomorz")
        {
            DestroyObject(oCreature);
        }
        oCreature = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oPC, ++i);
    }

    // the above should have destroyed all of these creatures, but do it again
    DestroyCreature("ks_gate_tanarukk", oPC);
    DestroyCreature("ks_farm_orc1", oPC);
    DestroyCreature("ks_farm_orc2", oPC);
    DestroyCreature("_ar0100_gorgo_friend", oPC);
}

// returns a location just behind the target
location GetStepBehindLocation(object oTarget, float fDist)
{
    float fDir = GetFacing(oTarget);
    float fAngleOpposite = GetOppositeDirection(fDir);
    return GenerateNewLocation(oTarget, fDist, fAngleOpposite, fDir);
}

// all creatures near the given center location fall down for a while
void AllFallDown(location lLoc, float fDur)
{
    float fSize = 5.0;
    object o = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lLoc, FALSE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(o))
    {
        if (!GetIsDead(o) && !GetIsPC(o))
        {
            location lNew = GetStepBehindLocation(o, 2.5);
            AssignCommand(o, ClearAllActions(TRUE));
            AssignCommand(o, JumpToLocation(lNew));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_DAZED_S), o, fDur);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), o, fDur);
        }
        o = GetNextObjectInShape(SHAPE_SPHERE, fSize, lLoc, FALSE, OBJECT_TYPE_CREATURE);
    }
}

void start()
{
    object oPC = GetFirstPC();
    object oArea = GetArea(oPC);
    DestroyHostileCreatures(oPC);
    MusicBattleStop(oArea);
    MusicBackgroundChangeNight(oArea, 55);
    MusicBackgroundChangeDay(oArea, 55);

    BlackScreen(oPC);
    object oGorg = GetObjectInArea("ks_gorgomorz", oPC);
    if (GetIsObjectValid(oGorg))
        SetLocalLocation(oArea, "lGorgomorzDeath", GetLocation(oGorg));
    else
        SetLocalLocation(oArea, "lGorgomorzDeath", GetLocation(oPC));
    CutsceneStart(TRUE);
}

// spawn npcs used in the cutscene
void FleeSceneInit(object oPC)
{
    int i = 0;
    object oWP = GetObjectByTag("WP_AR0100_CUT1_FLEE_ORC", i);
    while (GetIsObjectValid(oWP))
    {
        CreateObject(OBJECT_TYPE_CREATURE, "ks_farm_orc1", GetLocation(oWP), FALSE, "_ar0100_flee_orc");
        oWP = GetObjectByTag("WP_AR0100_CUT1_FLEE_ORC", ++i);
    }

    i = 0;
    oWP = GetObjectByTag("WP_AR0100_CUT1_FLEE_MILITIA", i);
    while (GetIsObjectValid(oWP))
    {
        CreateObject(OBJECT_TYPE_CREATURE, "pm_malitia", GetLocation(oWP), FALSE, "_ar0100_flee_militia");
        oWP = GetObjectByTag("WP_AR0100_CUT1_FLEE_MILITIA", ++i);
    }
}

// guards cheer as the orcs run away
void FleeSceneDoCheer(object o)
{
    string s;
    string s2;
    int nAnim;
    int n = d6();
    if      (n == 1) { s = "Hooray!"; s2 = "as_pl_tavclap1"; nAnim = ANIMATION_FIREFORGET_VICTORY1;}
    else if (n == 2) { s = "Yes!"; s2 = "as_pl_laughingm1"; nAnim = ANIMATION_FIREFORGET_VICTORY2; }
    else if (n == 3) { s = "We're saved!"; s2 = "as_pl_laughingm2"; nAnim = ANIMATION_FIREFORGET_VICTORY3; }
    else if (n == 4) { s = "Yah!"; s2 = "as_pl_comyaygrp1"; nAnim = ANIMATION_FIREFORGET_TAUNT; }
    else if (n == 5) { s = "*cheer*"; s2 = "as_pl_comyaygrp2"; nAnim = ANIMATION_FIREFORGET_SALUTE; }
    else if (n == 6) { s = "Yay!"; s2 = "as_pl_comyaygrp3"; nAnim = ANIMATION_FIREFORGET_VICTORY1; }

    AssignCommand(o, PlaySound(s2));
    AssignCommand(o, ActionSpeakString(s, TALKVOLUME_SHOUT));
    AssignCommand(o, ActionPlayAnimation(nAnim));
}

// guards cheer as the orcs run away
void FleeSceneCheer(object oPC)
{
    int i = 0;
    object o = GetObjectByTag("_ar0100_flee_militia", i);
    while (GetIsObjectValid(o))
    {
        float fDelay = 0.1*i;
        DelayCommand(fDelay, FleeSceneDoCheer(o));
        o = GetObjectByTag("_ar0100_flee_militia", ++i);
    }
}

// orcs run away
void FleeSceneDoRun(object o)
{
    string s;
    string s2;
    int n = d6();
    if      (n == 1) { s = "Outa my way!"; s2 = "c_orc_hit1"; }
    else if (n == 2) { s = "Run!"; s2 = "c_orc_hit2"; }
    else if (n == 3) { s = "Ahhh!"; s2 = "c_orc_slct"; }
    else if (n == 4) { s = "Let's get outa here!"; s2 = "c_orc_bat1"; }
    else if (n == 5) { s = "Me no wanna die!"; s2 = "c_orc_atk1"; }
    else if (n == 6) { s = "Run!"; s2 = "c_orc_slct"; }

    object oWP = GetWaypointByTag("WP_AR0100_CUT1_FLEE_EXIT");
    AssignCommand(o, PlaySound(s2));
    AssignCommand(o, ActionSpeakString(s, TALKVOLUME_SHOUT));
    AssignCommand(o, ActionMoveToObject(oWP, TRUE));
}

// orcs run away
void FleeSceneRun(object oPC)
{
    int i = 0;
    object o = GetObjectByTag("_ar0100_flee_orc", i);
    while (GetIsObjectValid(o))
    {
        float fDelay = 0.25*i;
        DelayCommand(fDelay, FleeSceneDoRun(o));
        o = GetObjectByTag("_ar0100_flee_orc", ++i);
    }
}

// gorgo explodes in a puff of foul-smelling smoke
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oArea = GetArea(oPC);
    object oGorg = GetObjectInArea("ks_gorgomorz", oPC);
    location lGorg = GetLocalLocation(oArea, "lGorgomorzDeath");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FAST);
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionJumpToLocation(lGorg));
        CutsceneNext(1.25);
    }
    else if (fTime == 1.25)
    {
        CutsceneCameraSetup(-1.0, -1.0,  5.0, 0.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneCameraSetup(-1.0, -1.0, 16.0, 0.0, CAMERA_TRANSITION_TYPE_MEDIUM);
        AssignCommand(oGorg, PlaySound("c_gorgo_064"));
        AssignCommand(oGorg, ActionSpeakString(q+"Curse you, "+GetName(oPC)+"!"+q));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PARALYZED), oGorg, 60.0);
        CutsceneNext(1.5);
    }
    else if (fTime == 1.5)
    {
        DrawLineVert(lGorg, VFX_FNF_FIREBALL, 5);
        AllFallDown(lGorg, 30.0);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        DrawCircle(lGorg, 3.0, VFX_IMP_DOOM);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE), lGorg);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), lGorg);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_FIRE), lGorg);
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        DrawCircle(lGorg, 3.0, VFX_IMP_BREACH);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), lGorg);
        CutsceneNext(7.5);
    }
    else if (fTime == 7.5)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH_L), lGorg);
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), lGorg);
        CutsceneNext(13.0);
    }
    else if (fTime == 13.0)
    {
        DrawCircle(lGorg, 4.0, VFX_IMP_FLAME_M);
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        AssignCommand(oPC, PlaySound("sco_mehanevil03"));
        FadeToBlack(oPC, FADE_SPEED_SLOW);
        CutsceneNext(17.0);
    }
    else if (fTime == 17.0)
    {
        CutsceneNextShot();
    }
}

// talarenne pops out of the gem
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oTala = CutsceneGetActor("ks_talarenne");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        object oSphere = GetItemPossessedBy(oPC, "db_buddyinaglobe");
        if (GetIsObjectValid(oSphere))
        {
            // move player into a known position where tala can appear
            FadeFromBlack(oPC, FADE_SPEED_FAST);
            CutsceneMoveTo("WP_AR0100_CUT1_TALA_CAM1");
            CutsceneCameraSetup(-1.0, DIRECTION_WEST, 3.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
            CutsceneNext(1.0);
        }
        else
        {
            // player doesn't have talarenne's sphere, so skip this shot
            CutsceneNextShot();
        }
    }
    else if (fTime == 1.0)
    {
        // tala pops out of the gem with some fireworks
        object oWP = GetWaypointByTag("WP_AR0100_CUT1_TALA");
        location lLoc = GetLocation(oWP);
        DrawCircle(lLoc, 2.5, VFX_IMP_MAGIC_PROTECTION);
        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTala));
        DelayCommand(2.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH_L), lLoc));
        oTala = CreateObject(OBJECT_TYPE_CREATURE, "ks_talarenne", lLoc);
        CutsceneAddActor("ks_talarenne", oTala);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        // close off tala's journal (the player will never be able to read the journal entry)
        AddJournalQuestEntry("j200", 10, oPC);
        CutsceneCameraSetup(-1.0, DIRECTION_WEST, 1.0, 80.0, CAMERA_TRANSITION_TYPE_FAST);
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        AssignCommand(oTala, ActionStartConversation(oPC, "at_talaendgame"));
    }
}

// orcs facing off against mercs run away now that gorgo is dead
void next2(float fTime)
{
    object oPC = GetFirstPC();
    object oOrc1 = GetNearestObjectByTag("_ar0100_flee_orc", oPC, 1);
    object oOrc2 = GetNearestObjectByTag("_ar0100_flee_orc", oPC, 2);
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        FleeSceneInit(oPC);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FAST);
        CutsceneMoveTo("WP_AR0100_CUT1_CAMERA5");
        CutsceneCameraSetup(-1.0, DIRECTION_WEST, 12.0, 55.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oOrc1, PlaySound("c_orc_bat1"));
        AssignCommand(oOrc1, ActionSpeakString(q+"Gorgomorz is dead!"+q));
        AssignCommand(oOrc1, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        AssignCommand(oOrc2, PlaySound("c_orc_slct"));
        AssignCommand(oOrc2, ActionSpeakString(q+"Uh... Now we gotta kill "+GetName(oPC)+" all by ourselves!"+q));
        AssignCommand(oOrc2, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        FleeSceneRun(oPC);
        CutsceneNext(17.0);
    }
    else if (fTime == 17.0)
    {
        FleeSceneCheer(oPC);
        CutsceneNext(22.0);
    }
    else if (fTime == 22.0)
    {
        CutsceneEnd();
    }
}

// the delay is required here (otherwise the cutscene creature gets confused)
// the next cut-scene should play on the area enter event
void end()
{
    object oPC = GetFirstPC();
    SetLocalInt(oPC, "CS_END", 1);
    BlackScreen(oPC);
    DelayCommand(1.5, TeleportToWaypoint(oPC, "WP_AR0401_CUT1_START"));
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
