//::///////////////////////////////////////////////
//:: FileName sc_ac_npc_like
//:: Check to see if NPC likes player
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/27/2005 10:36:36 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "like") == 1))
        return FALSE;

    return TRUE;
}
