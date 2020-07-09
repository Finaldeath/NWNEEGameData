//::///////////////////////////////////////////////
//:: dla_d2_joust_t1
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Joust conversation conditional script that returns TRUE if the character has
   not started jousting the 1st tournament but is able to.
*/
//:://////////////////////////////////////////////
//:: Created By: Syrsnein
//:: Created On: May 28, 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nMainPlot = GetLocalInt(oPC, "nMainPlot");
    int nJoustState = DLA_GetJoustState(oPC);
    if (nMainPlot==1 &&
       !DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_STARTED) &&
        DLA_JoustGetCanJoust(oPC))
        return TRUE;

    return FALSE;
}
