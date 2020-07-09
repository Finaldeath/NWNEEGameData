#include "hf_in_plot"

void main()
{
    PlotLevelSet("Elf", 15);
    SetLocalObject(GetObjectByTag("KTDirector"), "oElf", GetNearestObjectByTag("Elf"));
}
