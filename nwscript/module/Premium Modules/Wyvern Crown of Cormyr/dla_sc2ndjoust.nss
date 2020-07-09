//::///////////////////////////////////////////////
//:: dla_sc2ndjoust
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Joust conversation check that returns TRUE if the player is ready to start
   the 2nd jousting tournament.
*/
//:://////////////////////////////////////////////
//:: Created By: B W-Husey
//:: Created On: Mar 2006
//:://////////////////////////////////////////////
//Syrsnein, Added second condition so that the conversation node is used the
// first time the PC talks to Thiodor during the second tournament.  Otherwise
// we want Thiodor to ask the PC if he is ready for his next joust.

//B W-Husey: The problem is the 2nd condition is not getting set somewhere when you parachute test

#include "dla_i0_joust"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nMainPlot = GetLocalInt(oPC, "nMainPlot");
    int nJoustState = DLA_GetJoustState(oPC);
    if (nMainPlot==7 &&
        DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_DONE) &&
        DLA_JoustGetCanJoust(oPC))
        return TRUE;
    return FALSE;
}
