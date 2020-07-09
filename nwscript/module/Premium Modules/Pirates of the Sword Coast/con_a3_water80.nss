//::///////////////////////////////////////////////
//:: con_a3_water80
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has enraged Tasina and is now
    attacking her and her transformed army.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_WATER");

    if(iPlot >= 80)
    {
        return TRUE;
    }

    return FALSE;

}
