//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script for "Astar's Widow"
//::////////////////////////////////////////////////////
//:: Player convices Rikard to stop gambling,
//:: finishes quest.
//:: Best outcome, Rikard leaves for the Graysteel
//:: residence.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string NPC_RESREF_RIKARD = "rikard";
const string NPC_TAG_RIKARD = "Rikard";
const string WP_TAG_RIKARD_HOME = "WP_mul_zhq_rikard_home";

void main()
{
    object oPC = GetPCSpeaker();
    object oWpRikardHome = GetWaypointByTag(WP_TAG_RIKARD_HOME);

    PlotLevelSet("AstarsWidow-Status", 8);
    PlotLevelSet(NPC_TAG_RIKARD, 2);  // Rikard dialog branch
    AddJournalQuestEntry("AstarsWidow", 70, oPC);

    GiveXPToCreature(oPC, GetJournalQuestExperience("AstarsWidow"));
    ExecuteScript("hf_cs_exit", OBJECT_SELF);

    CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_RIKARD, GetLocation(oWpRikardHome));
}
