//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_shrae3
// DATE: October 2, 2005
// AUTH: Luke Scull
// NOTE: Appears when PC has received "The Road East"
//       quest but not "Evil Beneath Voonlar."
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYOrderoftheCrippledFang");

if (nInt < 16)
   return FALSE;


nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYEvilBeneathVoonlar");

if (nInt >= 10)
   return FALSE;


return TRUE;
}

