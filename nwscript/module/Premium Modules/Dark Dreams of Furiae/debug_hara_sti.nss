#include "ddf_journal"

void main()
{
    debug("-- Getting Harasi into the STI apartment, Day 5.");
    IncrementDay();
    IncrementDay();
    IncrementDay();
    IncrementDay();
    SetQuestState(AREA_SOUL_TRADE_INN, INVESTIGATION_INPROGRESS);
    UpdateJournal(GetFirstPC());

}
