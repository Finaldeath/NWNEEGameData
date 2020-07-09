#include "ddf_util"
int StartingConditional()
{
    if(GetQuestDoneDate(AREA_ULANS_WAREHOUSE) == 4) return TRUE;
    return FALSE;

}
