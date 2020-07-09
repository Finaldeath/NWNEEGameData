#include "ddf_util"

int StartingConditional()
{
    if(GetCurrentArea(GetPCSpeaker()) != AREA_RATHOLE_STREETS ) return FALSE;

    // check for investigation of this area being "complete"
    if(GetQuestState(AREA_RATHOLE_STREETS ) == TRUE) return FALSE;

    // Yeah, you are in the MIDTOWN _and_ have NOT completed the quest
    return TRUE;
}
