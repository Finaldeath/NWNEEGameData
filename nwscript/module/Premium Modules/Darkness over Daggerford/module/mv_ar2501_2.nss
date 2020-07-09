// this is the cutscene in illefarn listening to the ghostly smith

#include "hf_in_cutscene"
#include "hf_in_spawn"
#include "nw_i0_generic"
#include "hf_in_npc"

// spawn the scene actors
void spawnActors(object oPC)
{
    object oWP;
    int nLevels1 = SpawnGetPartyCR(oPC, 20);
    int nLevels2 = SpawnGetPartyCR(oPC, 35);

    // brattal
    oWP = GetWaypointByTag("WP_AR2501_CUT2_BRATTAL");
    object oBrattal = CreateObject(OBJECT_TYPE_CREATURE, "ks_brattal", GetLocation(oWP));
    CutsceneAddActor("ks_brattal", oBrattal);
    SpawnLevelupCreature(oBrattal, nLevels2);

    // guard1
    oWP = GetWaypointByTag("WP_AR2501_CUT2_FIGHTER1");
    object oGuard1 = CreateObject(OBJECT_TYPE_CREATURE, "ks_brattal_gu001", GetLocation(oWP));
    CutsceneAddActor("ks_guard1", oGuard1);
    SpawnLevelupCreature(oGuard1, nLevels1);

    // guard2
    oWP = GetWaypointByTag("WP_AR2501_CUT2_FIGHTER2");
    object oGuard2 = CreateObject(OBJECT_TYPE_CREATURE, "ks_brattal_guard", GetLocation(oWP));
    CutsceneAddActor("ks_guard2", oGuard2);
    SpawnLevelupCreature(oGuard2, nLevels1);
}

// spawn veiti
void SpawnVeiti(object oPC)
{
    // veiti clone (player can't manipulate veiti's equipment so we don't have to copy her)
    object oWP = GetWaypointByTag("WP_AR2501_CUT2_VEITI");
    object oVeiti = CreateObject(OBJECT_TYPE_CREATURE, "db_veiti", GetLocation(oWP), FALSE, "_veiti");
    CutsceneAddActor("ks_veiti", oVeiti);
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    spawnActors(oPC);
    CutsceneStart(TRUE, FALSE, "WP_AR2501_CUT2_START", FALSE);
    CutsceneMusic(TRACK_CRYPT2);
}

// brattal notices the hammering noises
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oBrattal = CutsceneGetActor("ks_brattal");
    object oGuard1  = CutsceneGetActor("ks_guard1");
    object oGuard2  = CutsceneGetActor("ks_guard2");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // allow some time for spawn and camera to settle down
        object oArea = GetArea(oPC);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        CutsceneCameraSetup(-1.0, 130.0, 18.0, 65.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneCameraSetup(-1.0, 130.0,  2.0, 85.0, CAMERA_TRANSITION_TYPE_MEDIUM);
        FadeFromBlack(oPC);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oBrattal, PlaySound("as_cv_smithhamr3"));
        AssignCommand(oBrattal, PlaySound("vs_brattal_001"));
        AssignCommand(oBrattal, ActionSpeakString(q+"By Abbathor’s beard! I swear I heard a smith's hammer! He’s in the wall, I know it!"+q));
        AssignCommand(oBrattal, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 6.0));
        CutsceneNext(11.0);
    }
    else if (fTime == 11.0)
    {
        AssignCommand(oGuard1, PlaySound("vs_mzhent1_001"));
        AssignCommand(oGuard1, ActionSpeakString(q+"It's those damn Ironeaters! I tell ya there's still some hidin' around here!"+q));
        AssignCommand(oGuard1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 7.0));
        CutsceneNext(19.0);
    }
    else if (fTime == 19.0)
    {
        AssignCommand(oGuard1, PlaySound("vs_mzhent1_002"));
        AssignCommand(oGuard1, ActionSpeakString(q+"Uh...no offense...my uh...Lady."+q));
        AssignCommand(oGuard1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 6.0));
        CutsceneNext(23.0);
    }
    else if (fTime == 23.0)
    {
        AssignCommand(oBrattal, PlaySound("vs_brattal_002"));
        AssignCommand(oBrattal, ActionSpeakString(q+"None taken knucklehead! For what they done to me, I hate the Ironeaters as much as you do. But this ain’t no normal dwarf. 'Tis the legendary Ghost Smith!"+q));
        CutsceneNext(30.0);
    }
    else if (fTime == 30.0)
    {
        SpawnVeiti(oPC);
        AssignCommand(oGuard2, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(34.0);
    }
    else if (fTime == 34.0)
    {
        CutsceneNextShot();
    }
}

// veiti and brattal have a little argument
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oBrattal = CutsceneGetActor("ks_brattal");
    object oGuard1  = CutsceneGetActor("ks_guard1");
    object oGuard2  = CutsceneGetActor("ks_guard2");
    object oVeiti   = CutsceneGetActor("ks_veiti");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        AssignCommand(oGuard2, SetFacingPoint(GetPosition(oVeiti)));
        AssignCommand(oGuard2, PlaySound("vs_mzhent1_003"));
        AssignCommand(oGuard2, ActionSpeakString(q+"Uh...who's dat dwarf?"+q));
        AssignCommand(oGuard2, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oBrattal, SetFacingPoint(GetPosition(oVeiti)));
        AssignCommand(oGuard1,  SetFacingPoint(GetPosition(oVeiti)));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        CutsceneCameraSetup(-1.0, 160.0, 1.0, 85.0, CAMERA_TRANSITION_TYPE_MEDIUM);
        AssignCommand(oBrattal, PlaySound("vs_brattal_003"));
        AssignCommand(oBrattal, ActionSpeakString(q+"Oh look, it's my lovely niece Veiti! How sweet."+q));
        AssignCommand(oBrattal, ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        AssignCommand(oVeiti, PlaySound("vs_veiti_075"));
        AssignCommand(oVeiti, ActionSpeakString(q+"Brattal! You disgust me!"+q));
        AssignCommand(oVeiti, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 6.0));
        CutsceneNext(17.0);
    }
    else if (fTime == 17.0)
    {
        AssignCommand(oBrattal, PlaySound("vs_brattal_004"));
        AssignCommand(oBrattal, ActionSpeakString(q+"Now, Veiti, is that any way to treat your dear old aunt?"+q));
        AssignCommand(oBrattal, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 8.0));
        CutsceneNext(23.0);
    }
    else if (fTime == 23.0)
    {
        AssignCommand(oVeiti, PlaySound("vs_veiti_076"));
        AssignCommand(oVeiti, ActionSpeakString(q+"You have no more claim to the Ironeater name than you do to Illefarn!"+q));
        AssignCommand(oVeiti, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 6.0));
        CutsceneNext(29.0);
    }
    else if (fTime == 29.0)
    {
        AssignCommand(oBrattal, PlaySound("vs_brattal_005"));
        AssignCommand(oBrattal, ActionSpeakString(q+"Ah, dearest Veiti, you always were a thick-headed child. Illefarn belongs to me now!"+q));
        AssignCommand(oBrattal, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 8.0));
        CutsceneNext(37.0);
    }
    else if (fTime == 37.0)
    {
        AssignCommand(oVeiti, PlaySound("vs_veiti_077"));
        AssignCommand(oVeiti, ActionSpeakString(q+"You sold yourself to the Zhents and betrayed your own kin! Murderer! Pa will hunt you down!"+q));
        AssignCommand(oVeiti, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 8.0));
        CutsceneNext(45.0);
    }
    else if (fTime == 45.0)
    {
        AssignCommand(oBrattal, PlaySound("vs_brattal_006"));
        AssignCommand(oBrattal, ActionSpeakString(q+"Pfah! 'Tis Derval who's gonna pay for what he did to me, ya hear? He'll pay, starting with his little bairn losing her head!"+q));
        AssignCommand(oBrattal, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 10.0));
        CutsceneNext(57.0);
    }
    else if (fTime == 57.0)
    {
        CutsceneEnd();
    }
}

// cause an NPC to attack the PC
void GoHostile(object oNPC, object oPC)
{
    ChangeToStandardFaction(oNPC, STANDARD_FACTION_HOSTILE);
    DelayCommand(1.0, AssignCommand(oNPC, ActionAttack(oPC)));
    DelayCommand(1.0, AssignCommand(oNPC, DetermineCombatRound(oPC)));
}

// the three fools attack the player
void end()
{
    object oPC = GetFirstPC();
    object oBrattal = CutsceneGetActor("ks_brattal");
    object oGuard1  = CutsceneGetActor("ks_guard1");
    object oGuard2  = CutsceneGetActor("ks_guard2");
    object oVeiti   = CutsceneGetActor("ks_veiti");

    // get rid of veiti's clone
    DestroyObject(oVeiti);

    // everyone attacks the player
    GoHostile(oBrattal, oPC);
    GoHostile(oGuard1, oPC);
    GoHostile(oGuard2, oPC);
    MusicBattlePlay(GetArea(oPC));

    // veiti will now talk about brattal
    SetLocalInt(GetModule(), "nVeitiBrattalLevel", 1);

    // move the player into the room
    TeleportToWaypoint(oPC, "WP_AR2501_CUT2_END", FALSE);
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
