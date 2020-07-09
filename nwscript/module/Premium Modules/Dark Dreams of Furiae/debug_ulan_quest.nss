#include "ddf_util"

void main()
{
    debug("-- Testing day 4 Ulan Warehouse quest. Does he drop the ring?");

    IncrementDay();
    IncrementDay();
    //IncrementDay();

    SetLocalInt(GetModule(), "ddf_examined_south_market_deed", TRUE);
    SetLocalInt(GetModule(), INVESTIGATION_VAR + IntToString(AREA_ULANS_WAREHOUSE), INVESTIGATION_AVAILABLE);

    IncrementDay();

}
