// the player opens the feast hall door

#include "hf_in_plot"

void main()
{
    PlotLevelSet("ks_ar2501_feastdoor", 2);
    SetLocked(OBJECT_SELF, FALSE);
    ActionOpenDoor(OBJECT_SELF);
}
