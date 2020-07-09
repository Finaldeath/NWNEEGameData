//::///////////////////////////////////////////////
//:: con_a2_vantab_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to Vantab
    atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oModule = GetModule();
    object oVantab = OBJECT_SELF;
    int iReturn = FALSE;

    if (GetLocalInt(oModule, "cac_a2_vantab_d1") == TRUE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
