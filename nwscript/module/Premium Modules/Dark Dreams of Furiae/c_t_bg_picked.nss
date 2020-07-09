#include "ddf_util"

int StartingConditional()
{
    int iBG = GetLocalInt(GetModule(), "ddf_background_flag");

    debug("-- bg flag: " + IntToString(iBG));

    // No background has been picked
    if(iBG == 0) return FALSE;

   // Background has already been picked
   return TRUE;
}
