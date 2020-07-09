// October 2005
// B W-Husey
// Set the journal entry to state 12 for The Apprentice Slave. The PC has refused
// this quest and will never take it, though they did give Londro some money.

void main()
{
    AddJournalQuestEntry("TheApprenticeSlave",12,GetPCSpeaker(),TRUE);
}
