//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_artemis2
// DATE: November 20, 2005
// AUTH: Luke Scull
// NOTE: Appears if Grazkhan is dead.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "grazkahndead") == 1))
        return FALSE;

    return TRUE;
}
