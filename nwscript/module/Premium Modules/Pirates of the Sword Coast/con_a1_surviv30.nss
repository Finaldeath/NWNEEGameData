//::///////////////////////////////////////////////
//:: con_a1_surviv30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You finally have a Fire, if only you could
    bring it with you where ever you travel.

    If you could put together a make shift torch
    if would be a lot easier to safely explore
    the island.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A1_SURVIV");

    if(iPlot >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
