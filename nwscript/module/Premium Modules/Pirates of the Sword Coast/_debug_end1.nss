#include "inc_global"

void main()
{
    SetLocalInt(GetModule(), "A3_WATER", 100);

    object oWP = GetWaypointByTag("A3_FNL_SFSPAWN");
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        AssignCommand(oPC, JumpToObject(oWP));
        oPC = GetNextPC();
    }
}
