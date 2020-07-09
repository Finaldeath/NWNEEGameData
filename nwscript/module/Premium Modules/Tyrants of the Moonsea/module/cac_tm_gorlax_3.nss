// jackdaw opens the sewer grates and doors

#include "hf_in_plot"

void main()
{
    PlotLevelSet("Jackdaw", 1);
    PlotLevelSet("Sparrow", 6);

    int n = 1;
    object oGrate = GetNearestObjectByTag("zkep_sewer_grate", OBJECT_SELF, n);
    while (GetIsObjectValid(oGrate))
    {
        SetUseableFlag(oGrate, TRUE);
        oGrate = GetNearestObjectByTag("zkep_sewer_grate", OBJECT_SELF, ++n);
    }

    n = 1;
    object oDoor = GetNearestObjectByTag("zkep_sewer_door", OBJECT_SELF, n);
    while (GetIsObjectValid(oDoor))
    {
        SetLocked(oDoor, FALSE);
        oDoor = GetNearestObjectByTag("zkep_sewer_door", OBJECT_SELF, ++n);
    }
}
