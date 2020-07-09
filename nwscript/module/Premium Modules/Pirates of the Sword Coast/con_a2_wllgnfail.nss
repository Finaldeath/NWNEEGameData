//::///////////////////////////////////////////////
//:: con_a2_wllgnfail
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If the PC got caught by the sisters, this
    fires (once per time caught).
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 22, 2005
//:://////////////////////////////////////////////
#include "inc_global"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetLocalInt(oPC, l_n_A2_WILLIGAN_PC_FAILED))
    {
        DeleteLocalInt(oPC, l_n_A2_WILLIGAN_PC_FAILED);
        return TRUE;
    }
    else return FALSE;
}
