//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_dazel2
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Appears if Locktower Rescue journal entry on 90.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYLocktowerRescue");

if (!(nInt == 90))
   return FALSE;

return TRUE;
}
