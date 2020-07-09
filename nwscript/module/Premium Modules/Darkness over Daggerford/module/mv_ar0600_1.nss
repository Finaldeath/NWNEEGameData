// this is the first cutscene in the game; bandits attack the caravan

#include "hf_in_cutscene"
#include "hf_in_graphics"
#include "hf_in_henchman"
#include "hf_in_util"

void SpawnTala(object oPC)
{
    object oAreaWP = GetObjectByTag("WP_AR0600_START");
    object oTala = GetObjectInArea("ks_talarenne", oPC);
    CutsceneAddActor("ks_talarenne", oTala);
}

void SpawnBandits(object oPC)
{
    object oArea = GetArea(oPC);
    if (GetLocalInt(oArea, "nHostilesSpawned") == 0)
    {
        SetLocalInt(oArea, "nHostilesSpawned", 1);
        int i;
        for (i=1; i<=3; i++)
        {
            string sWP = "WP_AR0600_BANDIT_" + IntToString(i);
            string sTag = "ks_bandroad_" + IntToString(i);
            int j = 0;
            object oWP = GetObjectByTag(sWP, j);
            while (GetIsObjectValid(oWP))
            {
                CreateObject(OBJECT_TYPE_CREATURE, sTag, GetLocation(oWP));
                oWP = GetObjectByTag(sWP, ++j);
            }
        }
        object oBandit = GetObjectInArea("ks_bandroad_0", oPC);
        CutsceneAddActor("ks_bandroad_0", oBandit);
        ChangeToStandardFaction(oBandit, STANDARD_FACTION_HOSTILE);
    }
}

object SpawnAstriel(object oPC)
{
    object oAstriel = OBJECT_INVALID;
    object oArea = GetArea(oPC);
    if (GetLocalInt(oArea, "nAstrielSpawned") == 0)
    {
        SetLocalInt(oArea, "nAstrielSpawned", 1);
        object oWP = GetWaypointByTag("WP_AR0600_ASTRIEL");
        oAstriel = CreateObject(OBJECT_TYPE_CREATURE, "db_amara3", GetLocation(oWP));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_10), oAstriel);
        SetLocalObject(oArea, "oAstriel", oAstriel);
        CutsceneAddActor("db_amara3", oAstriel);
    }
    else
    {
        oAstriel = GetLocalObject(oArea, "oAstriel");
    }
    return(oAstriel);
}

object SpawnHenchman(object oPC)
{
    object oHench = OBJECT_INVALID;
    object oArea = GetArea(oPC);
    if (GetLocalInt(oArea, "nHenchmanSpawned") == 0)
    {
        string sTag1;
        string sTag2;
        SetLocalInt(oArea, "nHenchmanSpawned", 1);
        if (GetLevelByClass(CLASS_TYPE_ROGUE, oPC)    >= 1 ||
            GetLevelByClass(CLASS_TYPE_WIZARD, oPC)   >= 1 ||
            GetLevelByClass(CLASS_TYPE_SORCERER, oPC) >= 1 ||
            GetLevelByClass(CLASS_TYPE_BARD, oPC)     >= 1)
        {
            // spawn the fighter henchman here and the rogue in town
            sTag1 = "pm_raegen";
            sTag2 = "ks_purfbin";
        }
        else
        {
            // spawn the rogue henchman here and the fighter in town
            sTag1 = "ks_purfbin";
            sTag2 = "pm_raegen";
        }

        // create the primary henchman here
        object oWP1 = GetWaypointByTag("WP_AR0600_HENCHMAN");
        oHench = CreateObject(OBJECT_TYPE_CREATURE, sTag1, GetLocation(oWP1));
        HenchmanLevelUp(oHench, oPC);
        SetLocalObject(GetArea(oPC), "oHenchman", oHench);

        // create the secondary henchman in town
        string sWP2 = "WP_HENCHMAN_START_" + sTag2;
        object oWP2 = GetWaypointByTag(sWP2);
        object oHench2 = CreateObject(OBJECT_TYPE_CREATURE, sTag2, GetLocation(oWP2));
        HenchmanLevelUp(oHench2, oPC);
    }
    return(oHench);
}

// some guards are dead, but other guards simply "play dead" by
// .. changing into a neutral faction and falling down for a while
void SpawnDeadGuards(object oPC)
{
    object oArea = GetArea(oPC);
    object oNeutral = GetObjectByTag("hf_cutscene_object");
    if (GetLocalInt(oArea, "nDeadGuardsSpawned") == 0)
    {
        SetLocalInt(oArea, "nDeadGuardsSpawned", 1);

        // sleeping guards will wake up later
        int i = 0;
        object oWP = GetObjectByTag("WP_AR0600_GUARD_2", i);
        while (GetIsObjectValid(oWP))
        {
            location lLoc = GetLocation(oWP);
            CreateObject(OBJECT_TYPE_PLACEABLE, "am_floorblood3", lLoc);
            object oGuard = CreateObject(OBJECT_TYPE_CREATURE, "ks_guardroad_1", lLoc, FALSE, "_hurtguard");
            effect eDmg = EffectDamage(GetCurrentHitPoints(oGuard)-1);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oGuard);
            ChangeFaction(oGuard, oNeutral);
            DelayCommand(0.5, SetPlotFlag(oGuard, TRUE));
            AssignCommand(oGuard, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 6500000000.0));
            AssignCommand(oGuard, SetCommandable(FALSE));
            oWP = GetObjectByTag("WP_AR0600_GUARD_2", ++i);
        }

        // dead guards
        i = 0;
        oWP = GetObjectByTag("WP_AR0600_GUARD_1", i);
        while (GetIsObjectValid(oWP))
        {
            location lLoc = GetLocation(oWP);
            CreateObject(OBJECT_TYPE_PLACEABLE, "am_floorblood3", lLoc);
            object oGuard = CreateObject(OBJECT_TYPE_CREATURE, "ks_guardroad_1", lLoc, FALSE, "_deadguard");
            effect eDmg = EffectDamage(GetCurrentHitPoints(oGuard)+1);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oGuard);
            oWP = GetObjectByTag("WP_AR0600_GUARD_1", ++i);
        }
    }
}

// no point changing the camera angle here since the dialog will change it
void start()
{
    object oPC = GetFirstPC();
    SpawnTala(oPC);
    CutsceneStart();
}

// talarenne talks
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oTala = CutsceneGetActor("ks_talarenne");

    if (fTime == 0.0)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_10), oTala);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // disrupt the oxen so that they aren't "synchronized"
        object oOx = GetObjectInArea("NW_OX", oTala);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION), oOx, 10.0);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_SLOW);
        AssignCommand(oTala, ActionStartConversation(oPC));
        // the "next" event is sent from a script in the dialog
    }
}


// explosions near PC; talarenne vanishes
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oTala = CutsceneGetActor("ks_talarenne");
    object oBandit = GetObjectInArea("ks_bandroad_0", oPC);
    object oGuard = GetNearestObjectByTag("ks_guardroad_1", oPC);
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        AssignCommand(oTala, PlaySound("vs_talarenn_053"));
        AssignCommand(oTala, ActionSpeakString(q+"What's that noise?"+q));
        AssignCommand(oTala, ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0, 3.0));
        AssignCommand(oGuard, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT));
        AssignCommand(oGuard, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT));
        CutsceneNext(3.0);
    }
    if (fTime == 3.0)
    {
        // we wait this long to adjust the camera since the dialog fools with it
        AssignCommand(oPC, SetCameraFacing(135.0, 9.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        SpawnAstriel(oPC);
        AssignCommand(oGuard, PlaySound("vs_mguard1_001"));
        AssignCommand(oGuard, ActionSpeakString(q+"Huh?"+q));
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        AssignCommand(oTala, PlaySound("vs_talarenn_054"));
        AssignCommand(oTala, ActionSpeakString(q+"An ambush!"+q));
        AssignCommand(oTala, ActionEquipMostDamagingMelee());
        AssignCommand(oGuard, ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK));
        AssignCommand(oPC, PlaySound("as_pl_battlegrp2"));
        MusicBattlePlay(GetArea(oPC));

        float fDur = 60.0;
        int i = 1;
        string sWP = "WP_AR0600_FIRE_1";
        object oWP = GetObjectInArea(sWP, oTala, i);
        while (GetIsObjectValid(oWP))
        {
            location lLoc = GetLocation(oWP);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), lLoc, fDur);
            CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamemedium", lLoc);
            CreateObject(OBJECT_TYPE_PLACEABLE, "plc_dustplume", lLoc);
            oWP = GetObjectInArea(sWP, oTala, ++i);
        }
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        AssignCommand(oPC, PlaySound("as_pl_battlegrp5"));
        AssignCommand(oGuard, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        float fDur = 7.0;
        AssignCommand(oTala, PlaySound("vs_talarenn_055"));
        AssignCommand(oTala, ActionSpeakString(q+"Oh! What's happening to me?"+q));
        AssignCommand(oTala, ActionPlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, fDur));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_AURA_COLD), oTala, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BLUR), oTala, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PARALYZE_HOLD), oTala, fDur);
        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        AssignCommand(oGuard, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        AssignCommand(oGuard, PlaySound("vs_mguard1_002"));
        AssignCommand(oGuard, ActionSpeakString(q+"Mistress Talarenne!"+q));
        CutsceneNext(18.0);
    }
    else if (fTime == 18.0)
    {
        AssignCommand(oPC, PlaySound("as_pl_battlegrp6"));
        AssignCommand(oTala, PlaySound("vs_talarenn_056"));
        AssignCommand(oTala, ActionSpeakString(q+"Please! Help me!"+q));
        AssignCommand(oTala, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 5.0));
        vector v = GetPosition(oTala);
        v.z += 0.3;
        location lLoc = Location(GetArea(oTala), v, 0.0);
        DrawCircle(lLoc, 2.5, VFX_IMP_MAGIC_PROTECTION);
        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTala));
        DestroyObject(oTala, 2.5);
        DelayCommand(2.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH_L), lLoc));
        CutsceneNext(23.0);
    }
    else if (fTime == 23.0)
    {
        AssignCommand(oPC, PlaySound("as_pl_battlegrp2"));
        AssignCommand(oBandit, ActionCastFakeSpellAtObject(SPELL_FIREBALL, oGuard, PROJECTILE_PATH_TYPE_DEFAULT));
        CutsceneNext(26.0);
    }
    else if (fTime == 26.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetCurrentHitPoints(oGuard)), oGuard);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_M), oGuard);
        CutsceneNext(27.0);
    }
    else if (fTime == 27.0)
    {
        AssignCommand(oPC, PlaySound("as_pl_battlegrp5"));
        CutsceneNextShot();
    }
}

// astriel attacks
void next2(float fTime)
{
    object oPC = GetFirstPC();
    object oAstriel = CutsceneGetActor("db_amara3");
    object oBandit =  CutsceneGetActor("ks_bandroad_0");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        SpawnDeadGuards(oPC);
        AssignCommand(oPC, SetCameraFacing(200.0, 5.0, 80.0, CAMERA_TRANSITION_TYPE_VERY_FAST));
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        //AssignCommand(oAstriel, ActionSpeakString(q+"Attack the enemy!"+q));
        PlayVoiceChat(VOICE_CHAT_ATTACK, oAstriel);
        AssignCommand(oAstriel, ActionEquipMostDamagingMelee());
        AssignCommand(oAstriel, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
        SpawnBandits(oAstriel);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oPC, SetCameraFacing(150.0, 10.0, 80.0, CAMERA_TRANSITION_TYPE_VERY_FAST));
        //PlayVoiceChat(VOICE_CHAT_BATTLECRY1, oAstriel);
        AssignCommand(oAstriel, ClearAllActions(TRUE));
        AssignCommand(oAstriel, ActionMoveToObject(oBandit, TRUE, 1.0));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        CutsceneEnd();
    }
}

void end()
{
    object oPC = GetFirstPC();

    // force rest the player so that he recovers spells and feats
    //ForceRest(oPC);

    // tala is gone
    object oTala = CutsceneGetActor("ks_talarenne");
    DestroyObject(oTala);

    CreateObject(OBJECT_TYPE_PLACEABLE, "ks_imprison_pl", GetLocation(GetWaypointByTag("WP_AR0600_GRASS")));

    // one of the guards was fireballed; make sure he's dead
    object oGuard = GetObjectInArea("ks_guardroad_1", oTala);
    if (!GetIsDead(oGuard))
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oGuard);
    }

    // give first journal update
    AddJournalQuestEntry("j1", 2, oPC);
    AddJournalQuestEntry("j200", 1, oPC);

    // astriel, bandits, and henchman are there
    SpawnDeadGuards(oPC);
    SpawnAstriel(oPC);
    SpawnBandits(oPC);
    SpawnHenchman(oPC);

    // mark scene ended for astriel's heartbeat
    SetLocalInt(GetArea(oPC), "nSceneEnded", 1);
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
