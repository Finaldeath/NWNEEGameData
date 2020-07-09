//::///////////////////////////////////////////////
//:: FileName sc_ac_rwrd0
//:: This verifies the PC does not require a reward.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/20/2005 12:46:27 AM
//:://////////////////////////////////////////////
int StartingConditional()
{
    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "ac_reward") == 0))
        return FALSE;

    return TRUE;
}
