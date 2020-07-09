#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_RATHOLE_STREETS) == INVESTIGATION_AVAILABLE) return TRUE;
    return FALSE;
}
