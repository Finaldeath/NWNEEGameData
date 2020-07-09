//::///////////////////////////////////////////////
//:: con_a2_petedead
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if Rascally Pete is dead.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oModule = GetModule();
    int iReturn = FALSE;

    if (GetLocalInt(oModule, "con_a2_petedead") == TRUE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
