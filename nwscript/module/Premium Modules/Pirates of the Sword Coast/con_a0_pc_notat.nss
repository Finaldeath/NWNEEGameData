//::///////////////////////////////////////////////
//:: Act 0: PC has not received their Act 0 tattoo
//:: con_a0_pc_notat.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Return TRUE if PC has not yet received their
     tattoo for Act 0.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 18, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sPC_ID = GetName(oPC)+GetPCPlayerName(oPC);
    int bPC_Tattoo = GetLocalInt(GetModule(), "bTattoo_Act0_"+sPC_ID);

    if (bPC_Tattoo == FALSE)
    {
        return TRUE;
    }
    return FALSE;
}
