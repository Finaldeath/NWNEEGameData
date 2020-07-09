//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_onehand4
// DATE: November 27, 2005.
// AUTH: Luke Scull
// NOTE: Appears if player is speaking with Onehand
//       for the first time in the Diamond.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYTheCityofHillsfar");

if (nInt < 10)
   return FALSE;

return TRUE;
}
