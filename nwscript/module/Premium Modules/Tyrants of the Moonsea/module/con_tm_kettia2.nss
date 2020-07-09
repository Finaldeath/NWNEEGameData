// pirates of the moonsea:
// kettia is telling the player to speak with Meldonder on the other ship

#include "hf_in_plot"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    if (GetTag(oArea) == "MelNavy")
    {
        if (PlotLevelGet("AdmiralMeldonder") < 2)
        {
            object oAdmiral = GetNearestObjectByTag("AdmiralMeldonder");
            if (GetIsObjectValid(oAdmiral))
            {
                float fDist = GetDistanceBetween(oPC, oAdmiral);
                return (fDist > 10.0f);
            }
        }
    }

    return FALSE;
}
