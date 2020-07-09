// check if boonmoppet dead, if so, give xp
// (double check)
// -bw

#include "hf_in_xp"

void main()
{
    object oExiter = GetExitingObject();

    if (GetIsPC(oExiter))
    {
        object oImp = GetObjectByTag("bw_boonmoppet");

        if (!GetIsObjectValid(oImp) || GetIsDead(oImp))
        {
            object oPC = oExiter;

                // journal update
                // 11-killed imp
                string sJournal ="j99";
                string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);
                int nStatus = 11;
                int nCurStatus = (GetLocalInt(oPC, sJournalVar));

                if (nCurStatus < nStatus)
                {
                    AddJournalQuestEntry(sJournal, nStatus, oPC);

                    if (nCurStatus < 10) // not finished, give xp
                    {
                        object oPlayer = GetFirstFactionMember(oPC);
                        while (GetIsObjectValid(oPlayer))
                        {
                            GiveQuestXPToCreature(oPC, sJournal, 100.0);
                            oPlayer = GetNextFactionMember(oPC);
                        }
                    }
                }
        }
    }
}
