//      if you haven't done the Corano Villa investigation, AND have killed any ruffians or Teleth in Rathole
#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_TEETH_OF_ORISAW) == INVESTIGATION_COMPLETE) return FALSE;

    object oModule = GetModule();
    int ruffiansKilled = GetLocalInt(oModule, "ddf_ruffians_death_counter");
    int telethDead = GetLocalInt(oModule, "ddf_teleth_dead");

    if(ruffiansKilled == 0 && telethDead == 0) return FALSE;

    return TRUE;
}
