//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_grazkahn4
// DATE: November 9, 2005
// AUTH: Luke Scull
// NOTE: Appears if player has agreed to recover
//       Kazz's sword.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "kazzquest") == 1))
        return FALSE;

    return TRUE;
}
