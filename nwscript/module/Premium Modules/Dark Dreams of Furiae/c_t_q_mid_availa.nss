#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_MIDTOWN_MUNICIPAL_DISTRICT) == INVESTIGATION_AVAILABLE) return TRUE;
    return FALSE;
}
