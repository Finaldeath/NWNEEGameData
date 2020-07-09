#include "ddf_util"

int StartingConditional()
{
    if(GetCurrentArea(GetPCSpeaker()) != AREA_NORTH_MARKET ) return FALSE;

    // check for investigation of this area being "complete"
    if(GetQuestState(AREA_NORTH_MARKET ) == TRUE) return FALSE;

    // Yeah, you are in the AREA_NORTH_MARKET _and_ have NOT completed the quest
    return TRUE;
}
