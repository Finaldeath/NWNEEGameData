// (if you haven't done the Soul Trade Inn investigation
// NOR is Quillian dead,
// AND you were helpful*** to Lucenna --  (If you turned Quillian in or gave Lucenna information AND If PC is Good aligned)

#include "ddf_util"

int StartingConditional()
{
    if(GetQuestState(AREA_SOUL_TRADE_INN) == INVESTIGATION_COMPLETE) return FALSE;

    object oModule = GetModule();

    if(GetLocalInt(oModule, "ddf_quillian_dead") == TRUE) return FALSE;
    if(GetLocalInt(oModule, "ddf_killed_quillian") == TRUE) return FALSE;

    if(HelpfulToLucenna(GetPCSpeaker()) != TRUE) return FALSE;

    return TRUE;
}
