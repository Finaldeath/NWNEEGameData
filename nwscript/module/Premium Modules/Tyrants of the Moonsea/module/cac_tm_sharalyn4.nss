//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_sharalyn4
// DATE: September 29, 2005
// AUTH: Luke Scull
// NOTE: Adds journal quest entry The Road East and
//       unlocks Temple of Chauntea.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oPC = GetPCSpeaker();

object oDoor = GetObjectByTag("Voonlar_To_TempleofChauntea");

AddJournalQuestEntry("OrderoftheCrippledFang", 15, oPC, TRUE, FALSE);

SetLocked(oDoor, FALSE);
}

