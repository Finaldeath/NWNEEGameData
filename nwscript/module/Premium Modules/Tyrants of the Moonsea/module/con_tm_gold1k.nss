//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_gold1k
// DATE: November 24, 2005
// AUTH: Luke Scull
// NOTE: Appears if PC has more than 1,000 gold.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetGold(oPC) < 1000) return FALSE;

return TRUE;
}
