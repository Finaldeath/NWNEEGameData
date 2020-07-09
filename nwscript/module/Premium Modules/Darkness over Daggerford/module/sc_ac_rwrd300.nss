//::///////////////////////////////////////////////
//:: FileName sc_ac_rwrd300
//:: This verifies the PC requires a 300 gold piece reward.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/20/2005 12:46:27 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "ac_reward") == 300))
        return FALSE;

    return TRUE;
}
