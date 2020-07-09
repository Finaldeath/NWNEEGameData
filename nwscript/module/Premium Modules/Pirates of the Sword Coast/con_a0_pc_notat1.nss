//::///////////////////////////////////////////////
//:: Act 0: PC has not received their Act 0 tattoo; Do Once
//:: con_a0_pc_notat1.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Return TRUE if PC has not yet received their
     tattoo for Act 0 and this node has not
     occurred previously.
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
    int bDoOnce = GetLocalInt(OBJECT_SELF, "bMetPC_"+sPC_ID);

    if (bPC_Tattoo == FALSE &&
        bDoOnce == FALSE)
    {
        //Flag the DoOnce
        SetLocalInt(OBJECT_SELF, "bMetPC_"+sPC_ID, TRUE);

        return TRUE;
    }
    return FALSE;
}
