#include "ddf_util"
#include "ddf_journal"

void main()
{
    object oModule = GetModule();
    object oPC = GetFirstPC();

    IncrementDay();  // 1 > 2
    IncrementDay(); // 2 > 3
    IncrementDay(); // 3 > 4


    SetQuestState(AREA_NORTH_MARKET, INVESTIGATION_COMPLETE);
    SetQuestState(AREA_ULANS_WAREHOUSE, INVESTIGATION_COMPLETE);

    IncrementDay(); // 4 > 5

}
