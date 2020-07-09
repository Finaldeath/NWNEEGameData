#include "ddf_util"

int StartingConditional()
{
    if(GetCurrentArea(GetPCSpeaker()) != AREA_MIDTOWN_MUNICIPAL_DISTRICT) return FALSE;

    // check for investigation of this area being "complete"
    if(GetQuestState(AREA_MIDTOWN_MUNICIPAL_DISTRICT) != TRUE) return FALSE;

    // Yeah, you are in the MIDTOWN _and_ have completed the quest
    return TRUE;
}
