#include "ddf_util"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;
    // SetLocalInt(GetModule(), "ddf_in_area", AREA_NORTH_MARKET);

    SetCurrentArea(oPC,  AREA_NORTH_MARKET);
}
