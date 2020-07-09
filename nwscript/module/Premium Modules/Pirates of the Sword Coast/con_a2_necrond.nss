//::///////////////////////////////////////////////
//:: con_a2_necrond
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the Necromatic ship plot still active?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_NECRO");

    if((iPlot > 0) && (iPlot < 40))
    {
        return TRUE;
    }

    return FALSE;

}
