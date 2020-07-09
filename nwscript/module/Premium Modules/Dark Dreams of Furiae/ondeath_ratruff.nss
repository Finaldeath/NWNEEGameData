// track the death of the rathole ruffians...
#include "ddf_util"

void main()
{
    // check that we are in one of the "valid" location for tracking the death of the ruffians...
    // AREA_RATHOLE_STREETS
    // AREA_RUN_DOWN_INN
    // AREA_HARASIS_SMALL_APARTMENT
    object oPC = GetLastAttacker();

    int currentArea = GetCurrentArea(oPC);

    if(currentArea == AREA_RATHOLE_STREETS || currentArea == AREA_RUN_DOWN_INN || currentArea == AREA_HARASIS_SMALL_APARTMENT)
    {
        int ruffianDeaths = GetLocalInt(GetModule(), "ddf_ruffian_death_counter");
        SetLocalInt(GetModule(), "ddf_ruffian_death_counter", ruffianDeaths + 1);
        debug("-- setting ddf_ruffian_death_counter to " + IntToString(ruffianDeaths));
    }

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
