#include "hf_in_plot"

const string PLOT_HENCH_DIALOG = "plot_hen_dlg_all";

void main()
{
    if (PlotLevelGet(PLOT_HENCH_DIALOG) < 10)
        PlotLevelSet(PLOT_HENCH_DIALOG, 10);

    AddJournalQuestEntry("AssaultonKurTharsu", 10, GetPCSpeaker());
    AddJournalQuestEntry("TharMounts", 10, GetPCSpeaker());
}
