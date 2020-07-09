//::///////////////////////////////////////////////
//:: con_a2_sweet_fd1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check that the PC has not talked to Talked to
    Sweet Marie atleast once and the PC is Female.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oSweet = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    int iReturn = FALSE;

    if ((GetLocalInt(oSweet, "cac_a2_sweet_d1") == FALSE)
        && (GetGender(oPC) == GENDER_FEMALE))
    {
        iReturn = TRUE;
    }

    return iReturn;
}
