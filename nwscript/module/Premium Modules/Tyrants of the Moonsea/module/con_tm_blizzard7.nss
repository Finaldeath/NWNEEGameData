//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_blizzard7
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Appears when player has spoken with Maalthiir
//       and survived the Arena.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

//TODO:DELETE
// using hf_ut_plot_* instead

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "hillsfarpass") == 1))
        return FALSE;

    return TRUE;
}
