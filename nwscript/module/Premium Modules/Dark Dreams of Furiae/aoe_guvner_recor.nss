#include "ddf_util"
#include "ddf_journal"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;
     //SetLocalInt(GetModule(), "ddf_in_area", AREA_GUVNER_RECORD_BUILDING);
    SetCurrentArea(oPC, AREA_GUVNER_RECORD_BUILDING);
     object oBlocker = GetObjectByTag("RecordsBlocker");
     if(GetIsObjectValid(oBlocker) == FALSE)
     {
        // the blocker has been removed.
        SetLocalInt(GetModule(), "ddf_guvner_gain_entrance", TRUE);
        UpdateJournal(GetFirstPC());
     }
}
