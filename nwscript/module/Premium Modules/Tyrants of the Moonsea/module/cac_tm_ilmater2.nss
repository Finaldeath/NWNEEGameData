//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_ilmater2
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Updates journal depending on how Garth died.
//       Purely for the purposes of consistency.
//       Award 750 xp.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

object oPC = GetPCSpeaker();

if (GetLocalInt(oPC, "NW_JOURNAL_ENTRYHillsfarArenaFatherGarth") == 30)
   {
   AddJournalQuestEntry("HillsfarArenaFatherGarth", 61, oPC, TRUE, FALSE);

    GiveXPToCreature(oPC, 750);
   }
else
   {
   AddJournalQuestEntry("HillsfarArenaFatherGarth", 51, oPC, TRUE, FALSE);

    GiveXPToCreature(oPC, 750);
}
}
