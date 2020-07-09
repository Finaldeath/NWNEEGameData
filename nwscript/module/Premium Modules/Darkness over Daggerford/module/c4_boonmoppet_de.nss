// onDeath event for Boonmoppet in AR0705
// .. update Boonmoppet's journal entry when it is dead

#include "hf_in_xp"

void main()
{
    // journal update
    // 11-killed imp
    object oPC = GetFirstPC();
    string sJournal ="j99";
    string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);
    int nStatus = 11;
    int nCurStatus = (GetLocalInt(oPC, sJournalVar));

    if (nCurStatus < nStatus)
    {
        // if the quest wasn't finished and you didn't make friends with
        // boonmoppet, then give final journal entry and XP
        if (nCurStatus < 10)
        {
            AddJournalQuestEntry(sJournal, nStatus, oPC);

            object oPlayer = GetFirstFactionMember(oPC);
            while (GetIsObjectValid(oPlayer))
            {
                GiveQuestXPToCreature(oPC, sJournal, 100.0);
                oPlayer = GetNextFactionMember(oPC);
            }
        }
    }

    // execute the standard death script
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
