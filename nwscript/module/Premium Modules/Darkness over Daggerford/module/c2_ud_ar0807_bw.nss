// user defined event for ar0807 (boonmoppet's hole)

#include "hf_in_xp"
#include "nw_i0_generic"

void main()
{
    int nEvent = GetUserDefinedEventNumber();

    if (nEvent == 503) // portal destroyed
    {
        if (GetLocalInt(OBJECT_SELF, "nPortalDestroyed") == 0)
        {
            object oFall = GetObjectByTag("bw_ar0807_fall");
            object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oFall);
            if (GetIsObjectValid(oPC))
            {
                // journal update
                // 5-destroyed portal
                string sJournal ="j99";
                string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);
                int nStatus = 5;
                if (GetLocalInt(oPC, sJournalVar) < nStatus)
                {
                    AddJournalQuestEntry(sJournal, nStatus, oPC);

                    object oPlayer = GetFirstFactionMember(oPC);
                    while (GetIsObjectValid(oPlayer))
                    {
                        GiveQuestXPToCreature(oPC, sJournal, 50.0);
                        oPlayer = GetNextFactionMember(oPC);
                    }
                }
            }

            SetLocalInt(OBJECT_SELF, "nPortalDestroyed", 1);
        }
    }
}
