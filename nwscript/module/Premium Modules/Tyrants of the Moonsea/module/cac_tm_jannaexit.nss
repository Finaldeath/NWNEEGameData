//Baerimel and Jannatha leave the stronghold

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oBaerimel = GetNearestObjectByTag("Baerimel", oPC);
    object oJannatha = GetNearestObjectByTag("Jannatha", oPC);

    PlotLevelSet("Baerimel", 3);
    PlotLevelSet("Jannatha", 3);
    PlotLevelSet("HighPriestessSureene", 2);

    ExecuteScript("hf_cs_exit", oJannatha);
    ExecuteScript("hf_cs_exit", oBaerimel);
}
