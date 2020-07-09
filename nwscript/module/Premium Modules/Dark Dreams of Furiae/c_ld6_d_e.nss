// (if you have done the Rooster's Roost investigation)

#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_ROOSTERS_ROOST) == INVESTIGATION_COMPLETE) return TRUE;
    return FALSE;
}
