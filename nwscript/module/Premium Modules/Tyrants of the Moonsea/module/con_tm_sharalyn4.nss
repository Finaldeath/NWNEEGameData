//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_sharalyn2
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Appears when player speaks with Sharalyn
//       after speaking with Hilrad and asking her
//       what's wrong.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "sharalynbough") == 2))
        return FALSE;

    return TRUE;
}
