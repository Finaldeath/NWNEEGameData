//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_halanther
// DATE: October 2, 2005
// AUTH: Luke Scull
// NOTE: Text appears when Voonlar entry less than 30.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYVoonlar");

if (nInt >= 30)
   return FALSE;

return TRUE;
}
