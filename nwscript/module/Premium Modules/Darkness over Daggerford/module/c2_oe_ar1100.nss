// onEnter event for AR1100
// .. spawn bandit raiders into camp
// .. plays the cutscene where Edalseye zaps Deldarine

#include "hf_in_cutscene"
#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(GetModule(), "teygan_quests") == 1)
        {
            if (GetLocalInt(GetModule(), "nSpawnedTeyganBandits") == 0)
            {
                SetLocalInt(GetModule(), "nSpawnedTeyganBandits", 1);

                // destroy the "this camp is deserted" floating text popup
                object oTrigger = GetObjectByTag("TR_AR1100_BANDIT_CAMP");
                DestroyObject(oTrigger);

                // spawn some bandits and griffons
                int i = 0;
                object oWP = GetObjectByTag("WP_AR1100_BANDIT", i);
                while (GetIsObjectValid(oWP))
                {
                    CreateObject(OBJECT_TYPE_CREATURE, "ks_bandbarrens_1", GetLocation(oWP), FALSE, "_ar1100_bandit");
                    oWP = GetObjectByTag("WP_AR1100_BANDIT", ++i);
                }

                // spawn some giffons
                i = 0;
                oWP = GetObjectByTag("WP_AR1100_GRIFFON", i);
                while (GetIsObjectValid(oWP))
                {
                    CreateObject(OBJECT_TYPE_CREATURE, "ks_griffon", GetLocation(oWP), FALSE, "_ar1100_bandit");
                    oWP = GetObjectByTag("WP_AR1100_GRIFFON", ++i);
                }
            }
        }

        // spawn deldarine if the quest was given
        if (PlotLevelGet("ks_deldarine") >= 1)
        {
            if (GetLocalInt(OBJECT_SELF, "nDeldarineCreated") == 0)
            {
                SetLocalInt(OBJECT_SELF, "nDeldarineCreated", 1);
                object oWP = GetWaypointByTag("WP_AR1100_DELDARINE");
                object oDeldarine = GetObjectByTag("ks_deldarine");
                DestroyObject(oDeldarine);
                CreateObject(OBJECT_TYPE_CREATURE, "ks_deldarine", GetLocation(oWP));
            }
        }

        // play edalseye's cutscene
        if (GetLocalInt(oPC, "nPlayCutscene") != 0)
        {
            DeleteLocalInt(oPC, "nPlayCutscene");
            CutscenePlay(oPC, "mv_ar1100_1");
        }
    }
}
