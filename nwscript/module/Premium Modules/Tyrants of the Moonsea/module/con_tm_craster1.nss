//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_craster1
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Appears if player has spoken with Craster
//       before.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "crasterspoke") == 1))
        return FALSE;

    return TRUE;
}