#include "ddf_util"

void main()
{
    debug("-- remove Ulan from Undercity.");
    IncrementDay();
    IncrementDay();
    IncrementDay();
    IncrementDay();

    SetQuestState(AREA_ULANS_WAREHOUSE, INVESTIGATION_COMPLETE);

    IncrementDay();

}
