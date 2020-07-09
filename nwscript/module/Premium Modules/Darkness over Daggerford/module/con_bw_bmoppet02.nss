// pc agrees to start quest

void main()
{
    SetPlotFlag(OBJECT_SELF, TRUE); // keep girl alive for quest resolution!

    object oPC = GetPCSpeaker();

    SetLocalInt(oPC, "nBoonMoppetQuest", 1); // accepted quest

    // journal update
    // 1 - accepted quest
    string sJournal ="j99";
    string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);
    int nStatus = 1;
    if (GetLocalInt(oPC, sJournalVar) < nStatus)
    {
        AddJournalQuestEntry(sJournal, nStatus, oPC);
    }
}
