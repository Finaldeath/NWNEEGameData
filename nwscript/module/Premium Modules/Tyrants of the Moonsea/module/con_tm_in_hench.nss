//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_in_hench
//:: DATE: February 20, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchmen Oneliner Interjections
//:: Matches interjection level
//:: Use in conjunction with "ten_tm_hench_int"
//::////////////////////////////////////////////////////

#include "hf_in_plot"

// Used to keep track of the current branch
string LVAR_HENCH_INTERSECT_CURRENT_LVL = "hench_intersect_cnt";

// Both set int ten_tm_hench_int, specify henchman tag and dialog branch
string LVAR_HENCH_INTERSECT_LEVEL = "hench_intersect_lvl";

int StartingConditional()
{
    int nTargetLevel = PlotLevelGet(LVAR_HENCH_INTERSECT_LEVEL);
    int nCurrentLevel = PlotLevelGet(LVAR_HENCH_INTERSECT_CURRENT_LVL);

    if (nTargetLevel == nCurrentLevel)
    {
        // Will select the current dialog branch
        PlotLevelSet(LVAR_HENCH_INTERSECT_CURRENT_LVL, 0);
        return TRUE;
    }
    else
    {
        // Fall through to the next branch
        PlotLevelSet(LVAR_HENCH_INTERSECT_CURRENT_LVL, nCurrentLevel+1);
    }
    return FALSE;
}
