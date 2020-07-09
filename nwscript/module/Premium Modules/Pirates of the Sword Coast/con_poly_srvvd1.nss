//::///////////////////////////////////////////////
//:: con_poly_srvvd1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has collected all the Survival
    items in the module so give an Item to them
    as a reward.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iCounter = GetLocalInt(oModule, "SURVIVAL_COUNTER");
    int iDoOnce = GetLocalInt(oModule, "cac_poly_srvvd1");
    int iResult = FALSE;

    // do once if the player has all the survival Items.
    if ((iDoOnce == FALSE) && (iCounter >= 10))
    {
        iResult = TRUE;
    }

    return iResult;
}
