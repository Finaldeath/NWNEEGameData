//::///////////////////////////////////////////////
//:: con_a3_water60
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has agreed to the dragons demands
    and has gained access to the temple. The
    PC must fight his way to the inner sanctem.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_WATER");

    if(iPlot >= 60)
    {
        return TRUE;
    }

    return FALSE;

}
