// this is the cutscene where karragh talks to the player in daggerford

#include "hf_in_cutscene"
#include "hf_in_spawn"
#include "hf_in_npc"

// spawn the scene actors
void spawnNPCs(object oPC)
{
    object oWP;
    int nLevels = SpawnGetPartyCR(oPC, 25);

    oWP = GetWaypointByTag("WP_AR0506_CUT1_KARRAGH");
    object oKarragh = CreateObject(OBJECT_TYPE_CREATURE, "ac_karragh", GetLocation(oWP));
    CutsceneAddActor("ac_karragh", oKarragh);
    SpawnLevelupCreature(oKarragh, SpawnGetPartyCR(oPC, 50));

    oWP = GetWaypointByTag("WP_AR0506_CUT1_DWARF1");
    object oDwarf1 = CreateObject(OBJECT_TYPE_CREATURE, "ac_karraghrogue", GetLocation(oWP));
    CutsceneAddActor("ac_dwarf1", oDwarf1);
    SpawnLevelupCreature(oDwarf1, nLevels);

    oWP = GetWaypointByTag("WP_AR0506_CUT1_DWARF2");
    object oDwarf2 = CreateObject(OBJECT_TYPE_CREATURE, "ac_karraghrogue2", GetLocation(oWP));
    CutsceneAddActor("ac_dwarf2", oDwarf2);
    SpawnLevelupCreature(oDwarf2, nLevels);

    oWP = GetWaypointByTag("WP_AR0506_CUT1_DWARF3");
    object oDwarf3 = CreateObject(OBJECT_TYPE_CREATURE, "ac_karraghrogue3", GetLocation(oWP));
    CutsceneAddActor("ac_dwarf3", oDwarf3);
    SpawnLevelupCreature(oDwarf3, nLevels);
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE, "WP_AR0506_CUT1_START");
    CutsceneMusic(TRACK_BATTLE_CITY2);
    spawnNPCs(oPC);
}

// the dwarves are sitting around drinking
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oKarragh = CutsceneGetActor("ac_karragh");
    object oDwarf1  = CutsceneGetActor("ac_dwarf1");
    object oDwarf2  = CutsceneGetActor("ac_dwarf2");
    object oDwarf3  = CutsceneGetActor("ac_dwarf3");
    string q        = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // some time for the camera to settle down
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // position the camera
        CutsceneCameraSetup(-1.0, 235.0, 3.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneCameraSetup(-1.0, 225.0, 2.0, 80.0, CAMERA_TRANSITION_TYPE_SLOW);
        FadeFromBlack(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // dwarves are drinking
        AssignCommand(oKarragh, PlaySound("as_pl_belchingm1"));
        AssignCommand(oKarragh, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        AssignCommand(oDwarf1, PlaySound("as_pl_tavlaughm2"));
        AssignCommand(oDwarf1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 4.0));
        AssignCommand(oDwarf2, PlaySound("as_pl_tavarguem2"));
        AssignCommand(oDwarf2, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        AssignCommand(oDwarf3, PlaySound("as_pl_tavdrunkm4"));
        AssignCommand(oDwarf3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 5.0));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        // karragh hears the player
        AssignCommand(oKarragh, ActionSpeakString(q+"Eh? Who's at da door?"+q));
        AssignCommand(oKarragh, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        AssignCommand(oDwarf2, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        // karragh confronts the player
        AssignCommand(oDwarf1, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oDwarf2, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oDwarf3, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oKarragh, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// just end the scene
void next1(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        CutsceneEnd();
    }
}

// make a creature attack the player
void AttackPlayer(object oPC, object oNPC)
{
    ChangeToStandardFaction(oNPC, STANDARD_FACTION_HOSTILE);
    AssignCommand(oNPC, ActionAttack(oPC));
}

// the four dwarves go hostile
void end()
{
    object oPC = GetFirstPC();
    object oKarragh = CutsceneGetActor("ac_karragh");
    object oDwarf1  = CutsceneGetActor("ac_dwarf1");
    object oDwarf2  = CutsceneGetActor("ac_dwarf2");
    object oDwarf3  = CutsceneGetActor("ac_dwarf3");

    // karragh and friends go hostile
    DelayCommand(4.5, AttackPlayer(oPC, oKarragh));
    DelayCommand(4.5, AttackPlayer(oPC, oDwarf1));
    DelayCommand(4.5, AttackPlayer(oPC, oDwarf2));
    DelayCommand(4.5, AttackPlayer(oPC, oDwarf3));
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
