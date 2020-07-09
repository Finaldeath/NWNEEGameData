//November 2005
// B W-Husey
// Conditional response for an irritated henchman

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "nAnnoyed") == 1))
        return FALSE;

    return TRUE;
}
