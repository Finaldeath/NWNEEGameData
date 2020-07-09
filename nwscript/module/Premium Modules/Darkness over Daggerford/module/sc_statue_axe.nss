// does the player have a stone axe for the statue's hands in illefarn?
// .. also has veiti told the player about the axes?

#include "hf_in_plot"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oAxe = GetItemPossessedBy(oPC, "bw_stoneaxe");
    if (GetIsObjectValid(oAxe))
    {
        if (PlotLevelCheckEquals("ks_ar2501_feastdoor", 1))
        {
            return(TRUE);
        }
    }
    return(FALSE);
}
