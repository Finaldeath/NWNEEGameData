//Grimswold has been allowed to keep Lashan in the stocks
#include "hf_in_plot"
#include "hf_in_alignment"

void main()
{
    object oPC = GetFirstPC();

    AdjustPlayerAlignment(oPC, ALIGNMENT_EVIL, 1);

    AddJournalQuestEntry("LocktowerRescue", 106, oPC);

    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    PlotLevelSet("LashanStocks", 1);
    PlotLevelSet("Bennart", 2);
}
