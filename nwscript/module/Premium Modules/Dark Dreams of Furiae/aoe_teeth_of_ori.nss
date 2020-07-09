#include "ddf_util"
#include "ddf_journal"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;
     //SetLocalInt(GetModule(), "ddf_in_area", AREA_TEETH_OF_ORISAW);
    SetCurrentArea(oPC, AREA_TEETH_OF_ORISAW);
     SetLocalInt(GetModule(), "ddf_visited_teeth_of_orisaw", TRUE);

     UpdateJournal(oPC);
}
