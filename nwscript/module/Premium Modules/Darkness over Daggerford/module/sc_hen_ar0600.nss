#include "hf_in_plot"

int StartingConditional()
{
    string sPlot = GetTag(OBJECT_SELF);
    if (PlotLevelCheckEquals(sPlot, 0))
    {
        object oArea = GetArea(OBJECT_SELF);
        string sTag = GetTag(oArea);
        return(sTag == "C1AR0099TradeWayNorth");
    }
    return(FALSE);
}
