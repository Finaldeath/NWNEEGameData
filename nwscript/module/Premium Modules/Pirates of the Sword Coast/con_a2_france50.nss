//::///////////////////////////////////////////////
//:: con_a2_france50
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if Rascally Pete was killed.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oModule = GetModule();
    int iReturn = FALSE;

    if (GetLocalInt(oModule, "cac_a2_franc50") == TRUE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
