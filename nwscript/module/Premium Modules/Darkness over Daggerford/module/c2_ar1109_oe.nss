// player has entered AR1109

#include "hf_in_cutscene"
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
            object oWP = GetWaypointByTag("WP_AR1109_SKULLY");
            oSkully = CreateObject(OBJECT_TYPE_CREATURE, "ks_skully", GetLocation(oWP));
        }

        int nState = GetLocalInt(OBJECT_SELF, "nState");
        if (nState == 0)
        {
            // setup the exit portal (up to bedroom)
            object oWP = GetWaypointByTag("WP_AR1109_PORTAL");
            object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_devportal", GetLocation(oWP));
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_WHITE), oPortal);
            SetLocalString(oPortal, "DESTINATION_UP", "WP_AR1108_PORTAL2_EXIT");

            // skully floats over to the planar gate
            object oDest = GetWaypointByTag("WP_AR1109_GATE");
            AssignCommand(oSkully, ActionMoveToObject(oDest));

            // advance to the next state for this area
            SetLocalInt(OBJECT_SELF, "nState", 1);
            PlotLevelSet("ks_skully", 1);
        }
        else if (nState == 1)
        {
            int nPlotLevel = PlotLevelGet("ks_edalseye");
            object oEdalseye = GetObjectByTag("ks_edalseye");
            if ((nPlotLevel >= 2) ||
                (nPlotLevel == 1 && GetIsDead(oEdalseye)))
            {
                // player has returned from hell. play the cutscene
                SetLocalInt(OBJECT_SELF, "nState", 2);
                CutscenePlay(oPC, "mv_ar1109_1");
            }
        }
    }
}
