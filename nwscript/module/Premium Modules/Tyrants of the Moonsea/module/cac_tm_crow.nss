//Kornah's crow delivers note to PC

#include "hf_in_plot"

void main()
{
    if(PlotLevelGet("CrowGivenNote") == 0)
    {
        CreateItemOnObject("handwrittennote", GetPCSpeaker());
        PlotLevelSet("CrowGivenNote", 1);
    }
}
