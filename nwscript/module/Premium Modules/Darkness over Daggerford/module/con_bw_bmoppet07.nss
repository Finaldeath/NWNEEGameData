#include "hf_in_xp"

void main()
{
    object oPC = GetPCSpeaker();

                // journal update
                // 10-shopped with imp
                string sJournal ="j99";
                string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);
                int nStatus = 10;
                if (GetLocalInt(oPC, sJournalVar) < nStatus)
                {
                    AddJournalQuestEntry(sJournal, nStatus, oPC);

                    object oPlayer = GetFirstFactionMember(oPC);
                    while (GetIsObjectValid(oPlayer))
                    {
                        GiveQuestXPToCreature(oPC, sJournal, 100.0);
                        oPlayer = GetNextFactionMember(oPC);
                    }
                }

    SetLocalInt(OBJECT_SELF, "HF_ARG", 5);
}
