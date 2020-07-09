//::///////////////////////////////////////////////
//:: con_a1_native40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the player has read the Troglodyte map,
    but failed to decode the writing?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iTrogPlot = GetLocalInt(GetModule(), "A1_NATIVES");

    if(iTrogPlot >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
