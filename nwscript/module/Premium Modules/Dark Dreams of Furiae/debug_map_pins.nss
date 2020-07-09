#include "ddf_journal"
#include "ddf_util"

void main()
{
    debug("-- unlock map pins.");

    object oModule = GetModule();

    debug("-- MP Sea Market");
    SetLocalInt(oModule, "ddf_examined_south_market_deed", TRUE);

    debug("-- MP Your Neighborhood");
    SetLocalInt(oModule, "dlg_quill_001_done", TRUE);
    SetLocalInt(oModule, "ddf_spoke_with_shavann", TRUE);

    debug("-- MP Rathole");
    SetQuestState(AREA_RATHOLE_STREETS, INVESTIGATION_INPROGRESS);
    SetLocalInt(oModule, "dlg_quill_002_done", TRUE);
    SetLocalInt(oModule, "ddf_learn_harasi_day3", TRUE);

    UpdateJournal(GetFirstPC());

}
