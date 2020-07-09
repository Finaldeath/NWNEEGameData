//::///////////////////////////////////////////////
//:: con_a2_pglg_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the PC has talked to Peg Leg atleast
    once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPegLeg = OBJECT_SELF;
    int iReturn = FALSE;

    if (GetLocalInt(oPegLeg, "cac_a2_pglg_d1") == TRUE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
