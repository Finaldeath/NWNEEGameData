//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_blizzard4
// DATE: March 18, 2006
// AUTH: Luke Scull.
// NOTE: Text appears when Blizzard is unconscious.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////


//TODO:DELETE
// using hf_ut_plot_* instead

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "blizzardfallen") == 1))
        return FALSE;

    return TRUE;
}
