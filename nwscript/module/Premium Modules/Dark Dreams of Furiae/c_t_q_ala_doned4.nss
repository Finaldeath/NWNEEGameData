#include "ddf_util"

int StartingConditional()
{
    if(GetQuestDoneDate(AREA_NORTH_MARKET) == 4) return TRUE;
    return FALSE;
}
