// sidequest: pirates of the moonsea
// returns true when burak is still alive and has not been spoken with

#include "hf_in_plot"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetTag(GetArea(oPC)) == "area094")
    {
        object oBurak = GetNearestObjectByTag("BuraktheMongrel", oPC);
        if (GetIsObjectValid(oBurak))
        {
            if (!GetIsDead(oBurak))
            {
                if (PlotLevelGet("BuraktheMongrel") <= 1)
                {
                    return TRUE;
                }
            }
        }
    }
    return FALSE;
}
