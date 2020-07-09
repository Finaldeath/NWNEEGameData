//::///////////////////////////////////////////////
//:: con_a2_sweet30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has turned Maries stomache by giving
    her too much Candy.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SWEET");

    if(iPlot >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
