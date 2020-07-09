#include "ddf_util"

int StartingConditional()
{
    if(GetCurrentArea(GetPCSpeaker()) != AREA_ROOSTERS_ROOST) return FALSE;

    if(GetQuestState(AREA_ROOSTERS_ROOST) == INVESTIGATION_COMPLETE) return TRUE;

    return FALSE;
}
