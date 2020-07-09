//::///////////////////////////////////////////////
//:: FileName c_can_sleep
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2018-09-14 11:21:02 AM
//:://////////////////////////////////////////////
#include "ddf_util"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oLeader = GetFactionLeader(oPC);

    if(oPC != oLeader)
        return FALSE;

    // Inspect local variables
    return CanPartySleep() == TRUE;
}
