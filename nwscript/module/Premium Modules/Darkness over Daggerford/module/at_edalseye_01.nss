// edalseye gets ready to leave the nine hells

#include "hf_in_plot"

void main()
{
    PlotLevelSet("ks_edalseye", 3);

    // walk towards the portal
    string sQuote = GetLocalString(GetModule(), "QUOTE");
    AssignCommand(OBJECT_SELF, ActionSpeakString(sQuote+"Follow me."+sQuote));
    SetLocalString(OBJECT_SELF, "HF_EXIT_NAME", "WP_AR1110_EDALSEYE_EXIT");
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
