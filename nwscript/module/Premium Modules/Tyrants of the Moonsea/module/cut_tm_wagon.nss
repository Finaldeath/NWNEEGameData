// this is the first scene in the game: madoc talks to you outside the wagon

#include "hf_in_cutscene"
#include "hf_in_util"
#include "hf_in_plot"

const string MADOC_NPC_TAG = "MadoctheUncouth";
const string MADOC_WP_FIRESIDE = "WP_VNRD_MADOC_FIRE";

// no point setting a camera angle (the convo will change it)
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(FALSE, FALSE, "WP_VNRD_START");
}

// intro dialog with madoc
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oMadoc = GetObjectInArea(MADOC_NPC_TAG, oPC);

    if (fTime == 0.0)
    {
        DeleteLocalInt(oMadoc, "NW_GENERIC_MASTER");
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_EAST, 10.0, 60.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC, FADE_SPEED_SLOW);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oMadoc, ActionStartConversation(oPC, "tm_madoc", FALSE, FALSE));
        // the "next" event is sent from a script in the dialog
    }
}

// madoc walks towards the fire
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oMadoc = GetObjectInArea(MADOC_NPC_TAG, oPC);
    object oExit = GetObjectInArea(MADOC_WP_FIRESIDE, oPC);

    if (fTime == 0.0)
    {
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        AssignCommand(oMadoc, ClearAllActions());
        AssignCommand(oMadoc, ActionMoveToObject(oExit, FALSE, 0.0));
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // players below level 12 are advanced to level 15
        if (GetXP(oPC) <= 66000)
        {
            SetXP(oPC, 105000);
        }

        // Talk to the player about rest and level-up options as appropriate
        AssignCommand(oPC, ActionStartConversation(oPC, "tm_wagon_level", FALSE, FALSE));
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

// enforce post-conditions
void end()
{
    object oPC = GetFirstPC();

    // madoc is walking towards the fire
    object oMadoc = GetObjectInArea(MADOC_NPC_TAG, oPC);
    object oExit = GetObjectInArea(MADOC_WP_FIRESIDE, oPC);
    AssignCommand(oMadoc, ActionMoveToObject(oExit, FALSE, 0.0));
    object oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oMadoc);
    AssignCommand(oMadoc, ActionUnequipItem(oTorch));
    AssignCommand(oMadoc, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 1000.0));

    // avoid camera being zoomed in on PC
    AssignCommand(oPC, StoreCameraFacing());

    // in case the player pressed ESC, clear madoc's dialog
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
    AssignCommand(oPC, RestoreCameraFacing());

    // advance the plot
    PlotLevelSet(MADOC_NPC_TAG, 3);

    // players below level 12 are advanced to level 15
    if (GetXP(oPC) <= 66000)
    {
        SetXP(oPC, 105000);
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
