//::///////////////////////////////////////////////
//:: con_a2_rpete_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the PC has talked to Rascally Pete
    atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    int iReturn = FALSE;

    if (GetLocalInt(oPlayer, "cac_a2_rpete_d1") == FALSE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
