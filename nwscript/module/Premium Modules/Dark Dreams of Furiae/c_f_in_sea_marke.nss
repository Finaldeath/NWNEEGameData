#include "ddf_util"

int StartingConditional()
{
    if(GetCurrentArea(GetPCSpeaker()) == AREA_SEA_MARKET) return FALSE;
    return TRUE;
}
