// (if you haven't done the Soul Trade Inn investigation
// NOR is Quillian dead,
// NOR were you helpful*** to Lucenna
// AND you are law enforcement)



#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_SOUL_TRADE_INN) == INVESTIGATION_COMPLETE) return FALSE;

    object oModule = GetModule();

    if(GetLocalInt(oModule, "ddf_quillian_dead") == TRUE) return FALSE;
    if(GetLocalInt(oModule, "ddf_killed_quillian") == TRUE) return FALSE;

    if(HelpfulToLucenna(GetPCSpeaker()) == TRUE) return FALSE;

    if(GetLocalInt(oModule, "ddf_background_flag") !=  BG_COP) return FALSE;

    return TRUE;
}