//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_drizzle5
// DATE: March 18, 2006.
// AUTH: Luke Scull
// NOTE: Appears when player has spoken the relevant
//       dialogue with Innovator of Pain, and hasn't
//       chosen this option before.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "innovator") == 4))
        return FALSE;

    if(GetLocalInt(GetPCSpeaker(), "magicgolem") == 1)
        return FALSE;

    return TRUE;
}
