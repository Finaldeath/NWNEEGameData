//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_blizzard6
// DATE: March 18, 2006
// AUTH: Luke Scull
// NOTE: Text when player has had final conversation
//       with Blizzard before going to Castle Maalthiir.
//////////////////////////////////////////////////////

//TODO:DELETE
// using hf_ut_plot_* instead

int StartingConditional()
{
    return  (GetLocalInt(GetPCSpeaker(), "blizzard") == 3);
}
