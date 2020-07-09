// (if you have done the Soul Trade Inn investigation)

#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_SOUL_TRADE_INN) == INVESTIGATION_COMPLETE) return TRUE;


    return FALSE;
}
