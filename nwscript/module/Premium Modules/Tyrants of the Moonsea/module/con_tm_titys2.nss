//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_titys2
// DATE: February 16, 2005
// AUTH: Luke Scull
// NOTE: Appears when player hasn't established
//       the nature of Titys's wares.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "titysmerchant") != 1))
        return FALSE;

    return TRUE;
}