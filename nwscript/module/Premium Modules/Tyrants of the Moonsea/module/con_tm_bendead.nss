//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_bendead
// DATE: October 20, 2005
// AUTH: Luke Scull
// NOTE: Appears when "Locktower Rescue" journal entry
//       is on 91.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYLocktowerRescue");

if (!(nInt == 91))
   return FALSE;

return TRUE;
}
