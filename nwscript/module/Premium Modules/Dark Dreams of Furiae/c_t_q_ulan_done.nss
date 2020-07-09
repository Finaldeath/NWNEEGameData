#include "ddf_util"
int StartingConditional()
{
    if(GetQuestState(AREA_ULANS_WAREHOUSE) == INVESTIGATION_COMPLETE) return TRUE;
    return FALSE;

}
