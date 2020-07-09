#include "ddf_util"
#include "ddf_journal"

void main()
{
    object oModule = GetModule();
    object oPC = GetFirstPC();

    IncrementDay();
    UpdateJournal(oPC);

    IncrementDay();
    UpdateJournal(oPC);

    IncrementDay();
    UpdateJournal(oPC);

    IncrementDay();
    UpdateJournal(oPC);


    debug("-- incrementing day to: " + IntToString(GetCurrentDay()));


}
