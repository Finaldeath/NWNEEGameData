//::///////////////////////////////////////////////
//:: con_a0_anauroch
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has hear about the Anauroch Desert
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////


int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iAnauroch = GetLocalInt(oPC, "cac_a0_anauroch");

    if(iAnauroch == TRUE)
    {
        return TRUE;
    }

    return FALSE;

}
