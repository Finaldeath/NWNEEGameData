//::///////////////////////////////////////////////
//:: con_a1_native70
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Have you defeated the Troglodyte Champion and
    gained him as your sworn servant.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iTrogPlot = GetLocalInt(GetModule(), "A1_NATIVES");

    if(iTrogPlot >= 70)
    {
        return TRUE;
    }

    return FALSE;

}
