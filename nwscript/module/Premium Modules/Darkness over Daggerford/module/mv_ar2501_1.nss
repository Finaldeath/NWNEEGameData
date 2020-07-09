// this is the cutscene in illefarn trying to open the door to the hall of wonders

#include "hf_in_cutscene"
#include "hf_in_spawn"
#include "nw_i0_generic"
#include "hf_in_npc"

// spawn the scene actors
void spawnActors(object oPC)
{
    object oWP;
    int nLevels = SpawnGetPartyCR(oPC, 30);

    // wizard
    oWP = GetWaypointByTag("WP_AR2501_CUT1_WIZARD");
    object oWizard = CreateObject(OBJECT_TYPE_CREATURE, "ks_zhent_wizard", GetLocation(oWP));
    CutsceneAddActor("ks_wizard", oWizard);
    SetLocalInt(oWizard, "HF_SP_LIMIT_LEVELUP_MAX", 17);
    SpawnLevelupCreature(oWizard, nLevels);

    // rogue
    oWP = GetWaypointByTag("WP_AR2501_CUT1_ROGUE");
    object oRogue = CreateObject(OBJECT_TYPE_CREATURE, "ks_zhent_sisrog", GetLocation(oWP));
    CutsceneAddActor("ks_rogue", oRogue);
    SetLocalInt(oRogue, "HF_SP_LIMIT_LEVELUP_MAX", 15);
    SpawnLevelupCreature(oRogue, nLevels);

    // fighter
    oWP = GetWaypointByTag("WP_AR2501_CUT1_FIGHTER");
    object oFighter = CreateObject(OBJECT_TYPE_CREATURE, "ks_zhent_sismon", GetLocation(oWP));
    CutsceneAddActor("ks_fighter", oFighter);
    SetLocalInt(oFighter, "HF_SP_LIMIT_LEVELUP_MAX", 14);
    SpawnLevelupCreature(oFighter, nLevels);
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    spawnActors(oPC);
    CutsceneStart(TRUE, FALSE, "WP_AR2501_CUT1_START", FALSE);
    CutsceneMusic(TRACK_CRYPT1);
}

// wizard casts a knock spell, which fails
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oWizard = CutsceneGetActor("ks_wizard");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // allow some time for spawn and camera to settle down
        object oArea = GetArea(oPC);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_WEST, 15.0, 60.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_WEST, 1.0, 80.0, CAMERA_TRANSITION_TYPE_MEDIUM);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // wizard casts a knock spell
        AssignCommand(oWizard, PlaySound("vs_chant_evoc_hm"));
        AssignCommand(oWizard, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 3.0));
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        // spell fails
        AssignCommand(oWizard, PlaySound("gui_failspell"));
        AssignCommand(oWizard, ActionSpeakString(q+"What! It's still locked?"+q));
        AssignCommand(oWizard, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(13.0);
    }
    else if (fTime == 13.0)
    {
        CutsceneNextShot();
    }
}

// sisters bicker with the wizard
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oWizard  = CutsceneGetActor("ks_wizard");
    object oRogue   = CutsceneGetActor("ks_rogue");
    object oFighter = CutsceneGetActor("ks_fighter");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneMoveTo("WP_AR2501_CUT1_CAM1");
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 1.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        AssignCommand(oRogue, ActionSpeakString(q+"Maybe there's a magic password?"+q));
        AssignCommand(oRogue, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        AssignCommand(oWizard, ActionSpeakString(q+"Nonsense! Any fool would think of that! It's obviously something more elaborate..."+q));
        AssignCommand(oWizard, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED));
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        AssignCommand(oFighter, ActionSpeakString(q+"How about we bash them doors down?"+q));
        AssignCommand(oFighter, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
        CutsceneNext(20.0);
    }
    else if (fTime == 20.0)
    {
        AssignCommand(oWizard, ActionSpeakString(q+"Such a stupid action will lead nowhere!"+q));
        AssignCommand(oWizard, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED));
        CutsceneNext(26.0);
    }
    else if (fTime == 26.0)
    {
        AssignCommand(oRogue, ActionSpeakString(q+"Are you calling my sister stupid?"+q));
        AssignCommand(oRogue, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 6.0));
        CutsceneNext(32.0);
    }
    else if (fTime == 32.0)
    {
        AssignCommand(oWizard, ActionSpeakString(q+"Uh...I mean...no! Oh look, I think the door opened a crack..."+q));
        AssignCommand(oWizard, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 3.0));
        CutsceneNext(40.0);
    }
    else if (fTime == 40.0)
    {
        MusicBattlePlay(GetArea(oPC));
        AssignCommand(oRogue, ActionSpeakString(q+"Look, over there! Someone's coming!"+q));
        AssignCommand(oRogue, ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 6.0));
        CutsceneNext(46.0);
    }
    else if (fTime == 46.0)
    {
        AssignCommand(oFighter, ActionSpeakString(q+"Intruders! Time to bash some skulls!"+q));
        AssignCommand(oFighter, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 4.0));
        CutsceneNext(50.0);
    }
    else if (fTime == 50.0)
    {
        CutsceneEnd();
    }
}

// cause an NPC to attack the PC
void GoHostile(object oNPC, object oPC)
{
    ChangeToStandardFaction(oNPC, STANDARD_FACTION_HOSTILE);
    AssignCommand(oNPC, ActionAttack(oPC));
    AssignCommand(oNPC, DetermineCombatRound(oPC));
}

// the three fools attack the player
void end()
{
    object oPC = GetFirstPC();
    object oWizard  = CutsceneGetActor("ks_wizard");
    object oRogue   = CutsceneGetActor("ks_rogue");
    object oFighter = CutsceneGetActor("ks_fighter");

    // the three fools attack the player
    DelayCommand(2.0, GoHostile(oWizard, oPC));
    DelayCommand(2.1, GoHostile(oRogue, oPC));
    DelayCommand(2.2, GoHostile(oFighter, oPC));
    MusicBattlePlay(GetArea(oPC));

    // move the player into the room
    TeleportToWaypoint(oPC, "WP_AR2501_CUT1_END", FALSE);
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
