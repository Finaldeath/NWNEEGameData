#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_ROOSTERS_ROOST) == INVESTIGATION_AVAILABLE) return TRUE;
    return FALSE;
}
