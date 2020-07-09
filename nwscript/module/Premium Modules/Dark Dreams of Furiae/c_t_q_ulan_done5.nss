#include "ddf_util"
int StartingConditional()
{
    if(GetQuestDoneDate(AREA_ULANS_WAREHOUSE) == 5) return TRUE;
    return FALSE;

}
