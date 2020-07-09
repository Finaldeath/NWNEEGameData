//::///////////////////////////////////////////////
//:: con_a2_frncs_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to Sir Francis
    atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oFrancis = OBJECT_SELF;
    int iPlot = GetLocalInt(oFrancis, "cac_a2_frncs_d1");
    int iReturn = FALSE;

    if (iPlot == FALSE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
