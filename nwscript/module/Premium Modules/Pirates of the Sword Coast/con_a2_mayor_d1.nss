//::///////////////////////////////////////////////
//:: con_a2_mayor_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the PC has talked to the Mayor
    atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oModule = GetModule();
    object oMayor = OBJECT_SELF;
    int iReturn = FALSE;

    if (GetLocalInt(oModule, "cac_a2_mayor_d1") == FALSE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
