// October 2005
// B W-Husey
// Set the journal entry to state 11 for The Apprentice Slave. The quest is not taken, but Londro has made
// an offer of a magic item and this needs to be recorded in the journal.

void main()
{
    AddJournalQuestEntry("TheApprenticeSlave",11,GetPCSpeaker(),TRUE);
}
