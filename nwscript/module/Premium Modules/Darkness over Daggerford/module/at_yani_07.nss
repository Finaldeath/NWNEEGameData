// yani tells the player to come back later for a custom item

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("j102", 1, oPC);
}
