#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_NORTH_MARKET) == INVESTIGATION_COMPLETE) return TRUE;
    return FALSE;
}
