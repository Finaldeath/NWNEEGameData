//::///////////////////////////////////////////////
//:: con_a2_franc40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the player gotten the impression that
    Pete actually stole his ring from francis
    and is still in possetion of it?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_FRANC");

    if(iPlot >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
