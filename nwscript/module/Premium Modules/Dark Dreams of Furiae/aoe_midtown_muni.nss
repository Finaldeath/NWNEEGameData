#include "ddf_util"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;
     //SetLocalInt(GetModule(), "ddf_in_area", AREA_MIDTOWN_MUNICIPAL_DISTRICT);
    SetCurrentArea(oPC,  AREA_MIDTOWN_MUNICIPAL_DISTRICT);
}