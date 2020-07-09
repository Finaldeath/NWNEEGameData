// October 2005
// B W-Husey
// Set the journal entry to state 20 for The Apprentice Slave.
// The Matron has refused to help Londro, and the PC must now tell him.
// N.B This journal entry is now set on the Matron.

void main()
{
    AddJournalQuestEntry("TheApprenticeSlave",20,GetPCSpeaker(),TRUE);
}
