// this is the cutscene where teygan talks to the player in liam's hold

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "hf_in_util"

// remove invis effect
void RemoveEffects(object oTarget)
{
    effect e = GetFirstEffect(oTarget);
    while (GetIsEffectValid(e))
    {
        RemoveEffect(oTarget, e);
        e = GetNextEffect(oTarget);
    }
}

// spawn the NPCs
void spawnNPCs(object oPC)
{
    // grab a handle on Teygan
    object oTeygan = GetObjectInArea("Teygan", oPC);
    if (!GetIsObjectValid(oTeygan))
    {
        location lTeygan = GetLocation(GetWaypointByTag("teygan_spwn_lh"));
        oTeygan = CreateObject(OBJECT_TYPE_CREATURE, "sememmon001", lTeygan);
    }
    CutsceneAddActor("Teygan", oTeygan);
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(FALSE, FALSE, "WP_AR1300_CUT1_START", FALSE);
    CutsceneMusic(TRACK_THEME_MAUGRIM);
    spawnNPCs(oPC);
}

// teygan talks to the player
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oTeygan = CutsceneGetActor("Teygan");

    if (fTime == 0.0)
    {
        // some time for the camera to settle down
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // position the camera
        CutsceneCameraSetup(-1.0, 100.0, 2.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // tegan talks to the player
        AssignCommand(oTeygan, ActionStartConversation(oPC, "", FALSE, FALSE));
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

// teygan runs away
void end()
{
    object oPC = GetFirstPC();
    object oTeygan = CutsceneGetActor("Teygan");

    AddJournalQuestEntry("j6", 1, oPC);

    // teygan leaves
    SetLocalInt(GetModule(), "teygan_start", 2);
    ExecuteScript("hf_cs_exit", oTeygan);

    // this is when yani pavani "finds" the player's special item
    PlotLevelSet("ks_yani", 3);
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
