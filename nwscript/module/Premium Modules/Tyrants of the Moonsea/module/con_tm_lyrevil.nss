//Is Lyressa a current henchman and evil?

#include "hf_in_henchman"
#include "hf_in_plot"

int StartingConditional()
{
    object oLyressa = GetObjectByTag("Lyressa");

    if(HenchmanIsMine(oLyressa, GetPCSpeaker()) && PlotLevelGet("Dragoth") == 6)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
