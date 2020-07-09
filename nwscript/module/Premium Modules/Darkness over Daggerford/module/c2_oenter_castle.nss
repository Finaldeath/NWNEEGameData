// onEnter script for daggerford castle interior (AR0401)
// .. play cutscenes

#include "hf_in_cutscene"
#include "hf_in_util"

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC))
    {
        // these placed sounds are only activated in the end cutscene
        // .. but they are "on" by default so disable them
        object oMusic1 = GetObjectByTag("ks_snd_throne1");
        SoundObjectStop(oMusic1);
        object oMusic2 = GetObjectByTag("ks_snd_throne2");
        SoundObjectStop(oMusic2);
        object oMusic3 = GetObjectByTag("ks_snd_throne3");
        SoundObjectStop(oMusic3);

        if (GetLocalInt(oPC, "CS_END"))
        {
            // this cutscene ends the game
            SetLocalInt(oPC, "CS_END", 0);
            MusicBackgroundChangeDay(OBJECT_SELF, 0);
            MusicBackgroundChangeNight(OBJECT_SELF, 0);
            CutscenePlay(oPC, "mv_ar0401_1");
            return;
        }
        else if (GetLocalInt(oPC, "CS_MARINER"))
        {
            // plays the cutscene where bugo confronts the player
            SetLocalInt(oPC, "CS_MARINER", 0);
            CutscenePlay(oPC, "mv_ar0401_2");
            return;
        }
        else
        {
            if (GetLocalInt(GetModule(), "pm_endgame_start") == 0)
            {
                // play "generic castle interior" background music
                // .. the area uses "no music" tracks because turning them
                // .. off didn't seem to work very well (?)
                MusicBackgroundChangeDay(OBJECT_SELF, 50);
                MusicBackgroundChangeNight(OBJECT_SELF, 50);

                // there's a little girl here selling books
                object oGirl = GetObjectInArea("ks_golden_girl", OBJECT_SELF);
                if (!GetIsObjectValid(oGirl))
                {
                    object oWP = GetWaypointByTag("WP_AR0401_GOLDEN_GIRL");
                    CreateObject(OBJECT_TYPE_CREATURE, "ks_golden_girl", GetLocation(oWP));
                }
            }
            else
            {
                // the orcs have invaded, so start some creepy music
                MusicBackgroundChangeDay(OBJECT_SELF, 64);
                MusicBackgroundChangeNight(OBJECT_SELF, 64);

                // make sure the little girl selling books is gone
                object oGirl = GetObjectInArea("ks_golden_girl", OBJECT_SELF);
                DestroyObject(oGirl);
            }
        }
    }


}
