// player has poked a hole in one of the guords in the crafter's hut
// .. after four guords are punctured, water fills the hut and the
// .. crafter leaves in disgust

#include "hf_in_plot"

void main()
{
    // this guord can no longer be punctured
    string sTag = GetTag(OBJECT_SELF);
    PlotLevelSet(sTag, 1);

    // increment the number of leaky guords in this area
    object oArea = GetArea(OBJECT_SELF);
    int n = GetLocalInt(oArea, "nLeakyGuords");
    SetLocalInt(oArea, "nLeakyGuords", ++n);

    // play water sound effect (the area enter event will also play the sound)
    if (n == 1)
    {
        object oSnd = GetNearestObjectByTag("ks_snd_guordleak", OBJECT_SELF);
        SoundObjectPlay(oSnd);
    }

    if (n == 4)
    {
        // water fills the hut
        object oWP = GetWaypointByTag("WP_AR1904_WATER");
        vector vPos = GetPosition(oWP);
        vPos.z = -0.75;
        location lLoc = Location(oArea, vPos, 0.0);
        CreateObject(OBJECT_TYPE_PLACEABLE, "am_bluewater2x2", lLoc);
        SetLocalInt(GetArea(oWP), "nWater", 1);

        // all creatures in the area get watery footsteps
        int i = 1;
        object o = GetNearestObject(OBJECT_TYPE_CREATURE, oWP, i);
        while (GetIsObjectValid(o))
        {
            if (GetFootstepType(o) == FOOTSTEP_TYPE_LARGE)
            {
                SetFootstepType(16, o);
            }
            else
            {
                SetFootstepType(15, o);
            }
            o = GetNearestObject(OBJECT_TYPE_CREATURE, oWP, ++i);
        }

        // the crafter leaves in disgust
        object oLizard = GetNearestObjectByTag("lizcrafter", OBJECT_SELF);
        if (GetIsObjectValid(oLizard))
        {
            AssignCommand(oLizard, ClearAllActions());
            AssignCommand(oLizard, PlaySound("c_lizardm_bat1"));
            AssignCommand(oLizard, ActionSpeakString("*hiss*"));
            AssignCommand(oLizard, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
            SetLocalString(oLizard, "HF_EXIT_NAME", "WP_AR1904_ENTER");
            SetLocalInt(oLizard, "HF_EXIT_MAX_DELAY", 10);
            SetLocalInt(oLizard, "HF_EXIT_RUN", 1);
            DelayCommand(1.0, ExecuteScript("hf_cs_exit", oLizard));
        }
    }
}
