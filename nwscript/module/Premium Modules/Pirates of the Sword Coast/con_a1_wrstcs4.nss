//::///////////////////////////////////////////////
//:: con_a1_wrstcs4
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The trogs are hostile and the PC has the
    Plans
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iDwarf = GetLocalInt(GetModule(), "A1_DWARF");
    int iTrogPlot = GetLocalInt(GetModule(), "A1_NATIVES");

    if((iTrogPlot == 100) && (iDwarf == 80))
    {
        return TRUE;
    }

    return FALSE;

}