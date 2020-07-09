//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_tdjrnl
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: If player is entering trigger for the first
//       time, finish The Arena quest with a 3,500
//       xp reward and jump Blizzard to area (if she
//       still lives.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_plot"
#include "cut_tm_arena_inc"
#include "hf_in_cutscene"


// Make Elf unequip his Weapons while being a slave
void ElfUnequipWeapons(object oTarget)
{
    object oItem = OBJECT_INVALID;

    // Left Hand
    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
    if (GetIsObjectValid(oItem))
        AssignCommand(oTarget, ActionUnequipItem(oItem));

    // Right Hand
    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
    if (GetIsObjectValid(oItem))
        AssignCommand(oTarget, ActionUnequipItem(oItem));
}


void main()
{
    object oPC = GetEnteringObject();
    object oBlizzard = OBJECT_INVALID;
    object oElf = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    if (GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "fired") == 0) &&
        GetLocalInt(oPC, "hillsfarpass") == 1)
    {
        SetLocalInt(OBJECT_SELF, "fired", 1);
        AddJournalQuestEntry("TheArena", 110, oPC, TRUE, FALSE);
        GiveXPToCreature(oPC, GetJournalQuestExperience("TheArena"));

        // Handle Blizzard
        // Remove the Blizzard NPC from the arena cells
        oBlizzard = GetNearestObjectByTag(NPC_TAG_BLIZZARD, GetWaypointByTag(WP_TAG_BLIZZARD_CELLS));
        if (GetIsObjectValid(oBlizzard))
            DestroyObject(oBlizzard);
        if (PlotLevelGet("Blizzard-Arena-Outcome") == 2)
        {
            // Blizzard was killed during arena

            // Advance Plot level to 8, skipping further Hillsfar conversations
            PlotLevelSet(NPC_TAG_BLIZZARD, 8);
            // Create a new Blizzard directly in Melvaunt - Breakwater Inn
            oWaypoint = GetWaypointByTag(WP_TAG_BLIZZARD_MELVAUNT);
            CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_BLIZZARD, GetLocation(oWaypoint));
        }
        else
        {
            // Blizzard survived the arena

            // Set conversation plot level
            PlotLevelSet(NPC_TAG_BLIZZARD, 7);
            // Make her appear in Hillfar temple district to talk to the PC
            CutscenePlay(oPC, "cut_tm_tdbliz");
        }

        // Handle Elf

        // Update his quest in case he wasn't talked do in the arena cells and left alive
        if (PlotLevelCheckEquals("Elf-Arena-Outcome", 0) && (PlotLevelGet(NPC_TAG_ELF) < 7))
        {
            AddJournalQuestEntry("HillsfarArenaElf", 30, oPC);
            GiveXPToCreature(oPC, GetJournalQuestExperience("HillsfarArenaElf"));
        }
        // Advance Plot level to 8, skipping Hillsfar conversations
        PlotLevelSet(NPC_TAG_ELF, 8);
        // Remove the Elf NPC from the arena cells
        oElf = GetNearestObjectByTag(NPC_TAG_ELF, GetWaypointByTag(WP_TAG_ELF_CELLS));
        if (GetIsObjectValid(oElf))
            DestroyObject(oElf);
        // Create a new Elf at Melvaunt
        oWaypoint = GetWaypointByTag(WP_TAG_ELF_MELVAUNT);
        oElf = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_ELF, GetLocation(oWaypoint), FALSE, NPC_TAG_ELF);
        ElfUnequipWeapons(oElf);
    }
}
