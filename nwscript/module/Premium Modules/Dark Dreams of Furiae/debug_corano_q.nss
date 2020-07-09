#include "ddf_journal"

void main()
{
    debug("-- debugging teeth of orisaw...");

    IncrementDay(); // day 2
    IncrementDay(); // day 3

    // unlock teeth quest.
    SetLocalInt(GetModule(), "ddf_property_deed", TRUE);

    UpdateJournal(GetFirstPC());
}
