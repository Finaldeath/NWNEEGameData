//::///////////////////////////////////////////////
//:: cac_a2_pglgdc2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Adjust the DC of Pegleg's flirt check by
    two.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

void main()
{
    int iAdjust = GetLocalInt(GetModule(), "POTSC_PEGLEG_DRINK");
    iAdjust = iAdjust+2;

    SetLocalInt(GetModule(), "POTSC_PEGLEG_DRINK", iAdjust);
}
