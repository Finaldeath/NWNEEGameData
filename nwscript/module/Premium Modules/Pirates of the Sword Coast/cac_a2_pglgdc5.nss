//::///////////////////////////////////////////////
//:: cac_a2_pglgdc5
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Adjust the DC of Pegleg's flirt check by
    five.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

void main()
{
    int iAdjust = GetLocalInt(GetModule(), "POTSC_PEGLEG_DRINK");
    iAdjust = iAdjust+5;

    SetLocalInt(GetModule(), "POTSC_PEGLEG_DRINK", iAdjust);
}