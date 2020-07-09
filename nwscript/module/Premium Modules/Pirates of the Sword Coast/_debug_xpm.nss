#include "inc_global"

void main()
{
    object oArea = GetObjectByTag("SpindriftMayorsOffice");
    SetLocalInt(oArea, l_n_XPM_START_CS_ON_AEN, TRUE);
    object oWPPC1 = GetObjectByTagInArea("WP_PC_Jump_From_Parlor", oArea);
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        AssignCommand(oPC, JumpToObject(oWPPC1));
        oPC = GetNextPC();
    }

}
