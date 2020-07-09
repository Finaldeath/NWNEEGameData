#include "ddf_util"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;
     //SetLocalInt(GetModule(), "ddf_in_area", AREA_UNUSED_GUARD_POST);
    SetCurrentArea(oPC, AREA_UNUSED_GUARD_POST);
}
