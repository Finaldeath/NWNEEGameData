#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_TEETH_OF_ORISAW) == INVESTIGATION_AVAILABLE) return TRUE;
    return FALSE;
}
