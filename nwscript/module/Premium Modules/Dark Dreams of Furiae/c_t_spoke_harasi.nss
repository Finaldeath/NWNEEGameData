#include "ddf_util"
int StartingConditional()
{
    if(GetCurrentDay() == 1 && GetLocalInt(OBJECT_SELF, "spokeD1") == TRUE) return TRUE;
    return FALSE;
}
