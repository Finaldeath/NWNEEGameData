// if you did ULAN
// AND Soul Trade Inn
#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_ULANS_WAREHOUSE) != INVESTIGATION_COMPLETE) return FALSE;
    if(GetQuestState(AREA_SOUL_TRADE_INN) != INVESTIGATION_COMPLETE) return FALSE;
    return TRUE;
}
