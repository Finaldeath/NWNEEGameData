#include "ddf_util"
#include "ddf_journal"

void main()
{
    object oModule = GetModule();

    debug("-- Opening Harasi's Small Apartment, Rathole.");
    SetLocalInt(oModule, "dlg_quill_002_done", TRUE);
    SetLocalInt(oModule, "ddf_learn_harasi_day3", TRUE);

    debug("-- Opening Harasi's Small Apartment, Roosters.");
    SetLocalInt(oModule, "ddf_examined_bottle_worldwine", TRUE);
    SetLocalInt(oModule, "ddf_learn_harasi_dealers", TRUE);

    UpdateJournal(GetFirstPC());

}
