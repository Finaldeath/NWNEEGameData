#include "ddf_util"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;
     //SetLocalInt(GetModule(), "ddf_in_area", AREA_ULANS_WAREHOUSE);
    SetCurrentArea(oPC, AREA_ULANS_WAREHOUSE);
}
