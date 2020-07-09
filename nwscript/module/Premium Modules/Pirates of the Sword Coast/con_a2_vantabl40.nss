//::///////////////////////////////////////////////
//:: con_a2_vantabl40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC not gained Vantabular as a
    henchman?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_VANTAB");

    if(iPlot < 40)
    {
        return TRUE;
    }

    return FALSE;

}
