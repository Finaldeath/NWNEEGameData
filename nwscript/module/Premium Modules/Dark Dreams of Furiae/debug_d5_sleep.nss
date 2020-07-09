#include "ddf_util"
#include "ddf_journal"

void main()
{
    object oModule = GetModule();
    object oPC = GetFirstPC();

    debug("TESTING completing ulan, then sleeping.");
    SetLocalInt(oModule, "DDF_CURRENT_DAY", 5);
    SetLocalInt(oModule, IS_INVESTIGATING, TRUE);
    SetLocalInt(oModule, "ddf_examined_south_market_deed", TRUE);

    object oRing = CreateItemOnObject("ringofsending", oPC, 1, "RING_ULAN");

    UpdateJournal(oPC);
}
