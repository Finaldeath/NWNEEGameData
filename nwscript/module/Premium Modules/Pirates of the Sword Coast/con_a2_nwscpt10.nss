//::///////////////////////////////////////////////
//:: con_a2_nwscpt10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC learned of the Ceremonial Scepter?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_NWSCPT");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
