#include "ddf_util"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;
     //SetLocalInt(GetModule(), "ddf_in_area", AREA_RUN_DOWN_INN);

    SetCurrentArea(oPC, AREA_RUN_DOWN_INN);
}
