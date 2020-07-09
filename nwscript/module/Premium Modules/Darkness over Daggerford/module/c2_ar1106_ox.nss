// onExit event for AR1106 - cleanup the area

#include "hf_in_plot"

// destroys all objects with a certain tag in the area
void DestroyAllObjects(string sTag, object oPC)
{
    int i = 1;
    object o = GetNearestObjectByTag(sTag, oPC, i);
    while (GetIsObjectValid(o))
    {
        DestroyObject(o);
        o = GetNearestObjectByTag(sTag, oPC, ++i);
    }
}

void main()
{
    object oPC = GetExitingObject();
    if (GetIsPC(oPC))
    {
        int nState = GetLocalInt(OBJECT_SELF, "nState");
        if (nState == 2)
        {
            // clean up the area
            SetLocalInt(OBJECT_SELF, "nState", 3);
            object oWP = GetWaypointByTag("WP_AR1106_PORTAL");

            // remove the water and snow
            DestroyAllObjects("ks_pl_water", oWP);
            DestroyAllObjects("x0_snowdrift", oWP);

            // remove the ice and fire mephits
            DestroyAllObjects("ks_mephit_ice", oWP);
            DestroyAllObjects("ks_mephit_fire", oWP);

            // remove the flames and ice crystal
            DestroyAllObjects("ks_pl_icecrystal", oWP);
            DestroyAllObjects("ks_pl_devflame", oWP);
            DestroyAllObjects("ks_tr_fire", oWP);
            DestroyAllObjects("ks_pl_devflame", oWP);

            // advance plot of water mephit and generator
            PlotLevelSet("ks_mephit_water", 2);
            PlotLevelSet("ks_pl_devgenerator", 2);

            // remove the generator (not really necessary, but good for performance since it has a heartbeat)
            DestroyAllObjects("ks_pl_devgenerator", oWP);

            // create a few random puddles for effect
            int i = 1;
            object oWP2 = GetNearestObjectByTag("WP_AR1106_PUDDLE", oWP, i);
            while (GetIsObjectValid(oWP2))
            {
                CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_puddle", GetLocation(oWP2));
                oWP2 = GetNearestObjectByTag("WP_AR1106_PUDDLE", oWP, ++i);
            }
        }
    }
}
