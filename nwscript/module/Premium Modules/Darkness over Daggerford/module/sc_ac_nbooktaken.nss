//::///////////////////////////////////////////////
//:: FileName sc_ac_nbooktaken
//:: Check whether book has already been taken
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/14/2005 7:55:59 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "book_taken") != 1))
        return FALSE;

    return TRUE;
}
