//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT7
/*
  Default OnDeath event handler for NPCs.

  Adjusts killer's alignment if appropriate and
  alerts allies to our death.
 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////

#include "x2_inc_compon"
#include "x0_i0_spawncond"
#include "inc_bloodbag"

void main()
{
    object oPC = GetFirstPC();

    SetLocalInt(oPC, "ac_davey_quest", 6);

    string sJournal = "j51"; // relevant quest
    string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);

    int iState = GetLocalInt(oPC, sJournalVar);

    if(iState > 0 && iState < 4)
    {
        AddJournalQuestEntry(sJournal, 6, oPC);
    }
}
