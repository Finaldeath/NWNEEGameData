// HAVE done the corano investigation
#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_TEETH_OF_ORISAW) == INVESTIGATION_COMPLETE) return TRUE;

    return FALSE;
}
