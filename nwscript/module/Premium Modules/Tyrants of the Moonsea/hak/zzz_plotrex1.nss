#include "hf_in_plot"

void main()
{
    PlotLevelSet("TheWrecker", 1);
     SetLocalObject(GetObjectByTag("KTDirector"), "oWrecker", GetNearestObjectByTag("TheWrecker"));
}
