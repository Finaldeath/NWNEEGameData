//::///////////////////////////////////////////////
//:: con_a1_native20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the Player has stumbled across a group of
    Troglodytes drawing a map in the sand?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iTrogPlot = GetLocalInt(GetModule(), "A1_NATIVES");

    if(iTrogPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
