// October 2005
// B W-Husey
// Set the journal entry to state 10 for The Apprentice Slave. The PC has refused
// this quest and will never take it.  (2nd journal version if did give money though)

void main()
{
    string sName = "AligXP1"+GetTag(OBJECT_SELF);
    if (GetLocalInt(GetPCSpeaker(),sName)>0)AddJournalQuestEntry("TheApprenticeSlave",12,GetPCSpeaker(),TRUE);
    else    AddJournalQuestEntry("TheApprenticeSlave",10,GetPCSpeaker(),TRUE);
}
