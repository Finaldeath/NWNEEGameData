#include "ddf_journal"

void main()
{
    debug("-- Testing closing Harasi's ");

    IncrementDay();
    IncrementDay();
    IncrementDay();
    IncrementDay();

    SetLocalInt(GetModule(), "ddf_examined_bloody_ledger", TRUE);
    //SetLocalInt(oModule, "ddf_harasi_dead", TRUE);
    //SetLocalInt(oModule, "ddf_confront_harasi", TRUE);

    UpdateJournal(GetFirstPC());

    IncrementDay();

    UpdateJournal(GetFirstPC());
}
