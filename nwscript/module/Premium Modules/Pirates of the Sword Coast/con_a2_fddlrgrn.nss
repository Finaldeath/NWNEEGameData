//::///////////////////////////////////////////////
//:: con_a2_fddlrgrn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the PC has heard about fiddlers
    green, the undersea temple.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oModule = GetModule();
    int iReturn = FALSE;

    if (GetLocalInt(oModule, "cac_a2_fddlrgrn") == TRUE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
