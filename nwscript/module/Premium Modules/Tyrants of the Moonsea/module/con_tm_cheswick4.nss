//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_cheswick4
// DATE: January 1, 2006
// AUTH: Luke Scull
// NOTE: Appears is A Merchant's Tale journal entry is
//       20+.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYAMerchantsTale");

if (nInt < 20)
   return FALSE;

return TRUE;
}

