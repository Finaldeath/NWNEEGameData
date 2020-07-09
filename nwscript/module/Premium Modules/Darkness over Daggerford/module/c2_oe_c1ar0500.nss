// daggerford onEnter script spawns NPCs and runs cutscenes

#include "hf_in_spawn"
#include "hf_in_cutscene"
#include "hf_in_util"

// spawn the NPCs in this area, respecting the day/night cycle
void spawn_npc(object oPC)
{
    int nSpawnType = 1;
    if (GetIsNight())
        nSpawnType = -1;

    int nLastSpawnType = GetLocalInt(OBJECT_SELF, "nLastSpawnType");
    if (nLastSpawnType != nSpawnType)
    {
        SpawnRemoveAllCreatures(oPC);
        SpawnEnter(oPC);
        SetLocalInt(OBJECT_SELF, "nLastSpawnType", nSpawnType);
    }
}

// deactivate all sounds in the area, except the three ENDGAME ones
void deactivate_sounds(object oPC)
{
    object oArea = OBJECT_SELF;
    object oObject = GetFirstObjectInArea(oArea);
    string sSound;
    while(GetIsObjectValid(oObject))
    {
         sSound = GetTag(oObject);
         if (GetStringLeft(sSound, 4) == "dag_")
            {
               SoundObjectStop(oObject);
            }
         oObject = GetNextObjectInArea(oArea);
    }
    SoundObjectPlay(GetObjectInArea("pm_endgamesound1", oArea));
    SoundObjectPlay(GetObjectInArea("pm_endgamesound2", oArea));
    SoundObjectPlay(GetObjectInArea("pm_endgamesound3", oArea));
}

// replace any gate guards that the player might have killed
void replace_guards(object oArea)
{
    location lGuard1WP = GetLocation(GetWaypointByTag("POST_pm_gateguard1"));
    location lGuard2WP = GetLocation(GetWaypointByTag("POST_pm_gateguard2"));
    location lGuard3WP = GetLocation(GetWaypointByTag("POST_pm_gateguard3"));
    location lGuard4WP = GetLocation(GetWaypointByTag("POST_pm_gateguard4"));
    location lGuard5WP = GetLocation(GetWaypointByTag("POST_pm_gateguard5"));
    location lGuard6WP = GetLocation(GetWaypointByTag("POST_pm_gateguard6"));
    location lGuard7WP = GetLocation(GetWaypointByTag("POST_pm_griffonguard1"));
    location lGuard8WP = GetLocation(GetWaypointByTag("POST_pm_griffonguard2"));

    if (!GetIsObjectValid(GetObjectInArea("pm_gateguard1",oArea)))
        CreateObject(OBJECT_TYPE_CREATURE,"pm_gateguard",lGuard1WP,FALSE,"pm_gateguard1");
    if (!GetIsObjectValid(GetObjectInArea("pm_gateguard2",oArea)))
        CreateObject(OBJECT_TYPE_CREATURE,"pm_gateguard",lGuard2WP,FALSE,"pm_gateguard2");
    if (!GetIsObjectValid(GetObjectInArea("pm_gateguard3",oArea)))
        CreateObject(OBJECT_TYPE_CREATURE,"pm_gateguard",lGuard3WP,FALSE,"pm_gateguard3");
    if (!GetIsObjectValid(GetObjectInArea("pm_gateguard4",oArea)))
        CreateObject(OBJECT_TYPE_CREATURE,"pm_gateguard",lGuard4WP,FALSE,"pm_gateguard4");
    if (!GetIsObjectValid(GetObjectInArea("pm_gateguard5",oArea)))
        CreateObject(OBJECT_TYPE_CREATURE,"pm_gateguard",lGuard5WP,FALSE,"pm_gateguard5");
    if (!GetIsObjectValid(GetObjectInArea("pm_gateguard6",oArea)))
        CreateObject(OBJECT_TYPE_CREATURE,"pm_gateguard",lGuard6WP,FALSE,"pm_gateguard6");

    // the griffons have all fled after the endgame begins
    if (GetLocalInt(GetModule(), "pm_endgame_start") == 0)
    {
        if (!GetIsObjectValid(GetObjectInArea("pm_griffonguard1",oArea)))
            CreateObject(OBJECT_TYPE_CREATURE,"pm_griffonguard",lGuard7WP,FALSE,"pm_griffonguard1");
        if (!GetIsObjectValid(GetObjectInArea("pm_griffonguard2",oArea)))
            CreateObject(OBJECT_TYPE_CREATURE,"pm_griffonguard",lGuard8WP,FALSE,"pm_griffonguard2");
    }
}

void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC))
    {
        // all commoners in the city run reduced AI to free up some CPU cycles
        // .. this could have been done in the blueprints, but wasn't
        if (GetLocalString(oPC, "HF_JOB") == "")
        {
            SetLocalString(oPC, "HF_JOB", "COMMONER");
            SetLocalInt(oPC, "HF_AI_LEVEL", -1);
        }
        return;
    }

    if((GetLocalInt(GetArea(oPC), "iResetMusic") == 1) && GetIsPC(oPC))
    {
        MusicBackgroundChangeNight(GetArea(oPC), 90);
        SetLocalInt(GetArea(oPC), "iResetMusic", 1);
    }

    // alternate the area music between day and night music
    /*object oArea = GetArea(OBJECT_SELF);
    if (GetLocalInt(OBJECT_SELF, "nMusicTrack") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nMusicTrack", 1);
        SetLocalInt(OBJECT_SELF, "nMusicTrack1", MusicBackgroundGetNightTrack(oArea));
        SetLocalInt(OBJECT_SELF, "nMusicTrack2", MusicBackgroundGetDayTrack(oArea));
    }
    int nMusicTrack  = GetLocalInt(OBJECT_SELF, "nMusicTrack");
    int nMusicTrack1 = GetLocalInt(OBJECT_SELF, "nMusicTrack1");
    int nMusicTrack2 = GetLocalInt(OBJECT_SELF, "nMusicTrack2");
    switch (nMusicTrack)
    {
        case 1:
            MusicBackgroundChangeDay(oArea,   nMusicTrack1);
            MusicBackgroundChangeNight(oArea, nMusicTrack2);
            SetLocalInt(OBJECT_SELF, "nMusicTrack", 2);
            break;
        case 2:
            MusicBackgroundChangeDay(oArea,   nMusicTrack2);
            MusicBackgroundChangeNight(oArea, nMusicTrack1);
            SetLocalInt(OBJECT_SELF, "nMusicTrack", 1);
            break;
    }        */

    //replace any dead gate guards
    // .. if the delay here is too short we get "duplicate" guards because
    // .. the area hasn't spawned them yet before we start checking
    if (GetIsPC(oPC))
    {
        object oArea = OBJECT_SELF;
        DelayCommand(2.5, replace_guards(oArea));
    }

    // cleanup wikkers' body after the cutscene
    // .. destroying it here gives the player time to search the corpse
    object oWikkers = GetObjectByTag("cs_wikker");
    if (GetIsObjectValid(oWikkers) && GetIsDead(oWikkers))
    {
        AssignCommand(oWikkers, SetIsDestroyable(TRUE));
        DestroyObject(oWikkers, 1.0);
    }

    object oBlood = GetObjectByTag("wikkers_blood");
    if (GetIsObjectValid(oBlood))
    {
        DestroyObject(oBlood, 1.0);
    }

    // lock daggerford castle after the player learns that the griffs are zhents
    if (GetLocalInt(GetModule(), "teygan_quests") >= 2)
    {
        if (GetLocalInt(OBJECT_SELF, "nLockedCastleAfterTeygan1") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nLockedCastleAfterTeygan1", 1);
            object oCastleGates = GetObjectByTag("C1AR0500_0401_EXIT");
            AssignCommand(oCastleGates, ActionCloseDoor(oCastleGates));
            SetLocked(oCastleGates, TRUE);
        }
    }

    //completely new lula code added by Luspr 3rd October 2006
    //what a nightmare this issue has turned out to be!
    //I am removing the lula spawn system that uses pj as the permutations
    //are somewhat complex - but I am retaining the clean up system starting at line 161
    //RB - amended further to ensure Lula only spawns at appropriate times
    if (GetIsNight() && GetLocalInt(GetModule(), "lula_met") <3)
    {
        object oL = GetObjectByTag("db_lula");
        location lLula = GetLocation(GetWaypointByTag("wp_lula_spawn"));
        if (!GetIsObjectValid(oL))
        {
            CreateObject(OBJECT_TYPE_CREATURE, "db_lula", lLula);
        }
    }
    else
    {
        object oL = GetObjectByTag("db_lula");
        if (GetIsObjectValid(oL))
        {
            DestroyObject(oL, 0.0);
        }
    }

    //This section deals with the forced conv with falias
    if (!GetLocalInt(GetArea(oPC), "Falias_talked") &&
         GetLocalInt(GetModule(), "pm_endgame_start") == 0)
    {
        CutscenePlay(oPC, "mv_ar0500_1");
        SetLocalInt(GetArea(oPC), "Falias_talked", 1);
    }

   //This section deals with the mariners alliance exit cutscene
   if (!GetLocalInt(OBJECT_SELF, "cs_mariner_fired") &&
       GetLocalInt(GetModule(), "barge_activity") == 2)
    {
       SetLocalInt(OBJECT_SELF, "cs_mariner_fired", 1);
       CutscenePlay(oPC, "mv_ar0500_3");
       return;
       // don't spawn the commoners since the cutscene moves player to castle
    }

    //This section deals with the escaped prisoner cutscene
    if (!GetLocalInt(OBJECT_SELF, "cs_prisoner_fired") &&
        GetLocalInt(GetModule(), "the_blackstone_inn") == 2)
    {
        SetLocalInt(OBJECT_SELF, "cs_prisoner_fired", 1);
        CutscenePlay(oPC, "mv_ar0500_2");
        DelayCommand(45.0, spawn_npc(oPC));
        return;
       // don't want to spawn the commoners, so we exit here
    }

    //This section deals with the end game forced conv with frederick
    if (!GetLocalInt(OBJECT_SELF, "pm_endgame_fired") &&
        GetLocalInt(GetModule(), "pm_endgame_start") == 1)
    {
        SetLocalInt(OBJECT_SELF, "pm_endgame_fired", 1);

        // different NPCs show-up at end game, so adjust spawn base name
        SpawnRemoveAllCreatures(oPC);
        SetLocalString(OBJECT_SELF, "HF_SP_NAME", "DaggerfordEndGame");

        // start the endgame sounds
        deactivate_sounds(oPC);

        // play the convo with fred and astriel
        object oGuard1 = GetObjectInArea("pm_griffonguard1", OBJECT_SELF);
        if (GetIsObjectValid(oGuard1))
            DestroyObject(oGuard1);
        object oGuard2 = GetObjectInArea("pm_griffonguard2", OBJECT_SELF);
        if (GetIsObjectValid(oGuard2))
            DestroyObject(oGuard2);
        CutscenePlay(oPC, "mv_ar0500_5");
    }

    // there is no day/night spawning during the end game
    if (GetLocalInt(GetModule(), "pm_endgame_start") == 0)
    {
        spawn_npc(oPC);
    }
    else
    {
        SpawnEnter(oPC);
    }

    // autosave the game if instructed to do so
    if (GetLocalInt(oPC, "HF_DO_AUTOSAVE") == 1)
    {
        SetLocalInt(oPC, "HF_DO_AUTOSAVE", 0);
        DoSinglePlayerAutoSave();
    }
}

