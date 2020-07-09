#include "ddf_journal"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;

    SetLocalInt(GetModule(), "ddf_visited_soul_trade_inn_wing", TRUE);
    UpdateJournal(oPC);

}
