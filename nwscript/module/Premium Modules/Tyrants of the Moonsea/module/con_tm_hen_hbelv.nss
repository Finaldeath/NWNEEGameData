//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_hen_hbelv
//:: DATE: February 28, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchmen dialog script
//:: Checks for Homebase = Elventree = 20
//:: Set in cut_tm_hillsfar
//:: (Henchmen leave, PC stuck in Hillsfar)
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string PLOT_HENCH_HOME = "hench_home_base";
const string HOMEBASE_AREA_TAGS = "ElventreeSwayingBoughInn";

int IsInHomeArea(object oTarget)
{
    return (FindSubString(HOMEBASE_AREA_TAGS, GetTag(GetArea(oTarget))) >= 0);
}


int StartingConditional()
{
    int nHomeBase = PlotLevelGet(PLOT_HENCH_HOME);

    return (nHomeBase == 20);
}