//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_innovate8
// DATE: March 18, 2006.
// AUTH: Luke Scull
// NOTE: Appears when player allowed Blizzard to live.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYHillsfarArenaBlizzard");

if (!(nInt == 20))
   return FALSE;

return TRUE;
}


