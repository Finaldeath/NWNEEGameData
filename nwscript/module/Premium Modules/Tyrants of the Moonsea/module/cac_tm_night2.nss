//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_night2
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Finish Hillsfar journal entry and award 3,500
//       xp to player.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
AddJournalQuestEntry("TheCityofHillsfar", 60, GetPCSpeaker());

GiveXPToCreature(GetPCSpeaker(), 3500);
}
