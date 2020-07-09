//::///////////////////////////////////////////////
//:: con_a2_rpete_d3
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check that this PC has asked Rascally pete
    who he is atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    int iReturn = FALSE;

    if (GetLocalInt(oPlayer, "cac_a2_rpete_d3") == FALSE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
