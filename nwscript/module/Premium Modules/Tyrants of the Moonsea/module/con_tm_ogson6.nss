//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_ogson6
// DATE: January 1, 2006
// AUTH: Luke Scull
// NOTE: Appears if A Merchant's Tale journal entry
//       is less than 50.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYAMerchantsTale");

if (nInt < 50)
   return FALSE;

return TRUE;
}


