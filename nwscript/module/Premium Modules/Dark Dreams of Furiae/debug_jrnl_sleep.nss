#include "ddf_util"
#include "ddf_journal"

void main()
{
    object oModule = GetModule();
    object oPC = GetFirstPC();

    debug("-- debug Update/Close quest after sleeping, specifically Street Level Ops.");

    IncrementDay();
    IncrementDay();
    //IncrementDay();

    SetLocalInt(oModule, IS_INVESTIGATING, TRUE);
    SetLocalInt(oModule, "dlg_quill_002_done", TRUE);
    SetLocalInt(oModule, "dlg_quill_001_done", TRUE);

    UpdateJournal(oPC);

}
