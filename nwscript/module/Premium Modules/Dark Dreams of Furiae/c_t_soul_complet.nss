#include "ddf_util"

int StartingConditional()
{
    if(GetCurrentArea(GetPCSpeaker()) != AREA_SOUL_TRADE_INN) return FALSE;

    if(GetQuestState(AREA_SOUL_TRADE_INN) == INVESTIGATION_COMPLETE) return TRUE;

    return FALSE;
}
