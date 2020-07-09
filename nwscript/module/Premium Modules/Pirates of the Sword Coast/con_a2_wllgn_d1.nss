//::///////////////////////////////////////////////
//:: con_a2_wllgn_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to Whipped
    Willigan atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oWilligan = OBJECT_SELF;
    int iReturn = FALSE;

    if (GetLocalInt(oWilligan, "cac_a2_wllgn_d1") == TRUE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
