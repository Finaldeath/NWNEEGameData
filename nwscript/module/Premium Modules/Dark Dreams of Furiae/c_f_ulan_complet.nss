#include "ddf_util"

int StartingConditional()
{
    if(GetCurrentArea(GetPCSpeaker()) != AREA_ULANS_WAREHOUSE ) return FALSE;

    // check for investigation of this area being "complete"
    if(GetQuestState(AREA_ULANS_WAREHOUSE ) == INVESTIGATION_COMPLETE) return FALSE;

    // Yeah, you are in the AREA_NORTH_MARKET _and_ have NOT completed the quest
    return TRUE;
}
