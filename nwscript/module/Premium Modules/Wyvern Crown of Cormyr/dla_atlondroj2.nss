// October 2005
// B W-Husey
// Set the journal entry to state 15 for The Apprentice Slave. The quest is now taken, and Londro has made
// an offer of a magic item and this needs to be recorded in the journal.
// Also recorded are the details of how to find the Matron.

void main()
{
    AddJournalQuestEntry("TheApprenticeSlave",15,GetPCSpeaker(),TRUE);
}
