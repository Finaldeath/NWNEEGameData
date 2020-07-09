//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_innovate12
// DATE: March 18, 2006.
// AUTH: Luke Scull
// NOTE: Appears when player has followed IoP from Cell
//       after conversation following the Magic Golem's
//       defeat.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYTheArena");

if (!(nInt == 90))
   return FALSE;

return TRUE;
}



