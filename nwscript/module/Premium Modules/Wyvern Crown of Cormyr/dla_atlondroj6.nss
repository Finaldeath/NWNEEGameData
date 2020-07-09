// October 2005
// B W-Husey
// Set the journal entry to state 27 for The Apprentice Slave. Londro Hardhelm, a dwarf that you found
// in the smithy of Morfen, has told you how he is a slave to the 'Matron', with barely enough food
// to survive. He has offered to craft a magic weapon for those that are prepared to help him. You
// have spoken to the Matron and extracted a document from her to pay Londro better. You spoke to Londro,
// but he reminded you that you need the witness for it to be any use.

void main()
{
    AddJournalQuestEntry("TheApprenticeSlave",27,GetPCSpeaker(),TRUE);
}
