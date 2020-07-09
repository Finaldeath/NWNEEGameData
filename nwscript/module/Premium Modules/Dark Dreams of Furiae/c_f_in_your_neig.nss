#include "ddf_util"

int StartingConditional()
{
    if(GetCurrentArea(GetPCSpeaker()) == AREA_YOUR_NEIGHBORHOOD) return FALSE;
    return TRUE;
}
