//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_cheswick5
// DATE: January 1, 2006
// AUTH: Luke Scull
// NOTE: Update journal.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
AddJournalQuestEntry("AMerchantsTale", 30, GetPCSpeaker());

// Destroy boulders blocking Frost Giants' lair on Shind Road

object oBoulder1 = GetObjectByTag("FrostGiantCaveBoulder1");

object oBoulder2 = GetObjectByTag("FrostGiantCaveBoulder2");

DestroyObject(oBoulder1);

DestroyObject(oBoulder2);
}
