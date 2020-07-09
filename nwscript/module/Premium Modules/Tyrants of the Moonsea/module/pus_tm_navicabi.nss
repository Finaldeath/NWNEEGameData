// player used the ship map in the navicabi, so show the world map

#include "inc_navicabi"
#include "hf_in_plot"

void main()
{
    object oPC = GetLastUsedBy();
    if (GetIsPC(oPC))
    {
        NaviCabiShowMap(oPC, "WP_NAVI_PLAYER");
    }
}
