// (if you haven't killed any ruffians or Teleth in Rathole,
// NOR have done the Rooster's Roost investigation,
// AND have killed Aladara

#include "ddf_util"

int StartingConditional()
{
    object oModule = GetModule();
    int ruffiansKilled = GetLocalInt(oModule, "ddf_ruffians_death_counter");
    int telethDead = GetLocalInt(oModule, "ddf_teleth_dead");

    if(ruffiansKilled > 0 || telethDead == TRUE) return FALSE;

    if(GetQuestState(AREA_ROOSTERS_ROOST) == INVESTIGATION_COMPLETE) return FALSE;

    if(GetLocalInt(oModule, "ddf_aladara_dead") == FALSE) return FALSE;

    return TRUE;
}