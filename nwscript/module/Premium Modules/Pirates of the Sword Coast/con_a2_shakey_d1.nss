//::///////////////////////////////////////////////
//:: con_a2_shakey_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to Shakey McGuire
    atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oShakey = OBJECT_SELF;
    int iReturn = FALSE;

    if (GetLocalInt(oShakey, "cac_a2_shakey_d1") == FALSE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
