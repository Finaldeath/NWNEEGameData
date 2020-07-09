//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_unused
// DATE: November 9, 2005
// AUTH: Luke Scull
// NOTE: This little script is used to make all the
//       now-defunct dialogue not show up, without
//       having to remove them or have them interfering
//       with play.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "unusednode") == 1))
        return FALSE;

    return TRUE;
}
