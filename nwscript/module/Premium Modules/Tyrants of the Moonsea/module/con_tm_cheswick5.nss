//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_cheswick5
// DATE: January 1, 2006
// AUTH: Luke Scull
// NOTE: Appears if player A Merchant's Tale journal
//       entry is 30+.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYAMerchantsTale");

if (nInt < 30)
   return FALSE;

return TRUE;
}

