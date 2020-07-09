// if you did NOT do the ULAN investigation
#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_ULANS_WAREHOUSE) == INVESTIGATION_COMPLETE) return FALSE;
    return TRUE;
}
