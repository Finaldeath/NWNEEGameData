//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_bennart6
// DATE: October 20, 2005
// AUTH: Luke Scull
// NOTE: Appears when "Locktower Rescue" journal entry
//       is on 104 (finished).
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYLocktowerRescue");

if (!(nInt == 104))
   return FALSE;

return TRUE;
}
