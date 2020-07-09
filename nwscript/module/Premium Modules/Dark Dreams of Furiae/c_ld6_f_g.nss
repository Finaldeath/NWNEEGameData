// (if you have done the Ulan's Warehouse investigation)

#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_ULANS_WAREHOUSE) != INVESTIGATION_COMPLETE) return FALSE;

    return TRUE;
}
