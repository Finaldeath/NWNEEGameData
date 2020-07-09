#include "inc_global"

void main()
{
    object oNextArea = GetObjectByTag("SpindriftWilligansManor");
    SetLocalInt(oNextArea, l_n_A2_WILLIGAN_SUCCESS_CS_START, TRUE);

    SetLocalInt(GetModule(), "A2_WHIPD", 40);

    object oWP = GetWaypointByTag(a2w_Willigan_Success_CS_Start);
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionJumpToObject(oWP));
        oPC = GetNextPC();
    }

}
