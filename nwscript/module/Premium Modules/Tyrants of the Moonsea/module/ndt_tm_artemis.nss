// death event for artemis:
// .. after artemis dies, his "random" encounter will no longer function

#include "hf_in_plot"

void main()
{
    // we're all done with this encounter
    PlotLevelSet("ArtemisEntreriEncountered", 1);

    // run the standard death events
    ExecuteScript("x2_def_ondeath", OBJECT_SELF);
}
