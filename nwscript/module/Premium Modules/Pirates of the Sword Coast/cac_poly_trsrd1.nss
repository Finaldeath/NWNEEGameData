//:://////////////////////////////////////////////
//:: cac_poly_trsrd1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Hand out one reward for finding all the
    treasure.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();

    // Give the player the Crystal Egg.
    CreateItemOnObject("potsc_plycrstlgg", oPC);
    SetLocalInt(oModule, "cac_poly_trsrd1", TRUE);
}
