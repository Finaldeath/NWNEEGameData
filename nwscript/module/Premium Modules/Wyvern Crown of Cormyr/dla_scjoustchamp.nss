//::///////////////////////////////////////////////
//:: dla_scjoustchamp
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Conditional script that checks if PC won the whole torney
*/
//:://////////////////////////////////////////////
//:: Create By: Gale
//:: Created On: Jan 17, 2006
//:://////////////////////////////////////////////
// Syrsnein 25 Feb 2006: Changed condition to 4 wins as per Ben

#include "dla_i0_joust"

int StartingConditional()
{
    //If PC has finished jousting and won 4 matches they are the champion.
    object oPC = GetPCSpeaker();
    int nMainPlot = GetLocalInt(oPC, "nMainPlot");
    int nJoustState = DLA_GetJoustState(oPC);
    // If this is the first joust tourney
    if (DLA_GetIsTourney(oPC, 1) && nMainPlot==1)
        return DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_CHAMP);
    // If this is the second joust tourney
    if (DLA_GetIsTourney(oPC, 2) && nMainPlot==7)
        return DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_CHAMP);
    return FALSE;
}
