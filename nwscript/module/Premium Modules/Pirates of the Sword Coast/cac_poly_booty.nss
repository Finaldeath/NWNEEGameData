//:://////////////////////////////////////////////
//:: cac_poly_booty
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set the custom token for the current amount
    of booty purchased.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    int iBootyCount = GetLocalInt(oModule, "POTSC_BOOTYCOUNT");

    // 16 possable purchasable booty items.
    SetCustomToken(1504, IntToString(iBootyCount));
}
