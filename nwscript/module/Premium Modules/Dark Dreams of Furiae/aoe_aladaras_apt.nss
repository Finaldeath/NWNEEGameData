#include "ddf_util"
#include "ddf_journal"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;
    //SetLocalInt(GetModule(), "ddf_in_area", AREA_ALADARAS_APARTMENT);
    SetCurrentArea(oPC, AREA_ALADARAS_APARTMENT);
    SetLocalInt(GetModule(), "ddf_visited_aladaras_apartment", TRUE);
    UpdateJournal(oPC);
}
