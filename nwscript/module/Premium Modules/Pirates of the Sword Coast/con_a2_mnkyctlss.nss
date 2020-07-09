//::///////////////////////////////////////////////
//:: con_a2_mnkyctlss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC's party ever entered the Monkey's
    Cutless bar in Spindrift Act 2?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iFlag = GetLocalInt(GetModule(), "aen_a2_mnkyctlss");
    int iReturn = FALSE;

    if(iFlag == TRUE)
    {
        iReturn = TRUE;
    }

    return iReturn;

}
