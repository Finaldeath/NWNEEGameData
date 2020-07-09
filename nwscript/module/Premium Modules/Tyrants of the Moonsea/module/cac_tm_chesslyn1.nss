//Chesslyn tells PC to visit Zhents Quarter
void main()
{
    object oPC = GetPCSpeaker();

    //Update journal
    AddJournalQuestEntry("Mulmaster", 20, oPC);

    SetLocalInt(OBJECT_SELF, "HF_ARG", 1);
}
