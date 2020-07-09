//::///////////////////////////////////////////////
//:: con_a1_native100
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the player has returned the Dwarfs Head to
    the Troglodyte King?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iTrogPlot = GetLocalInt(GetModule(), "A1_NATIVES");

    if(iTrogPlot >= 100)
    {
        return TRUE;
    }

    return FALSE;

}
