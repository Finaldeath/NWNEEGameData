//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_halanthr2
// DATE: October 2, 2005
// AUTH: Luke Scull
// NOTE: Apears when Voonlar entry greater than 30 and
//       conversation node hasn't been chosen before.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYVoonlar");

if (nInt < 30)
   return FALSE;


nInt=GetLocalInt(OBJECT_SELF, "informedmadocdied");

if (nInt >= 1)
   return FALSE;

return TRUE;
}

