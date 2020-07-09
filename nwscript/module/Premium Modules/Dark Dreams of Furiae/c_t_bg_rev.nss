#include "ddf_util"
// Returns true if the user IS a revolutionary

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_background_flag") == BG_REVOLUTIONARY)
        return TRUE;

    return FALSE;
}
