//::///////////////////////////////////////////////
//:: con_a2_langer_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check that the PC has talked to Long Neck
    Langer atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oLanger = OBJECT_SELF;
    int iReturn = FALSE;

    if (GetLocalInt(oLanger, "cac_a2_langer_d1") == FALSE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
