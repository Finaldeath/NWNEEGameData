//::///////////////////////////////////////////////
//:: con_poly_bootyd1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has collected all the booty in the
    module so give them an Item they as a reward.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iBootyCount = GetLocalInt(oModule, "POTSC_BOOTYCOUNT");
    int iDoOnce = GetLocalInt(oModule, "cac_poly_bootyd1");
    int iResult = FALSE;

    // do once if the player has all the treasure.
    if ((iDoOnce == FALSE) && (iBootyCount >= 15))
    {
        iResult = TRUE;
    }

    return iResult;
}
