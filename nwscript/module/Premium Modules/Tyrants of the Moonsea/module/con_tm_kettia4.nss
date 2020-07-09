// sidequest: muragh's magnificent machine
// elder water elemental attack

#include "hf_in_plot"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetTag(GetArea(oPC)) == "area093")
    {
        if (PlotLevelGet("ElderWaterElemental") == 2)
        {
            return TRUE;
        }
    }
    return FALSE;
}
