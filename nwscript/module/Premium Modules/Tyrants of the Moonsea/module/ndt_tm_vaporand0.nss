//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ndt_tm_vaporand0
//:: DATE: January 10, 2019
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt
//:: Death script for Vaporandir.
//::////////////////////////////////////////////////////

#include "hf_in_alignment"
#include "hf_in_plot"

void main()
{
    object oPC = GetFirstPC();

    // Adjust alignment, if it wasn't already adjusted in cac_tm_vapor1
    // (Happens when bypassing the dialog by attack from radial menu)
    int nOnce = GetLocalInt(OBJECT_SELF, "vaporandir_align_once");
    if (nOnce == 0)
    {
        SetLocalInt(OBJECT_SELF, "vaporandir_align_once", 1);

        AdjustPlayerAlignment(oPC, ALIGNMENT_EVIL, 5);
        // Backstabbing Vaporandir leads to an additional 5 points chaotic
        if (PlotLevelGet("biggamehunt_status_vapo") >= 1)
        {
            AdjustPlayerAlignment(oPC, ALIGNMENT_CHAOTIC, 5);
        }
    }

    // Prevent regression if Vaporandirs tongue has already been delivered.
    if (PlotLevelGet("biggamehunt_status_vapo") < 3)
    {
        AddJournalQuestEntry("BigGameHunt-Vaporandir", 20, oPC, TRUE, FALSE, TRUE);
        PlotLevelSet("biggamehunt_status_vapo", 2);
    }

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
