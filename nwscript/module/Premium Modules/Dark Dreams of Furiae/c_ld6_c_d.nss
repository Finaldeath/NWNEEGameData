// (if you have killed any ruffians or Teleth in Rathole)
#include "ddf_util"

int StartingConditional()
{
    object oModule = GetModule();
    int ruffiansKilled = GetLocalInt(oModule, "ddf_ruffians_death_counter");
    int telethDead = GetLocalInt(oModule, "ddf_teleth_dead");

    if(ruffiansKilled == 0 || telethDead == FALSE) return FALSE;

    return TRUE;
}
