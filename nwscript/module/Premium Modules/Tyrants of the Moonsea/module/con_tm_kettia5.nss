// sidequest: muragh's magnificent machine
// elder water elemental attack: player has just defeated the elementals

#include "hf_in_plot"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetTag(GetArea(oPC)) == "area093")
    {
        if (PlotLevelGet("ElderWaterElemental") == 4)
        {
            return TRUE;
        }
    }
    return FALSE;
}
