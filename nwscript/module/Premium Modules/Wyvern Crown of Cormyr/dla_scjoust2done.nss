//::///////////////////////////////////////////////
//:: dla_scjoust2done
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   The PC is in the second day of the joust, has not jousted more than 2 matches
     but has lost at least one.
   (this condition should be checked after tourney champ condition is checked)

*/
//:://////////////////////////////////////////////
//:: Create By: Syrsnein
//:: Created On: Feb 25, 2006
//:://////////////////////////////////////////////

#include "dla_i0_joust"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nJoustState = DLA_GetJoustState(oPC);
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_DONE))
        return TRUE;
    return FALSE;
}
