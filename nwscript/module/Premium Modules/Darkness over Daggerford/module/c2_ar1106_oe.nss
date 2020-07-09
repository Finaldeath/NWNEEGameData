// onEnter event for AR1106 (library)

#include "hf_in_plot"
#include "hf_in_util"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // skully always follows the player around in the tower
        object oSkully = GetObjectInArea("ks_skully", OBJECT_SELF);
        if (!GetIsObjectValid(oSkully))
        {
            DestroyObject(oSkully);
            object oWP = GetWaypointByTag("WP_AR1106_SKULLY");
            oSkully = CreateObject(OBJECT_TYPE_CREATURE, "ks_skully", GetLocation(oWP));
        }

        int nState = GetLocalInt(OBJECT_SELF, "nState");
        if (nState == 0)
        {
            // create the first batch of ice mephits
            SetLocalInt(OBJECT_SELF, "nState", 1);

            // update the player's journal
            AddJournalQuestEntry("j83", 3, oPC);

            // spawn the portal that we just came thru
            object oWP = GetWaypointByTag("WP_AR1106_PORTAL");
            object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_devportal", GetLocation(oWP));
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_WHITE), oPortal);
            SetLocalString(oPortal, "DESTINATION_DOWN", "WP_AR1105_PORTAL_EXIT");

            // spawn the ice crystal
            oWP = GetWaypointByTag("WP_AR1106_ICE_CRYSTAL");
            CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_icecrystal", GetLocation(oWP));

            // grab the lock on the generator
            object oGenerator = GetObjectInArea("ks_pl_devgenerator", OBJECT_SELF);
            SetLocalInt(oGenerator, "nSemaphore", 1);

            // create the mephits at their waypoints
            int i;
            for (i = 1; i <= 4; i++)
            {
                object oWP = GetWaypointByTag("WP_AR1106_MEPHIT_HOME_" + IntToString(i));
                CreateObject(OBJECT_TYPE_CREATURE, "ks_mephit_ice", GetLocation(oWP));
            }

            // release the lock on the generator
            DelayCommand(10.0, SetLocalInt(oGenerator, "nSemaphore", 0));

            // skully makes a comment
            string sQuote = GetLocalString(GetModule(), "QUOTE");
            DelayCommand(3.0, AssignCommand(oSkully, ActionSpeakString(sQuote+"I think there's an icicle hanging off my chin. Hello? Ever hear of a fireplace Edalseye? C'mon!"+sQuote)));
        }
    }
}
