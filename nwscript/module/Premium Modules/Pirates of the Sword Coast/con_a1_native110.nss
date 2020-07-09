//::///////////////////////////////////////////////
//:: con_a1_native110
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the player has stolen the sacred wood from the
    Troglodyte camp?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iTrogPlot = GetLocalInt(GetModule(), "A1_NATIVES");

    if(iTrogPlot >= 110)
    {
        return TRUE;
    }

    return FALSE;

}
