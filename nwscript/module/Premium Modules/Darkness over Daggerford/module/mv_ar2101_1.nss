// this is the cutscene in the drop-off caves where the tanarukk talks to the player

#include "hf_in_cutscene"
#include "hf_in_npc"
#include "hf_in_util"

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    CutsceneStart(FALSE, FALSE, "WP_AR2101_CUT1_START", FALSE);
}

// tanarukk talks to player
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oTanarukk = GetObjectInArea("db_tanarukklead1", oPC);

    if (fTime == 0.0)
    {
        // all the camera to settle down a bit
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // set camera angle
        CutsceneCameraSetup(-1.0, 40.0, 11.0, 50.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // tanarukk notices the player
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_FIRE), oTanarukk);
        AssignCommand(oTanarukk, PlaySound("c_orc_bat1"));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 3.0));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        // tanarukk talks to player
        AssignCommand(oTanarukk, ActionStartConversation(oPC, "", FALSE, FALSE));
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

// just end the scene
void end()
{
    object oPC = GetFirstPC();

    SetLocalInt(oPC, "nTanarukkLeaderInDOCAppeared", 1);
    TeleportToWaypoint(oPC, "WP_AR2101_CUT1_END", FALSE);
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
        // can't abort this scene because there's a script that has to run
        // .. at the end of the dialog. This could be moved inside the
        // .. cutscene, but I'm feeling lazy tonight.
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
