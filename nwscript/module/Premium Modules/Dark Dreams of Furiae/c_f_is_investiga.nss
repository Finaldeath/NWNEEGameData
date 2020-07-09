#include "ddf_util"

int StartingConditional()
{
    // is the player already in/doing an investigation?
    if(GetLocalInt(GetModule(), IS_INVESTIGATING) != TRUE) return TRUE;
    return FALSE;
}
