//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_garth4
// DATE: February 27, 2006
// AUTH: Luke Scull
// NOTE: Appears when player has had second Arena
//       battle.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "arena") == 2))
        return FALSE;

    return TRUE;
}
