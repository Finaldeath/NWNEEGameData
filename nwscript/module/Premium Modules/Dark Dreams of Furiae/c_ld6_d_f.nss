// (if you haven't done the Rooster's Roost investigation,
// AND have killed Aladara)

#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_ROOSTERS_ROOST) == INVESTIGATION_COMPLETE) return FALSE;

    object oModule = GetModule();

    if(GetLocalInt(oModule, "ddf_aladara_dead") == FALSE) return FALSE;

    return TRUE;
}
