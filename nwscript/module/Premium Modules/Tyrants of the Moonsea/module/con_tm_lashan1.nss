//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_lashan1
// DATE: September 24, 2005
// AUTH: Luke Scull
// NOTE: PC has convinced Lashan to tell is tale, but
//       hasn't accepted quest yet.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "lashanspoke") == 1))
        return FALSE;

    return TRUE;
}
