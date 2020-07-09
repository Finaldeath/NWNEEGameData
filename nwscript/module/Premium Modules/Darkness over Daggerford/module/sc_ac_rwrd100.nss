//::///////////////////////////////////////////////
//:: FileName sc_ac_rwrd100
//:: This verifies the PC requires a 100 gold piece reward.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/20/2005 12:46:27 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "ac_reward") == 100))
        return FALSE;

    return TRUE;
}
