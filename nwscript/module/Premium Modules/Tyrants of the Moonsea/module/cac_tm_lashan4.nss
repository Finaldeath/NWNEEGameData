//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_lashan4
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Lashan flees to his house.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "x0_i0_walkway"

#include "hf_in_plot"

void main()
{
    ClearAllActions();
    SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE);
    SetWalkCondition(NW_WALK_FLAG_INITIALIZED,FALSE);
    SetLocalInt(OBJECT_SELF, "HF_EXIT_RUN", 1);
    PlotLevelSet("LashanHome", 1);
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
