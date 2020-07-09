//::///////////////////////////////////////////////
//:: con_a2_pglgdc0
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Difference between the Default
    Adjustment and the Drink Adjustment is
    less then zero.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iAdjust = GetLocalInt(GetModule(), "POTSC_PEGLEG_DRINK");
    int iReturn = FALSE;

    //The math works out so that he'll get drunk when the DC falls below
    //the player's hit dice.
    if ((30 - iAdjust) < 0)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
