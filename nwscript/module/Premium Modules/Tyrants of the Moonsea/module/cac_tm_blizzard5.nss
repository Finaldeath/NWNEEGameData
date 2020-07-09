//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Finishes Quest "Hillsfar Arena: Blizzard"
//::////////////////////////////////////////////////////
//:: Quest "Hillsfar Arena: Blizzard" completed
//:: - Blizzard leaves
//:: - Create a new Blizzard at Melvaunt
//:: - Move Elf to Melvaunt if still alive
//::////////////////////////////////////////////////////

#include "hf_in_plot"
#include "cut_tm_arena_inc"
#include "hf_in_cutscene"

const string LVAR_BLIZZARD_ARENA_OUTCOME = "Blizzard-Arena-Outcome";

void main()
{
    object oPC = GetPCSpeaker();
    object oWaypoint = OBJECT_INVALID;
    object oBlizzard = OBJECT_SELF;


    int nUnfriendlyPC = GetLocalInt(oBlizzard, "HF_ARG");
    if (nUnfriendlyPC == 1)
    {
        // PC let Blizzard live, unfriendly in dialog
        PlotLevelSet(LVAR_BLIZZARD_ARENA_OUTCOME, 1);
        AddJournalQuestEntry("HillsfarArenaBlizzard", 40, oPC);
    }
    else
    {
        // PC let Blizzard live, friendly in dialog
        PlotLevelSet(LVAR_BLIZZARD_ARENA_OUTCOME, 0);
        AddJournalQuestEntry("HillsfarArenaBlizzard", 50, oPC);
    }

    GiveXPToCreature(oPC, 1500);
    PlotLevelSet(NPC_TAG_BLIZZARD, 8);

    // End the cutscene that started this convo
    CutsceneEnd();

    // Blizzard leaves
    ExecuteScript("hf_cs_exit", oBlizzard);
    // Create new Blizzard in Melvaut
    oWaypoint = GetWaypointByTag(WP_TAG_BLIZZARD_MELVAUNT);
    CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_BLIZZARD, GetLocation(oWaypoint));
}
