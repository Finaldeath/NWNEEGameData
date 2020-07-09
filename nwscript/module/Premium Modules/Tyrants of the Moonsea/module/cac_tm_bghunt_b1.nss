//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_bghunt_b1
//:: DATE: January 10, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt - Main (Baerdeth)
//:: PC accepts Quest
//::////////////////////////////////////////////////////

#include "hf_in_plot"

// Items to lure NPC
const string ITM_RESREF_ELVEN_BLOOD = "vialofelvenblood";
const string ITM_TAG_ELVEN_BLOOD = "VialofElvenBlood";

const string ITM_RESREF_DRAGON_EGG = "dragonegg";
const string ITM_TAG_DRAGON_EGG = "DragonEgg";

// Triggers that makes Vaporandir and the Grey Render appear
const string TRG_TAG_RENDER = "TRG_bghunt_render";
const string TRG_TAG_VAPORANDIR = "TRG_cut_vaporand0";

void main()
{
    object oPC = GetPCSpeaker();
    object oTrigger = OBJECT_INVALID;

    PlotLevelSet("biggamehunt_status_main", 1);

    // Add Journal Entries for all sub-quests/ creatures
    AddJournalQuestEntry("BigGameHunt", 10, oPC);
    AddJournalQuestEntry("BigGameHunt-Render", 10, oPC);
    AddJournalQuestEntry("BigGameHunt-Werebear", 10, oPC);
    AddJournalQuestEntry("BigGameHunt-Vaporandir", 10, oPC);

    // Add items to lure creatures
    CreateItemOnObject(ITM_RESREF_ELVEN_BLOOD, oPC, 1);
    CreateItemOnObject(ITM_RESREF_DRAGON_EGG, oPC, 1);

    // Activate triggers that spawn the creature
    // (lures are technically not needed to do to that)
    oTrigger = GetObjectByTag(TRG_TAG_RENDER);
    SetLocalInt(oTrigger, "nDone", 0);

    oTrigger = GetObjectByTag(TRG_TAG_VAPORANDIR);
    SetLocalInt(oTrigger, "nDone", 0);
}
