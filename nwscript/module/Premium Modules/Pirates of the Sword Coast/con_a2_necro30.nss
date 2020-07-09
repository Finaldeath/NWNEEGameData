//::///////////////////////////////////////////////
//:: con_a2_necro30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC Gathered a crew and is readyto set
    sail on the Skull and Bones?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_NECRO");

    if(iPlot >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
