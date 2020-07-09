//::///////////////////////////////////////////////
//:: con_poly_crftd1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has Recruited the Maximum number
    of Crewmen so give an Item to them as a
    reward.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iCrewCount = GetLocalInt(oModule, "A2_CREWCOUNT");
    int iDoOnce = GetLocalInt(oModule, "cac_poly_crewd1");
    int iResult = FALSE;

    // do once if the player has Recruited 8 sailors
    if ((iDoOnce == FALSE) && (iCrewCount >= 8))
    {
        iResult = TRUE;
    }

    return iResult;
}
