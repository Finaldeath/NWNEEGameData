#include "ddf_util"
#include "ddf_journal"
#include "x0_i0_partywide"

void main()
{
    object oPC = GetPCSpeaker();

    if(MovePartyToObject(oPC, GetObjectByTag("UlansWarehouseArrivalFront")))
    {
        SetQuestState(AREA_ULANS_WAREHOUSE, INVESTIGATION_INPROGRESS);
        SetLocalInt(GetModule(), IS_INVESTIGATING, TRUE);
        SetLocalInt(GetModule(), "ddf_entered_ulan_warehouse", TRUE);
        //GiveXPToAll(oPC, XP_SMALL);
        UpdateJournal(oPC);
    }
}
