//::///////////////////////////////////////////////
//:: con_a2_vnglbs_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to Vengaul
    atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oHoney = OBJECT_SELF;
    int iReturn = FALSE;

    if (GetLocalInt(oHoney, "cac_a2_vnglbs_d1") == FALSE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
