#include "ddf_util"

int StartingConditional()
{
    if(GetCurrentDay() > 1) return FALSE;

    object oTeddy = GetObjectByTag("DDF_NPC_Teddy");
    if(GetLocalInt(oTeddy, "teddy_arrived_warehouse") == TRUE) return FALSE;
    if(GetLocalInt(oTeddy, "teddy_run_warehouse") == TRUE) return TRUE;
    return FALSE;
}
