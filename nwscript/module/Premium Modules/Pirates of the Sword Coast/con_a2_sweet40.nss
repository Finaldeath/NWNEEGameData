//::///////////////////////////////////////////////
//:: con_a2_sweet40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have found some of Sweet Maries favorite
    flowers. Bring them to her and she will surely
    join your crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SWEET");

    if(iPlot >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
