//::///////////////////////////////////////////////
//:: con_a2_tttst_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the tattoist been spoken too before?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oTattooist = OBJECT_SELF;
    object oModule = GetModule();
    int iReturn = FALSE;

    if (GetLocalInt(oTattooist, "cac_a2_tttst_d1") == FALSE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
