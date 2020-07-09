// is griswald's faction hostile to PC?

#include "hf_in_plot"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    // skip this if the drawbridge is already open (or reward given)
    if (PlotLevelGet(GetTag(OBJECT_SELF)) >= 5)
    {
        return(FALSE);
    }

    // see if griswald's faction hates the player
    object oGriswald = GetObjectByTag("ks_griswald");
    if (!GetIsObjectValid(oGriswald))
    {
        oGriswald = GetNearestObjectByTag("ks_gris_knight", oPC);
    }
    return(GetIsEnemy(oPC, oGriswald));
}
