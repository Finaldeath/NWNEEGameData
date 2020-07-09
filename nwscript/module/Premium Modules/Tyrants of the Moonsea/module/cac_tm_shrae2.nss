//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_shrae2
// DATE: August 29, 2005
// AUTH: Luke Scull
// NOTE: Adds Evil Beneath Voonlar journal entry and
//       unlocks door to Abandoned House.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oPC = GetPCSpeaker();

object oDoor = GetObjectByTag("Voonlar_To_AbandonedHouse");

AddJournalQuestEntry("EvilBeneathVoonlar", 10, oPC, TRUE, FALSE);

SetLocked(oDoor, FALSE);
}

