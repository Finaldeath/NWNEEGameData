// after skully is done talking, he opens the portal on the ground floor

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oPortal = GetNearestObjectByTag("ks_pl_devportal", oPC);
    DeleteLocalInt(oPortal, "DISABLED");
    PlotLevelSet("ks_skully", 1);
    DeleteLocalInt(OBJECT_SELF, "HF_DISABLE_AM");
}
