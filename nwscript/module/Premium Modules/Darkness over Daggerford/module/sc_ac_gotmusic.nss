//::///////////////////////////////////////////////
//:: FileName sc_ac_gotmusic
//:: See if player already got music
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/22/2006 6:17:15 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "got_music") == 1))
        return FALSE;

    return TRUE;
}
