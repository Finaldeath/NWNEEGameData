#include "hf_in_xp"

void main()
{
    object oClicker = GetClickingObject();

    if (GetIsPC(oClicker))
    {
        object oTrans = GetTransitionTarget(OBJECT_SELF);
        AssignCommand(oClicker, JumpToObject(oTrans));

        // special cases
        if (GetTag(OBJECT_SELF) == "ar2505a_ar2504_exit")
        {
            object oBeholder = GetNearestObjectByTag("bw_beholder");
            if (!GetIsObjectValid(oBeholder) || GetIsDead(oBeholder))
            {
                // check for journal update
                string sJournal = "j19"; // relevant quest
                int nStatus = 10;        // status

                string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);
                int nCurrentStatus = GetLocalInt(oClicker, sJournalVar);
                if ((nCurrentStatus < nStatus) && (nCurrentStatus != 5))
                {
                    // player needs an update
                    AddJournalQuestEntry(sJournal, nStatus, oClicker, FALSE);

                    // player needx XP for quest completion
                    int nXP = GetJournalQuestExperience(sJournal);
                    if (nXP > 0)
                    {
                       // GiveXPToCreature(oClicker, nXP);
                        GiveQuestXPToCreature(oClicker, sJournal, 100.0);
                    }
                }
            }
        }
    }
    else
    {
        object oMe = OBJECT_SELF;
        AssignCommand(oClicker, ClearAllActions(TRUE));
        AssignCommand(oClicker, ActionMoveAwayFromObject(oMe, FALSE, 10.0f));
    }
}
