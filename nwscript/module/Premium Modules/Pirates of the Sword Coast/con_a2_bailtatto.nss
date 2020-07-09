//::///////////////////////////////////////////////
//:: con_a2_bailtattoo
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the PC knows the Gnome Tattooist is
    in jail but bail has not yet been paid.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oTattooist = GetObjectByTag("a2_tattooist");
    object oModule = GetModule();
    int iReturn = FALSE;

    if ((GetLocalInt(oTattooist, "cac_a2_tattoo_d1") == TRUE)
      && (GetLocalInt(oModule, "A2_TATBAIL") != TRUE))
    {
        iReturn = TRUE;
    }

    return iReturn;
}
