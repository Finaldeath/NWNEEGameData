#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    // the doors open
    object oDoors = GetNearestObjectByTag("dt_dig_exit", oPC);
    SetLocked(oDoors, FALSE);
    AssignCommand(oDoors, ActionOpenDoor(oDoors));

    // new plot level
    string sMe = GetTag(OBJECT_SELF);
    PlotLevelSet(sMe, 3);
}
