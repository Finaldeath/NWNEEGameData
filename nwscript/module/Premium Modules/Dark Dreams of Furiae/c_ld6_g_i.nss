// (if you haven't done the Soul Trade Inn investigation
// AND Quillian is dead)

#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_SOUL_TRADE_INN) == INVESTIGATION_COMPLETE) return FALSE;

    object oModule = GetModule();

    if(GetLocalInt(oModule, "ddf_quillian_dead") == TRUE) return TRUE;
    if(GetLocalInt(oModule, "ddf_killed_quillian") == TRUE) return TRUE;


    return FALSE;
}
