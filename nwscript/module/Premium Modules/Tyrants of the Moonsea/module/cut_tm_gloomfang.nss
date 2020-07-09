//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_gloomfang
// DATE: November 1, 2005
// AUTH: Luke Scull/Rich Barker
// NOTE: Cutscene and dialogue with Gloomfang.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "hf_in_cutscene"
#include "nw_i0_generic"

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(FALSE, FALSE, "WP_Gloomfang_Cut_Start", TRUE);
}

// Gloomfang appears and talks to player
void next0(float fTime)
{
    object oGloomfang;
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        // some time for the camera to settle down
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // position the camera
        CutsceneCameraSetup(-1.0, 0.0, 9.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        object oTarget = GetWaypointByTag("WP_Gloomfang_Spawn");
        location lTarget = GetLocation(oTarget);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), oPC, 2.0);

        AssignCommand(oPC, PlaySound("c_dragnold_bat1"));

        oGloomfang = CreateObject(OBJECT_TYPE_CREATURE, "gloomfang", lTarget);
        CutsceneAddActor("Gloomfang", oGloomfang);
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        //CutsceneNextShot() invoked from Gloomfang conversation
        oGloomfang = CutsceneGetActor("Gloomfang");
        AssignCommand(oGloomfang, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// just end the scene
void next1(float fTime)
{
    if (fTime == 0.0)
    {
        CutsceneEnd();
    }
}

void end()
{
    object oPC = GetFirstPC();
    object oGloomfang = CutsceneGetActor("Gloomfang");

    //Gloomfang attacks
    DelayCommand(4.0, ChangeToStandardFaction(oGloomfang, STANDARD_FACTION_HOSTILE));
    DelayCommand(4.1, AssignCommand(oGloomfang, DetermineCombatRound(oPC)));
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
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
