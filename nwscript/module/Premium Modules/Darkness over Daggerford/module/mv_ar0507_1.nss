// this is the cutscene where barrow talks to the player in daggerford

#include "hf_in_cutscene"
#include "hf_in_spawn"

// spawn the scene actors
void spawnNPCs(object oPC)
{
    object oWP;
    int nLevels = SpawnGetPartyCR(oPC, 50);

    oWP = GetWaypointByTag("WP_AR0507_CUT1_BARROW");
    object oBarrow = CreateObject(OBJECT_TYPE_CREATURE, "ac_barrow", GetLocation(oWP));
    SpawnLevelupCreature(oBarrow, nLevels);
    CutsceneAddActor("ac_barrow", oBarrow);

    oWP = GetWaypointByTag("WP_AR0507_CUT1_PARKER");
    object oParker = CreateObject(OBJECT_TYPE_CREATURE, "ac_parker", GetLocation(oWP));
    SpawnLevelupCreature(oParker, nLevels);
    CutsceneAddActor("ac_parker", oParker);
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE, "WP_AR0507_CUT1_START");
    CutsceneMusic(TRACK_CITYNIGHT);
    spawnNPCs(oPC);
}

// the dwarves are sitting around drinking
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oBarrow = CutsceneGetActor("ac_barrow");
    object oParker = CutsceneGetActor("ac_parker");
    string q       = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // some time for the camera to settle down
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        // position the camera
        CutsceneCameraSetup(-1.0, 350.0, 4.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneCameraSetup(-1.0, 350.0, 2.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // rogues are looting
        AssignCommand(oParker, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 6.0));
        AssignCommand(oBarrow, ActionSpeakString(q+"Mmm. The owner of this fine dwelling has an excellent wine cellar!"+q));
        AssignCommand(oBarrow, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        AssignCommand(oParker, ActionSpeakString(q+"Blast! Why can't these nobles ever have any good loot?"+q));
        AssignCommand(oParker, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED));
        CutsceneNext(18.0);
    }
    else if (fTime == 18.0)
    {
        // barrow confronts the player
        AssignCommand(oParker, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oBarrow, ActionStartConversation(oPC, "", FALSE, FALSE));
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

// the NPCs go hostile
void end()
{
    object oPC = GetFirstPC();
    object oBarrow = CutsceneGetActor("ac_barrow");
    object oParker = CutsceneGetActor("ac_parker");

    // NPCs go hostile
    DelayCommand(4.0, AttackPlayer(oPC, oBarrow));
    DelayCommand(4.0, AttackPlayer(oPC, oParker));
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
