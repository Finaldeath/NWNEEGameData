#include "ddf_util"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;
     //SetLocalInt(GetModule(), "ddf_in_area", AREA_FORVORS_SHOP);
    SetCurrentArea(oPC, AREA_FORVORS_SHOP);
}
