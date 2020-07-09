//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script for "Astar's Widow"
//::////////////////////////////////////////////////////
//:: Player talks to Chesslyn and makes Rikard
//:: unwelcome in the casino
//:: Rikard disappears.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string NPC_RESREF_RIKARD = "rikard";
const string NPC_TAG_RIKARD = "Rikard";

void main()
{
    object oPC = GetPCSpeaker();
    object oRikard = GetObjectByTag(NPC_TAG_RIKARD);

    PlotLevelSet("AstarsWidow-Status", 6);
    PlotLevelSet(NPC_TAG_RIKARD, 3);  // Rikard dialog branch
    AddJournalQuestEntry("AstarsWidow", 80, oPC);

    GiveXPToCreature(oPC, GetJournalQuestExperience("AstarsWidow"));

    DelayCommand(1.0f, ExecuteScript("hf_cs_exit", oRikard));
}
