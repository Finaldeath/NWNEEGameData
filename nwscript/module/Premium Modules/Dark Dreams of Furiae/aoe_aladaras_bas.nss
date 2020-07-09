#include "ddf_util"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;
     //SetLocalInt(GetModule(), "ddf_in_area", AREA_ALADARAS_BASEMENT);
    SetCurrentArea(oPC, AREA_ALADARAS_BASEMENT);
}
