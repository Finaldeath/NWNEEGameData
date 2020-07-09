//::///////////////////////////////////////////////
//:: Act 2: PC has not received their Act 2 tattoo
//:: con_a2_pc_notat.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Return TRUE if PC has not yet received their
     tattoo for Act 2.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 18, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sPC_ID = GetName(oPC)+GetPCPlayerName(oPC);
    int bPC_Tattoo = GetLocalInt(GetModule(), "bTattoo_Act2_"+sPC_ID);

    if (bPC_Tattoo == FALSE)
    {
        return TRUE;
    }
    return FALSE;
}
