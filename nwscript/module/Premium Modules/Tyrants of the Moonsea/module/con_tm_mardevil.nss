//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_mardrvil
// DATE: October 6, 2005
// AUTH: Luke Scull
// NOTE: Appears if PC chose evil option with Mard.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "mardevil") == 1))
        return FALSE;

    return TRUE;
}
