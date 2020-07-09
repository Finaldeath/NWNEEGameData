//::///////////////////////////////////////////////
//:: dla_d2_joustnext
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Check if the character have everything needed to participate on joust

   Syrsnein, Mar 2006: changed conditional check to use DLA_GetIsTourney and
   to check against nMainPlot.
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: May 22, 2005
//:://////////////////////////////////////////////

#include "dla_inc_ride"
#include "dla_i0_joust"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nMainPlot = GetLocalInt(oPC, "nMainPlot");
    int bJoust1 = (DLA_GetIsTourney(oPC, 1) && nMainPlot==1);  // Tourney 1 is started
    int bJoust2 = (DLA_GetIsTourney(oPC, 2) && nMainPlot==7);  // Tourney 2 is started
    if (DLA_JoustGetCanJoust(oPC) && (bJoust1 || bJoust2)) return TRUE;
    return FALSE;
}
