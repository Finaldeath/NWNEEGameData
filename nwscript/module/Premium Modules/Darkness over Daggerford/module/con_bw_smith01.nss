//::///////////////////////////////////////////////
//::
//:: con_bw_smith01
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: Conversation script.
//::
//:: Smith takes Moradin's Stone.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 11/9/2005
//::
//:://////////////////////////////////////////////

#include "hf_in_plot"
#include "hf_in_xp"
//#include "X0_I0_PARTYWIDE"

void main()
{
    object oPC = GetPCSpeaker();

    string sItem = GetLocalString(OBJECT_SELF, "sItem");
    object oItem = GetItemPossessedBy(oPC, sItem);

    DestroyObject(oItem);

    SetLocalInt(GetModule(), "nIH_RestoredStone", 1);

    SetLocalInt(OBJECT_SELF, "HF_ARG", 2);

        // check for journal update
        string sJournal = "j92"; // relevant quest
        int nStatus = 10;        // status

        string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);
        if (GetLocalInt(oPC, sJournalVar) < nStatus)
        {
            // player needs an update
            AddJournalQuestEntry(sJournal, nStatus, oPC);

            // player needx XP for quest completion
            int nXP = GetJournalQuestExperience(sJournal);
            if (nXP > 0)
            {
                    //GiveXPToAll(oPC, nXP);
                    object oPlayer = GetFirstFactionMember(oPC);
                    while (GetIsObjectValid(oPlayer))
                    {
                        GiveQuestXPToCreature(oPC, sJournal, 100.0);
                        oPlayer = GetNextFactionMember(oPC);
                    }
            }
        }
}
