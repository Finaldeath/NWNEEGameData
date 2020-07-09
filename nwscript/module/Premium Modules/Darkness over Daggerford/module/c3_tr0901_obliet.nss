// player walks near oubliette
// - set the plot level so that feynemonee's dialog appears

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();

    // do nothing if player hasn't found all the fowls yet
    if (PlotLevelGet("ks_druid_gull") < 7)
    {
        return;
    }

    // do nothing if stegil is still alive
    object oStegil = GetNearestObjectByTag("ks_stegil", oPC);
    if (GetIsObjectValid(oStegil))
    {
        if (!GetIsDead(oStegil))
        {
            return;
        }
    }

    // the player can now talk to the oubliette
    PlotLevelSet("ks_oubliette_pl", 1);
    DestroyObject(OBJECT_SELF);
}
