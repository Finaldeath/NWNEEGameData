//::///////////////////////////////////////////////
//:: con_a2_pglgdcl10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Difference between the Default
    Adjustment and the Drink Adjustment is
    less then ten.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iAdjust = GetLocalInt(GetModule(), "POTSC_PEGLEG_DRINK");
    int iReturn = FALSE;

    if ((17 - iAdjust) < 10)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
