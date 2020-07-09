//::///////////////////////////////////////////////
//:: cac_a1_poly_d11
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Do once for an insult to garm.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iResult = FALSE;

    if (GetLocalInt(oModule, "cac_a1_poly_d11") == TRUE)
    {
        SetLocalInt(oModule, "cac_a1_poly_d11", TRUE);
        iResult = TRUE;
    }

    return iResult;
}
