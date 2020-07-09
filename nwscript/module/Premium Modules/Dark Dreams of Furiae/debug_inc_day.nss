#include "ddf_util"
#include "ddf_journal"

void main()
{
    debug("-- incrementing day from " + IntToString(GetCurrentDay()));

    object oModule = GetModule();
    object oPC = GetFirstPC();

    IncrementDay();
    UpdateJournal(oPC);

}
