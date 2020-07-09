// (if you haven't killed Aladara,
// AND have done the Ulan's Warehouse investigation)

#include "ddf_util"

int StartingConditional()
{
    object oModule = GetModule();

    if(GetLocalInt(oModule, "ddf_aladara_dead") == TRUE) return FALSE;

    if(GetQuestState(AREA_ULANS_WAREHOUSE) != INVESTIGATION_COMPLETE) return FALSE;

    return TRUE;
}
