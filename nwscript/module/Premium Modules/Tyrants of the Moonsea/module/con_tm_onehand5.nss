//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_onehand5
// DATE: November 27, 2005.
// AUTH: Luke Scull
// NOTE: Appears if player has gone to prepare after
//       conversing with Onehand in the Diamond.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYTheCityofHillsfar");

if (nInt < 20)
   return FALSE;

return TRUE;
}
