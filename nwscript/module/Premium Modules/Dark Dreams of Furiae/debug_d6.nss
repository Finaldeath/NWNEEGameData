#include "ddf_util"
#include "ddf_journal"

void main()
{
    debug("-- setting current day to 6...");

    object oModule = GetModule();
    object oPC = GetFirstPC();

    SetLocalInt(oModule, "ddf_debug_mode", 1);

    SetLocalInt(oModule, "DDF_CURRENT_DAY", 1);
    int i;
    for(i = 1; i < 6; i++)
    {
        IncrementDay();
        UpdateJournal(oPC);
    }
}
