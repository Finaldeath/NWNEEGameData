//Elf leaves Scarred Lands and awaits PC at Kur-Tharsu Main Gate
#include "hf_in_plot"

void main()
{
    object oDirector = GetObjectByTag("KTDirector");

    //Don't let Elf be killed while exiting
    SetPlotFlag(OBJECT_SELF, TRUE);
    DeleteLocalObject(oDirector, "oElf");
    SetLocalString(OBJECT_SELF, "HF_EXIT_NAME", "WP_TH_SCL_EXIT_ELF");
    PlotLevelSet(GetTag(OBJECT_SELF), 15);
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
