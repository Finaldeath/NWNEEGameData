//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ndt_tm_karim
//:: DATE: January 10, 2019
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt - Werebear
//:: OnDeath script for Karim Ninetrees
//::////////////////////////////////////////////////////

#include "hf_in_alignment"
#include "hf_in_plot"

void main()
{
    object oPC = GetFirstPC();

    // Adjust alignment, if it wasn't already adjusted in cac_tm_karim
    // (Happens when bypassing the dialog by attack from radial menu)
    int nOnce = GetLocalInt(OBJECT_SELF, "karim_align_once");
    if (nOnce == 0)
    {
        SetLocalInt(OBJECT_SELF, "karim_align_once", 1);

        AdjustPlayerAlignment(oPC, ALIGNMENT_EVIL, 5);
        // Backstabbing Karim leads to an additional 5 points chaotic
        if (PlotLevelGet("biggamehunt_status_were") >= 1)
        {
            AdjustPlayerAlignment(oPC, ALIGNMENT_CHAOTIC, 5);
        }
    }

    AddJournalQuestEntry("BigGameHunt-Werebear", 20, oPC, TRUE, FALSE, TRUE);
    PlotLevelSet("biggamehunt_status_were", 2);

    // since we're dropping a pelt, let's turn into a bear
    effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    SetCreatureAppearanceType(OBJECT_SELF, APPEARANCE_TYPE_BEAR_KODIAK);

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
