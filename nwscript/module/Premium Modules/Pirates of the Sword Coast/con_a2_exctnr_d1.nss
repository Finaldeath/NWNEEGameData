//::///////////////////////////////////////////////
//:: con_a2_exctnr_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    check that the PC has talked to the
    executioner at least onece
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oExecutioner = OBJECT_SELF;
    int iReturn = FALSE;

    if (GetLocalInt(oExecutioner, "cac_a2_exctnr_d1") == FALSE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
