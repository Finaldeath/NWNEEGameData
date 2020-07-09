#include "hf_in_plot"

void main()
{
    PlotLevelSet("Blizzard", 10);
    SetLocalObject(GetObjectByTag("KTDirector"), "oBlizzard", GetNearestObjectByTag("Blizzard"));
}
