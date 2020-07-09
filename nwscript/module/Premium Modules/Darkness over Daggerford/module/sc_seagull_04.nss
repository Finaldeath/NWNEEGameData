// has stegil asked player to kill tatham?

#include "hf_in_plot"

int StartingConditional()
{
    // stegil's plot will be >= 1 if he offered
    if (PlotLevelGet("ks_stegil") < 1)
    {
        return(FALSE);
    }

    // stegil must be alive
    object oStegil = GetObjectByTag("ks_stegil");
    if (!GetIsObjectValid(oStegil))
    {
        return(FALSE);
    }
    if (GetIsDead(oStegil))
    {
        return(FALSE);
    }

    return(TRUE);
}
