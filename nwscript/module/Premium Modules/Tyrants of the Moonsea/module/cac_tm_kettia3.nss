// sidequest: pirates of the moonsea
// after the player has defeated burak, kettia opens the cabin door so that the player can leave

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet("BuraktheMongrel", 3);
    object oDoor = GetNearestObjectByTag("dt_ship_navicabi", oPC);
    SetLocked(oDoor, FALSE);
}
