// if you did NOT do the Soul Trade investigation
#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_SOUL_TRADE_INN) == INVESTIGATION_COMPLETE) return FALSE;
    return TRUE;
}
