// October 2005
// B W-Husey
// Set the journal entry to state 30 for The Apprentice Slave. Londro Hardhelm, a dwarf that you found
// in the smithy of Morfen, has told you how he is a slave to the 'Matron', with barely enough food
// to survive. He has offered to craft a magic weapon for those that are prepared to help him.
// You have spoken to the Matron and extracted a promise from her to pay Londro better.
// However it has transpired that Londro will not be able to make the promised weapon.

void main()
{
    AddJournalQuestEntry("TheApprenticeSlave",30,GetPCSpeaker(),TRUE);
}
