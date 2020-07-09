//::///////////////////////////////////////////////
//:: con_a2_spndrf50
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have received the Robe and learned that
    a secondary entrance to the temple is hidden
    somewhere in the sewers.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SPNDRF");

    if(iPlot >= 50)
    {
        return TRUE;
    }

    return FALSE;
}
