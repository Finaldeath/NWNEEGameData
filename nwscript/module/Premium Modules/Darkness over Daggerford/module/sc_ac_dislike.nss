//::///////////////////////////////////////////////
//:: FileName sc_ac_dislike
//:: Check to see if NPC dislikes player
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 10/27/2005 10:36:36 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "ac_dislike") == 1))
        return FALSE;

    return TRUE;
}
