// death event for loru
// .. update journal

void main()
{
    object oPC = GetFirstPC();

    int iMaer = GetLocalInt(GetModule(), "iMaerovynaDead");

    if(GetLocalInt(oPC, "ac_miller_quest") == 0)
    {
        if(iMaer == 0)
        {
            AddJournalQuestEntry("j59", 7, oPC);
        }
        else
        {
            AddJournalQuestEntry("j59", 11, oPC);
        }
    }
    else
    {
        if(iMaer == 0)
        {
            AddJournalQuestEntry("j59", 6, oPC);
        }
        else
        {
            AddJournalQuestEntry("j59", 10, oPC);
        }
    }

    SetLocalInt(oPC,"ac_kill_loru",1);

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
