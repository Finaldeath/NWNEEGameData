//::///////////////////////////////////////////////
//:: con_a2_kary_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to kary
    atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oKary = OBJECT_SELF;
    int iDoOnce = GetLocalInt(oKary, "cac_a2_kary_d1");
    int iReturn = FALSE;

    if (iDoOnce == FALSE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
