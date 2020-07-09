//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ndt_tm_unseen0
//:: DATE: January 28, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: The Unseen
//:: OnDeath script for Ootamal and Sabarak
//:: Ends the quest.
//::////////////////////////////////////////////////////

#include "hf_in_plot"


const int NUM_TOTAL_ENEMIES = 2;
const string LVAR_DEAD_ENEMIES = "ndt_tm_unseen0_cnt";


void main()
{
    object oPC = GetFirstPC();

    int nDeadEnemies = GetLocalInt(oPC, LVAR_DEAD_ENEMIES)+1;
    SetLocalInt(oPC, LVAR_DEAD_ENEMIES, nDeadEnemies );

    if ((nDeadEnemies >= NUM_TOTAL_ENEMIES) && (PlotLevelGet("theunseen_status") < 5))
    {
        DeleteLocalInt(oPC, LVAR_DEAD_ENEMIES);

        GiveXPToCreature(oPC, GetJournalQuestExperience("TheUnseen"));
        AddJournalQuestEntry("TheUnseen", 50, oPC);

        PlotLevelSet("theunseen_status", 5);
    }

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
