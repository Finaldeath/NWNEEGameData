//::///////////////////////////////////////////////
//:: con_a2_vantab40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC gained Vantabular as a henchman?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iPlot = GetLocalInt(oModule, "A2_VANTAB");

    if(iPlot >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
