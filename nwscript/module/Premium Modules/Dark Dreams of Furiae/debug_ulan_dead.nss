#include "ddf_util"

void main()
{
    debug("-- Testing day 5 Ulan Warehouse quest. Ulan NOT DEAD.");

    IncrementDay();
    IncrementDay();
    IncrementDay();
    IncrementDay();

    SetQuestState(AREA_ULANS_WAREHOUSE, INVESTIGATION_COMPLETE);

    SetLocalInt(GetModule(), "ddf_examined_south_market_deed", TRUE);

    debug("*** ULAN NOT DEAD ***");

    SetLocalInt(GetModule(), "ddf_deal_with_ulan", TRUE);
    SetLocalInt(GetModule(), "ddf_ulan_dead", FALSE);
    SetLocalInt(GetModule(), "ddf_ulan_knocked_out", TRUE);

    //SetLocalInt(GetModule(), INVESTIGATION_VAR + IntToString(AREA_ULANS_WAREHOUSE), INVESTIGATION_AVAILABLE);

    //IncrementDay();

}
