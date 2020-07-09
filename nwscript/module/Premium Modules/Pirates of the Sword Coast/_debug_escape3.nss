#include "inc_global"

void main()
{
    object oArea = GetObjectByTag("a1_escapepoint");
    SetLocalString(oArea, "ESCAPE", "cut_a1_escapec");
    SetLocalObject(oArea, "A1_ECSPC", GetFirstPC());
    object oWPPC1 = GetObjectByTagInArea("A1CUT_PC1", oArea);
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        AssignCommand(oPC, JumpToObject(oWPPC1));
        oPC = GetNextPC();
    }
}
