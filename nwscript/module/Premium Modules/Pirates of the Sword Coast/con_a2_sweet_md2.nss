//::///////////////////////////////////////////////
//:: con_a2_sweet_md2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check that the PC has not flirted with
    Sweet Marie atleast once and the PC is Male.
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

    if ((GetLocalInt(oSweet, "cac_a2_sweet_d2") == FALSE)
        && (GetGender(oPC) == GENDER_MALE))
    {
        iReturn = TRUE;
    }

    return iReturn;
}
