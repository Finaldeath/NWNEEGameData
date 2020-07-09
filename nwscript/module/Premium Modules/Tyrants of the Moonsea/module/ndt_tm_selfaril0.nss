//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ndt_tm_selfaril
//:: DATE: January 30, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Thayan Ambassador
//:: OnDeath script for Selfaril, Quest fails
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetFirstPC();

    // AddJournalQuestEntry("TheUnseen", 50, oPC);

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
