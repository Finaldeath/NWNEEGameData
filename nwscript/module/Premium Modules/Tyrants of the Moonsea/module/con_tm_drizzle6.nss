//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_drizzle6
// DATE: March 18, 2006.
// AUTH: Luke Scull
// NOTE: Appears if player has already successfully
//       asked about magic golem.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetLocalInt(oPC, "innovator") != 4) return FALSE;

if (GetLocalInt(oPC, "magicgolem") >= 1) return FALSE;

return TRUE;
}
