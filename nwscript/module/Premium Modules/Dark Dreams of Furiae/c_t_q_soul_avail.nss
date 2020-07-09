#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_SOUL_TRADE_INN) == INVESTIGATION_AVAILABLE) return TRUE;
    return FALSE;
}
