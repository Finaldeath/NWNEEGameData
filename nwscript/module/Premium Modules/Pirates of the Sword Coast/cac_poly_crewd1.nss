//:://////////////////////////////////////////////
//:: cac_poly_crewd1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Hand out one reward for Recruiting the
    Maximum Possable Crew members.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();

    // Give the player the Red Dragon Scale
    CreateItemOnObject("potsc_rdrgnscl", oPC);
    SetLocalInt(oModule, "cac_poly_crewd1", TRUE);
}
