#include "ddf_journal"

void main()
{
    debug("-- Test existing Harasi's small apartment.");

    SetLocalInt(GetModule(), "ddf_visited_harasis_small_apartment", FALSE);

    TryUnlockHarasisSmallApartment();

}
