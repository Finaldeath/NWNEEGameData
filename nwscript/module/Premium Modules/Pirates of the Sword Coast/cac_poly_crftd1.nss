//:://////////////////////////////////////////////
//:: cac_poly_crftd1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Hand out one reward for crafting all the
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

    // Give the player the Mermaid Hair
    CreateItemOnObject("potsc_mrmdhr", oPC);
    SetLocalInt(oModule, "cac_poly_crftd1", TRUE);
}
