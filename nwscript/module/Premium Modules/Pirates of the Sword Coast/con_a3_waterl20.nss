//::///////////////////////////////////////////////
//:: con_a2_waterl20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has Allendry NOT told the Rime of the Ancient
    Mariner
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_WATER");

    if(iPlot < 20)
    {
        return TRUE;
    }

    return FALSE;

}
