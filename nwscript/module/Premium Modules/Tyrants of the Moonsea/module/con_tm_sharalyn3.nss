//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_sharalyn3
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Appears when player has had initial conver-
//       -sation with Sharalyn in the Swaying Bough.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "sharalynbough") == 1))
        return FALSE;

    return TRUE;
}
