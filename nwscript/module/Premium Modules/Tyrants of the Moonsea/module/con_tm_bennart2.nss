//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_bennart2
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Appears if player treated Bennart evilly.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "bennartevil") == 1))
        return FALSE;

    return TRUE;
}