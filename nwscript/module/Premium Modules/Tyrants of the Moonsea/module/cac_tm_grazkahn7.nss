//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_grazkahn7
// DATE: November 9, 2005
// AUTH: Luke Scull
// NOTE: Update journal; player has spoken with Grazkahn
//       first and agreed to retrieve Kazz's sword.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();

    AddJournalQuestEntry("FiendsAtWar", 41, oPC, TRUE, FALSE, TRUE);
}
