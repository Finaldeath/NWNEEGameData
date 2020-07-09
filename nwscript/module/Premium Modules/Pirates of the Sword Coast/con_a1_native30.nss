//::///////////////////////////////////////////////
//:: con_a1_native30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the player has read the map and learned
    that there is a strange cave to the east, and
    a path to a troglodyte encampment on the west
    of the island.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iTrogPlot = GetLocalInt(GetModule(), "A1_NATIVES");

    if(iTrogPlot >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
