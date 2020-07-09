//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_blizzard5
// DATE: March 18, 2006
// AUTH: Luke Scull.
// NOTE: Text appears when player has defeated Red
//       Minotaur.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////


//TODO:DELETE
// using hf_ut_plot_* instead

int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYTheArena");

if (!(nInt == 100))
   return FALSE;

return TRUE;
}

