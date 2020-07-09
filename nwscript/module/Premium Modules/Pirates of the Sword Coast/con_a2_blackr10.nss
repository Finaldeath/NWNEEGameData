//::///////////////////////////////////////////////
//:: con_a2_blackr10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Have you learned about the heist and which
    items are still outstanding from the collection?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_BLACKR");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
