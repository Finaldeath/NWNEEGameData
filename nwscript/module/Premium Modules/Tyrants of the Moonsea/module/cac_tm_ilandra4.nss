// priates of the moonsea
// player took ilandra's ring, talked to dryden, and now talked to ilandra

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("item030", oPC); // arrow of slaying (outsider)
    PlotLevelSet("IlandraPirate", 5);
    PlotLevelSet("Blizzard", 9); // Blizzard now available for further conversation

}
