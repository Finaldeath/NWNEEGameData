// player attacks vaporandir

#include "hf_in_alignment"
#include "hf_in_plot"


void main()
{
    object oPC = GetPCSpeaker();

    // Make sure to only do this once. This will also be
    // applied in ndt_tm_vaporand0 if not already done
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

    ExecuteScript("hf_ut_hostile", OBJECT_SELF);
}
