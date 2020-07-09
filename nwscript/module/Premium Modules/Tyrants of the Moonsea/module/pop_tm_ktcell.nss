#include "hf_in_plot"

void main()
{
    if(GetLocalInt(OBJECT_SELF, "nOpened") == 0)
    {
        PlotLevelSet("Jannatha", 2);
        PlotLevelSet("Baerimel", 2);
        SetLocalInt(OBJECT_SELF, "nOpened", 1);
    }
}
