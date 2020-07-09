//::///////////////////////////////////////////////
//:: con_poly_crftd1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has cafted all the Survival Items
    in the module so give them an Item to them
    as a reward.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iCraftCount = GetLocalInt(oModule, "CRAFT_A1_COUNTER");
    int iDoOnce = GetLocalInt(oModule, "cac_poly_crftd1");
    int iResult = FALSE;

    // do once if the player has all 8 of the Survival Items.
    if ((iDoOnce == FALSE) && (iCraftCount >= 8))
    {
        iResult = TRUE;
    }

    return iResult;
}
