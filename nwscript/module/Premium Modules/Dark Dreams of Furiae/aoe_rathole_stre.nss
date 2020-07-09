#include "ddf_util"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;
    SetCurrentArea(oPC, AREA_RATHOLE_STREETS);
    //SetLocalInt(GetModule(), "ddf_in_area", AREA_RATHOLE_STREETS);

}
