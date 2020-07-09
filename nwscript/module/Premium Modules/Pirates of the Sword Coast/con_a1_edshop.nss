//::///////////////////////////////////////////////
//:: con_a1_edshop
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has heard about the shop.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();
    int iFavor = GetLocalInt(oModule, "cac_a1_edgrim_ww");
    int iResult = FALSE;

    if (iFavor == TRUE)
    {
        iResult == TRUE;
    }

    return iResult;
}
