//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_bghunt_b2
//:: DATE: January 10, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt - Main (Baerdeth)
//:: PC delivers an item (determined by HF_ARG)
//::////////////////////////////////////////////////////

#include "hf_in_plot"

// Remove quest items
const string ITM_TAG_DRAGON_TONGUE = "tm_it_vaptongue0";
const string ITM_TAG_DRAGON_TONGUE_FAKE = "tm_it_vaptongue1";
const string ITM_TAG_WEREBEAR_PELT = "tm_it_karimpelt0";
const string ITM_TAG_WEREBEAR_PELT_FAKE = "tm_it_karimpelt1";
const string ITM_TAG_RENDER_HEAD = "tm_it_renderhea";

// Reward for delivering a single bounty
const int GOLD_REWARD = 2000;


void main()
{
    object oPC = GetPCSpeaker();
    object oItem = OBJECT_INVALID;
    int nRewardXP = 0;
    int nHF_ARG = GetLocalInt(OBJECT_SELF, "HF_ARG");

    // Remove quest items
    // - Use HF_ARG to keep all tags/ resrefs in single script
    // - Prefer the fake rewards over the real ones (if both are present)
    switch (nHF_ARG)
    {
        case 1: // PC delivers dragon tongue
        {
            oItem = GetObjectByTag(ITM_TAG_DRAGON_TONGUE_FAKE);
            if (!GetIsObjectValid(oItem))
                oItem = GetObjectByTag(ITM_TAG_DRAGON_TONGUE);
            if (GetIsObjectValid(oItem))
            {
                DestroyObject(oItem);

                PlotLevelSet("biggamehunt_status_vapo", 3);
                AddJournalQuestEntry("BigGameHunt-Vaporandir", 50, oPC);

                nRewardXP = GetJournalQuestExperience("BigGameHunt-Vaporandir");
                GiveXPToCreature(oPC, nRewardXP);
                GiveGoldToCreature(oPC, GOLD_REWARD);
            }
            break;
        }
        case 2: // PC delivers werepbear pelt
        {
            oItem = GetObjectByTag(ITM_TAG_WEREBEAR_PELT_FAKE);
            if (!GetIsObjectValid(oItem))
                oItem = GetObjectByTag(ITM_TAG_WEREBEAR_PELT);
            if (GetIsObjectValid(oItem))
            {
                DestroyObject(oItem);

                PlotLevelSet("biggamehunt_status_were", 3);
                AddJournalQuestEntry("BigGameHunt-Werebear", 50, oPC);

                nRewardXP = GetJournalQuestExperience("BigGameHunt-Werebear");
                GiveXPToCreature(oPC, nRewardXP);
                GiveGoldToCreature(oPC, GOLD_REWARD);
            }
            break;
        }
        case 3: // PC delivers render head
        {
            oItem = GetObjectByTag(ITM_TAG_RENDER_HEAD);
            if (GetIsObjectValid(oItem))
            {
                DestroyObject(oItem);

                PlotLevelSet("biggamehunt_status_rend", 3);
                AddJournalQuestEntry("BigGameHunt-Render", 30, oPC);

                nRewardXP = GetJournalQuestExperience("BigGameHunt-Render");
                GiveXPToCreature(oPC, nRewardXP);
                GiveGoldToCreature(oPC, GOLD_REWARD);
            }
            break;
        }
        default: // Error
        {
            break;
        }
    }

    // Advance Main Quest if all items have been delivered
    if ((PlotLevelGet("biggamehunt_status_vapo") >= 3) &&
        (PlotLevelGet("biggamehunt_status_were") >= 3) &&
        (PlotLevelGet("biggamehunt_status_rend") >= 3) )
    {
        PlotLevelSet("biggamehunt_status_main", 2);
        AddJournalQuestEntry("BigGameHunt", 120, oPC);
    }
}
