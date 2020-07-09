//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_lashan6
// DATE: October 20, 2005
// AUTH: Luke Scull
// NOTE: Appears when Locktower Rescue journal entry
//       is on 101.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYLocktowerRescue");

if (!(nInt == 101))
   return FALSE;

return TRUE;
}
