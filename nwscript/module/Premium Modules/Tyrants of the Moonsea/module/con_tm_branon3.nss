//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_branon3
// DATE: Dcember 6, 2005
// AUTH: Luke Scull
// NOTE: Appears when PC has already spoken with Branon.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "branonspoke") == 1))
        return FALSE;

    return TRUE;
}