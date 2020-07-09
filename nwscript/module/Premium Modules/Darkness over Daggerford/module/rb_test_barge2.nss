void main()
{
    AddJournalQuestEntry ("barge_activity", 2, GetPCSpeaker(), TRUE);
    SetLocalInt(GetModule(), "barge_activity", 2);
}
