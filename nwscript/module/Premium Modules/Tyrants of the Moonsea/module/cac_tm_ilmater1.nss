//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_ilmater1
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Updates journal depending on how Garth died.
//       Purely for the purposes of consistency.
//       Award 1,500 xp.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

object oPC = GetPCSpeaker();

if (GetLocalInt(oPC, "NW_JOURNAL_ENTRYHillsfarArenaFatherGarth") == 30)
   {
   AddJournalQuestEntry("HillsfarArenaFatherGarth", 60, oPC, TRUE, FALSE);

   GiveXPToCreature(oPC, 1500);

   }
else
   {
   AddJournalQuestEntry("HillsfarArenaFatherGarth", 50, oPC, TRUE, FALSE);

   GiveXPToCreature(oPC, 1500);
}
}
