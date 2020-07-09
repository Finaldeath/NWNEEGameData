//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_norcharm
// DATE: October 10, 2005
// AUTH: Luke Scull
// NOTE: Appears when "Locktower Rescue" journal entry
//       is on 40.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYLocktowerRescue");

if (!(nInt == 40))
   return FALSE;

return TRUE;
}

