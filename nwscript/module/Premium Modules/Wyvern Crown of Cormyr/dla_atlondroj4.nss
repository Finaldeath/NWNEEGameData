// October 2005
// B W-Husey
// Set the journal entry to state 33 for The Apprentice Slave. The PC got a written promise of aid to
// Londro from the Matron, but destroyed the document on discovering they had been duped by Londro. Journal
// TheApprenticeSlave set to 33 to record this.

void main()
{
    AddJournalQuestEntry("TheApprenticeSlave",33,GetPCSpeaker(),TRUE);
    DestroyObject(GetObjectByTag("WitnessDoc"));
}
