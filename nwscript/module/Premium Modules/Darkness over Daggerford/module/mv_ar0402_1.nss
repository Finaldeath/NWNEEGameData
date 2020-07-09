// cutscene of player teleporting into castle basement

#include "hf_in_cutscene"
#include "hf_in_graphics"

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE);
}

// player teleports into area
void next0(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        // give some time for the area to load
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        // play a creepy sound while we wait
        AssignCommand(oPC, PlaySound("as_wt_gustdraft1"));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // show the place where the player will appear
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 5.0,  55.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 10.0, 55.0, CAMERA_TRANSITION_TYPE_FAST);
        FadeFromBlack(oPC, FADE_SPEED_FAST);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        // display teleport VFX
        DrawCircle(GetLocation(oPC), 3.0, VFX_IMP_MAGIC_PROTECTION);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3), oPC);
        RemoveAssociateEffects(oPC);
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 10.0));
        CutsceneNext(11.0);
    }
    else if (fTime == 11.0)
    {
        CutsceneEnd();
    }
}

// nothing
void end()
{
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
