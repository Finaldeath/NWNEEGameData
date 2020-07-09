//::///////////////////////////////////////////////
//:: con_a1_native90
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the King of the Troglodyte army is commanded
    the player to kill Edgrimm?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iTrogPlot = GetLocalInt(GetModule(), "A1_NATIVES");

    if(iTrogPlot >= 90)
    {
        return TRUE;
    }

    return FALSE;

}
