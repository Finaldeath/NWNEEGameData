// if you haven't done the Rooster's Roost investigation,
// NOR have killed Aladara,
// AND have done the Ulan's Warehouse investigation)

#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_ROOSTERS_ROOST) == INVESTIGATION_COMPLETE) return FALSE;

    object oModule = GetModule();

    if(GetLocalInt(oModule, "ddf_aladara_dead") != FALSE) return FALSE;

    if(GetQuestState(AREA_ULANS_WAREHOUSE) != INVESTIGATION_COMPLETE) return FALSE;

    return TRUE;
}
