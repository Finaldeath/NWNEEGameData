//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script for "Astar's Widow"
//::////////////////////////////////////////////////////
//:: Player intimidates Rikard to stop gambling,
//:: finishes quest.
//:: Rikard disappears.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string NPC_TAG_RIKARD = "Rikard";

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet("AstarsWidow-Status", 7);
    PlotLevelSet(NPC_TAG_RIKARD, 3);  // Rikard dialog branch
    AddJournalQuestEntry("AstarsWidow", 75, oPC);

    GiveXPToCreature(oPC, GetJournalQuestExperience("AstarsWidow"));
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
