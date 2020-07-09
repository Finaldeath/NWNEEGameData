#include "hf_in_plot"

void main()
{
    PlotLevelSet("Blizzard", 11);
    SetLocalObject(GetObjectByTag("KTDirector"), "oBlizzard", GetNearestObjectByTag("Blizzard"));
}
