//::///////////////////////////////////////////////
//:: con_a2_snprsnrs
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC seen the prisoners in the prison?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iResult;

    if (GetLocalInt(oModule, "PC_SEEN_PRISONERS") == TRUE)
    {
        return TRUE;
    }

    return FALSE;
}
