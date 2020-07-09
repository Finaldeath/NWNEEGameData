//::///////////////////////////////////////////////
//:: con_a2_hnypea_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to Honey Pea
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

    if (GetLocalInt(oHoney, "cac_a2_hnypea_d1") == TRUE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
