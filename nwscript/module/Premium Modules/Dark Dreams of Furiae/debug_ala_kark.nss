#include "ddf_journal"

void main()
{
    debug("-- testing Aladara in Kark Lair.");
    IncrementDay(); // 2
    IncrementDay(); // 3
    IncrementDay(); // 4
    IncrementDay(); // 5

    SetQuestState(AREA_NORTH_MARKET, INVESTIGATION_COMPLETE);

    IncrementDay(); // 6.

    UpdateJournal(GetFirstPC());
}
