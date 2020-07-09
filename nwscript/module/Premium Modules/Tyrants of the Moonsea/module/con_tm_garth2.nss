//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_garth2
// DATE: February 27, 2006
// AUTH: Luke Scull
// NOTE: Appears when player has had conversation with
//       Garth after second Arena battle.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "garth") == 2))
        return FALSE;

    return TRUE;
}
