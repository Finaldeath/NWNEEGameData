//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_innovate11
// DATE: March 18, 2006.
// AUTH: Luke Scull
// NOTE: Appears when player is preparing for battle
//       against the Red Minotaur. (NOTE: cac_tm_innovate10
//       was unused.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "innovator") == 6))
        return FALSE;

    return TRUE;
}
