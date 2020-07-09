//:://////////////////////////////////////////////
//:: cac_poly_crft
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set the custom token for the current amount
    of Survival Items Crafted.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    int iCraftCounter = GetLocalInt(GetModule(), "CRAFT_A1_COUNTER");

    // 8 possable Crafting Items
    SetCustomToken(1501, IntToString(iCraftCounter));
}
