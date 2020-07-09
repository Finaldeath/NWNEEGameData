//::///////////////////////////////////////////////
//:: Act 0: Nisar has not received his Act 0 tattoo
//:: con_a0_nis_notat.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Return TRUE if Nisar has not yet received his
     tattoo for Act 0.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 18, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int bNisar_Tattoo = GetLocalInt(GetModule(), "bNisarTattoo_Act0");
    if (bNisar_Tattoo == FALSE)
    {
        return TRUE;
    }
    return FALSE;
}
