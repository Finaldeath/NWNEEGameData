//::///////////////////////////////////////////////
//:: Act 2: PC has already received their Act 2 tattoo
//:: con_a2_pc_tattoo.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Return TRUE if PC has already received their
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

    if (bPC_Tattoo == TRUE)
    {
        return TRUE;
    }
    return FALSE;
}
