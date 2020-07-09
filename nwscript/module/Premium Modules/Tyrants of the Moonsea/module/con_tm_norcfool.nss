//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_norcfool
// DATE: October 12, 2005
// AUTH: Luke Scull
// NOTE: Appears when "Locktower Rescue" journal entry
//       is on 70.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYLocktowerRescue");

if (!(nInt == 70))
   return FALSE;

return TRUE;
}

