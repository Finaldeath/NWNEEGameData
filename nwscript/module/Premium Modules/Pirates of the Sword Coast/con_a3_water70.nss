//::///////////////////////////////////////////////
//:: con_a3_water70
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Tasina has given up the ceremony and desided
    to join the PC, the Umberlant beast (Dweller)
    is now active.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_WATER");

    if(iPlot >= 70)
    {
        return TRUE;
    }

    return FALSE;

}
