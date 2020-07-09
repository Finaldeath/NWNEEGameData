#include "ddf_util"

int StartingConditional()
{
    if(GetCurrentArea(GetPCSpeaker()) != AREA_TEETH_OF_ORISAW ) return FALSE;

    // check for investigation of this area being "complete"
    if(GetQuestState(AREA_TEETH_OF_ORISAW ) == INVESTIGATION_COMPLETE) return FALSE;

    // Yeah, you are in the teeth _and_ have NOT completed the quest
    return TRUE;
}
