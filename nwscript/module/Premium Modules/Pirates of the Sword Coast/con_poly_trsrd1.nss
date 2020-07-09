//::///////////////////////////////////////////////
//:: con_poly_trsrd1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has collected all the tresure
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
    int iTrsrCount = GetLocalInt(oModule, "POTSC_TREASURECOUNT");
    int iDoOnce = GetLocalInt(oModule, "cac_poly_trsrd1");
    int iResult = FALSE;

    // do once if the player has all the treasure.
    if ((iDoOnce == FALSE) && (iTrsrCount >= 9))
    {
        iResult = TRUE;
    }

    return iResult;
}
