// muragh's magnificent machine: update the quest journal (now complete)

void main()
{
    object oPC = GetPCSpeaker();
    if(GetLocalInt(oPC, "NW_JOURNAL_ENTRY" + "MuraghsMagnificentMachine") < 30)
    {
        AddJournalQuestEntry("MuraghsMagnificentMachine", 30, oPC);
        int nXP = GetJournalQuestExperience("MuraghsMagnificentMachine");
        GiveXPToCreature(oPC, nXP);
    }
}
