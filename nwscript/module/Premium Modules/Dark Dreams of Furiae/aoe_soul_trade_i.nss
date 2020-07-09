#include "ddf_journal"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;
    //SetLocalInt(GetModule(), "ddf_in_area", AREA_SOUL_TRADE_INN);
    SetCurrentArea(oPC, AREA_SOUL_TRADE_INN);

    SetLocalInt(GetModule(), "ddf_visited_soul_trade_inn", TRUE);
    UpdateJournal(oPC);
}
