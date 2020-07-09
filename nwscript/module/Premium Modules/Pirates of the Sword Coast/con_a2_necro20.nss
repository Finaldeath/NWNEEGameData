//::///////////////////////////////////////////////
//:: con_a2_necro20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC Gathered a crew but not told the
    Captian of the Skull and Bones yet?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_NECRO");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
