//::///////////////////////////////////////////////
//:: con_a2_sweet20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has learned of Sweet Marie's love of
    Candy.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SWEET");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
