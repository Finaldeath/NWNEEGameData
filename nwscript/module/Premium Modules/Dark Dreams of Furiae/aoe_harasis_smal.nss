#include "ddf_util"
#include "ddf_journal"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;

    int iPreviousArea = GetCurrentArea(oPC);// GetLocalInt(GetModule(), "ddf_in_area");

    // need to check from where we are entering.
    if(iPreviousArea == AREA_RATHOLE_STREETS)
    {
        SetLocalInt(GetModule(), "ddf_visited_harasi_day2", TRUE);
    }
    else if(iPreviousArea == AREA_ROOSTERS_ROOST)
    {
        SetLocalInt(GetModule(), "ddf_visited_harasi_day3", TRUE);
    }

    //SetLocalInt(GetModule(), "ddf_in_area", AREA_HARASIS_SMALL_APARTMENT);
    SetCurrentArea(oPC, AREA_HARASIS_SMALL_APARTMENT);
    SetLocalInt(GetModule(), "ddf_visited_harasis_small_apartment", TRUE);
    UpdateJournal(oPC);
}
