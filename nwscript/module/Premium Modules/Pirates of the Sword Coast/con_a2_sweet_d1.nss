//::///////////////////////////////////////////////
//:: con_a2_sweet_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has not talked to Talked to
    Sweet Marie atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oSweet = OBJECT_SELF;
    int iReturn = FALSE;

    if (GetLocalInt(oSweet, "cac_a2_sweet_d1") == FALSE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
