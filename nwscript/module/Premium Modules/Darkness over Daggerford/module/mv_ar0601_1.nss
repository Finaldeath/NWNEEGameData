// this is the first scene in the game: falias talks to you in the wagon

#include "hf_in_cutscene"
#include "hf_in_util"

// no point setting a camera angle (the convo will change it)
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(FALSE, FALSE, "WP_AR0601_START");
}

// intro dialog with falias
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oFalias = GetObjectInArea("db_falias3", oPC);

    if (fTime == 0.0)
    {
        DeleteLocalInt(oFalias, "NW_GENERIC_MASTER");
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
       CutsceneCameraSetup(1.0, DIRECTION_WEST, 10.0, 60.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC, FADE_SPEED_SLOW);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oPC, ActionStartConversation(oPC, "ks_ar0601_intro", FALSE, FALSE));
        // the "next" event is sent from a script in the dialog
    }
}

// falias leaves the wagon
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oFalias = GetObjectInArea("db_falias3", oPC);
    object oExit = GetWaypointByTag("WP_AR0601_EXIT");

    if (fTime == 0.0)
    {
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        AssignCommand(oFalias, ClearAllActions());
        AssignCommand(oFalias, ActionMoveToObject(oExit, FALSE, 0.0));
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // falias leaves via the door
        object oFalias = GetObjectInArea("db_falias3", oPC);
        DestroyObject(oFalias);

        // levelup the player if needed
        if (GetXP(oPC) < 28000)
        {
            SetXP(oPC, 28001);
        }
        // Talk to the player about rest and level-up options as appropriate
        AssignCommand(oPC, ActionStartConversation(oPC, "ks_ar0601_level", FALSE, FALSE));
    }
}

// just end the scene
void next2(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        CutsceneEnd();
    }
}

void end()
{
    object oPC = GetFirstPC();

    // falias is gone
    object oFalias = GetObjectInArea("db_falias3", oPC);
    DestroyObject(oFalias);

    //Needed to do this in EE version to avoid camera being zoomed in on PC
    AssignCommand(oPC, StoreCameraFacing());

    // in case the player pressed ESC, clear falias' dialog
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));

    // give first journal entry
    AddJournalQuestEntry("j1", 1, oPC);

    AssignCommand(oPC, RestoreCameraFacing());

    // player is leveled-up to 8
    if (GetXP(oPC) < 28000)
    {
        SetXP(oPC, 28001);
    }
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
