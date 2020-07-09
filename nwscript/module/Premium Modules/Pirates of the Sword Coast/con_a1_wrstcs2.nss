//::///////////////////////////////////////////////
//:: con_a1_wrstcs2
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player knows he need wood and plans,
    and knows where to get each.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iDwarf = GetLocalInt(GetModule(), "A1_DWARF");
    int iTrogPlot = GetLocalInt(GetModule(), "A1_NATIVES");

    if((iTrogPlot == 90) && (iDwarf == 60))
    {
        return TRUE;
    }

    return FALSE;

}
