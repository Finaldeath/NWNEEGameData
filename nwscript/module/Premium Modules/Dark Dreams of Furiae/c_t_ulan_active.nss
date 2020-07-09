#include "ddf_util"

int StartingConditional()
{
    int iQuestState = GetQuestState(AREA_ULANS_WAREHOUSE);

    if(iQuestState == INVESTIGATION_INPROGRESS || iQuestState == INVESTIGATION_AVAILABLE) return TRUE;
    return FALSE;
}
