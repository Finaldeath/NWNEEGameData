//::///////////////////////////////////////////////
//:: con_a1_surviv20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have found a safe place to rest, all you
    need is a fire to keep away the preditors of
    the island as night falls.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A1_SURVIV");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
