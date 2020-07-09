//:://////////////////////////////////////////////
//:: cac_poly_srvv
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set the custom token for the current amount
    of Survival items Collected.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    int iCounter = GetLocalInt(oModule, "SURVIVAL_COUNTER");

    // 10 possable survival Items
    SetCustomToken(1500, IntToString(iCounter));
}
