//:://////////////////////////////////////////////
//:: cac_poly_bootyd1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Hand out one reward for finding all the
    Booty.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();

    CreateItemOnObject("potsc_plygoldngg", oPC);
    SetLocalInt(oModule, "cac_poly_bootyd1", TRUE);
}
