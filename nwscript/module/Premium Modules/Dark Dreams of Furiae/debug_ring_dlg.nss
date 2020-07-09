#include "ddf_util"

void main()
{
    debug("-- Testing day 5 Ring Of Sending dialog.");

    SetLocalInt(GetModule(), "DDF_CURRENT_DAY", 5);
    SetLocalInt(GetModule(), IS_INVESTIGATING, TRUE);
    SetLocalInt(GetModule(), "ddf_ring_dialog_complete", FALSE);

    SetQuestState(AREA_NORTH_MARKET, INVESTIGATION_COMPLETE);
    SetQuestState(AREA_ULANS_WAREHOUSE, INVESTIGATION_COMPLETE);
    SetQuestState(AREA_SOUL_TRADE_INN, INVESTIGATION_COMPLETE);
}
