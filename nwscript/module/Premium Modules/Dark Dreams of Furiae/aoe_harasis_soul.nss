#include "ddf_util"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;
    //SetLocalInt(GetModule(), "ddf_in_area", AREA_HARASIS_SOUL_TRADE_APARTMENT);
    SetCurrentArea(oPC, AREA_HARASIS_SOUL_TRADE_APARTMENT);
}
