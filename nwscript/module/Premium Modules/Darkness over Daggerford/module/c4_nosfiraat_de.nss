// onDeath event for Nosfiraat in AR2009
// .. update nosfiraat's journal entry when he is dead

void main()
{
    // Set final journal entry for killing Nosfiraat
    object oPC = GetFirstPC();

    if(GetLocalInt(oPC, "ac_nosfiraat_qst") == 0)
    {
        AddJournalQuestEntry("j62", 3, oPC);
    }
    else
    {
        AddJournalQuestEntry("j62", 2, oPC);
    }

    // execute the standard death script
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
