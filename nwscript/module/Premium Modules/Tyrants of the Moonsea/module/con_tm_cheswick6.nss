//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_cheswick6
// DATE: January 1, 2006
// AUTH: Luke Scull
// NOTE: Appears if player has refused to help Cheswick.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "cheswickhelprefused") == 1))
        return FALSE;

    return TRUE;
}
