// runs when the player aborts the conversation with the crazed man in hillsfar

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("CrazedOldMan", 10, oPC);
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
