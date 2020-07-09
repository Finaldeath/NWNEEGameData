//::///////////////////////////////////////////////
//:: con_a2_prgdsh_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has not talked to Talked to
    Prugdush atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPrugdush = OBJECT_SELF;
    int iReturn = FALSE;

    if (GetLocalInt(oPrugdush, "cac_a2_prgdsh_d1") == FALSE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
