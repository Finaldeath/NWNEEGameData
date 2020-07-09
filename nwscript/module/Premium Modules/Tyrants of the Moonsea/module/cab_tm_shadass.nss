//Signal Shadovar assassins to attack PC
#include "hf_in_plot"
#include "inc_ktgate"

void main()
{
    if(PlotLevelGet(GetTag(OBJECT_SELF)) == 6)
    {
        SignalAssassinEvent(4703);
    }
}
