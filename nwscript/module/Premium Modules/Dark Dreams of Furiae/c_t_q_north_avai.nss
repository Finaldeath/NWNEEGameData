#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_NORTH_MARKET) == INVESTIGATION_AVAILABLE) return TRUE;
    return FALSE;
}
