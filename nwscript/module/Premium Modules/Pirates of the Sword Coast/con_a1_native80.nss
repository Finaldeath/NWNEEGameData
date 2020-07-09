//::///////////////////////////////////////////////
//:: con_a1_native80
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Have you defeated and Killed the Troglodyte
   Champion, Garm?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iTrogPlot = GetLocalInt(GetModule(), "A1_NATIVES");

    if(iTrogPlot >= 80)
    {
        return TRUE;
    }

    return FALSE;

}
