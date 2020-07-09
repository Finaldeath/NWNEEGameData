//Sets plot variable on Thoyana to indicate PC has been told of murder,
//and who to talk to

#include "hf_in_plot"

const string PLOT_HENCH_DIALOG = "plot_hen_dlg_all";

void main()
{
    PlotLevelSet(GetTag(OBJECT_SELF), 1);

    // Set Henchman dialog status (knows about elmwood murders)
    if (PlotLevelGet(PLOT_HENCH_DIALOG) < 7)
        PlotLevelSet(PLOT_HENCH_DIALOG, 7);

    AddJournalQuestEntry("MurderInElmwood", 20, GetPCSpeaker());
}
