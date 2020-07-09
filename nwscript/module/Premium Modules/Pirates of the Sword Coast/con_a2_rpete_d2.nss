//::///////////////////////////////////////////////
//:: con_a2_rpete_d2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the PC has talked to Rascally Pete
    atleast once about Francis and does not
    already have the ring.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    int iPlot = GetLocalInt(GetModule(), "A2_FRANC");
    int iReturn = FALSE;

    if ((GetLocalInt(oPlayer, "cac_a2_rpete_d2") == TRUE)
        && (iPlot >= 30)
        && (iPlot < 50))
    {
        iReturn = TRUE;
    }

    return iReturn;
}
