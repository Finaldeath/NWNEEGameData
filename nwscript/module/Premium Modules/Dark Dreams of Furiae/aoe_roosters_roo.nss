#include "ddf_util"
#include "ddf_journal"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;

     //SetLocalInt(GetModule(), "ddf_in_area", AREA_ROOSTERS_ROOST);
     SetCurrentArea(oPC, AREA_ROOSTERS_ROOST);
     SetLocalInt(GetModule(), "ddf_visited_roosters_roost", TRUE);

    if(GetIsObjectValid(oPC)) UpdateJournal(oPC);
}
