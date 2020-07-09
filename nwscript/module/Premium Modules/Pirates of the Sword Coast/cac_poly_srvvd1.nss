//:://////////////////////////////////////////////
//:: cac_poly_srvvd1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Hand out one reward for collecting all the
    Survival Items.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();

    // Give the Player the looking Glass
    CreateItemOnObject("potsc_lkngglss", oPC);
    SetLocalInt(oModule, "cac_poly_srvvd1", TRUE);
}
