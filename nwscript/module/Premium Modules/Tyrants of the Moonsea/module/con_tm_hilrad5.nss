int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYTheMoonsea");

if (nInt < 10)
   return FALSE;

return TRUE;
}
