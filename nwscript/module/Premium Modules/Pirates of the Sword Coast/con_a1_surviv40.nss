//::///////////////////////////////////////////////
//:: con_a1_surviv40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    With a readied torch you are ready to take on
    the wilds of this untamed land. While not all
    preditors will flee from your fire, it should
    protect you from the simple creatures dwelling
    here.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A1_SURVIV");

    if(iPlot >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
