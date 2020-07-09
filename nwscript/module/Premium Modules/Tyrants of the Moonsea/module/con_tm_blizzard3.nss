//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_blizzard3
// DATE: February 25, 2006
// AUTH: Luke Scull.
// NOTE: Appears if player has already spoken with Elf
//       after 1st fight in the Arena.
//////////////////////////////////////////////////////


//TODO:DELETE
// using hf_ut_plot_* instead


int StartingConditional()
{
    return FALSE; // (GetLocalInt(GetPCSpeaker(), "blizzard") == 2)
}
