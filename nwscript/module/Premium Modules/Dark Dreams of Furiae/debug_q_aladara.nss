#include "ddf_util"
#include "ddf_journal"

void main()
{
    object oModule = GetModule();
    object oPC = GetFirstPC();

    debug("Testing Aladara quest complete logic.");

    SetQuestState(AREA_NORTH_MARKET, INVESTIGATION_INPROGRESS);

    SetLocalInt(oModule, "ddf_aladara_dead", TRUE);

    object oRing = CreateItemOnObject("ringofsending", oPC);
    SetTag(oRing, "RING_ALADARA");

    SetLocalInt(oModule, "ddf_examined_bloody_ledger", TRUE);
    SetLocalInt(oModule, "ddf_examined_grimy_ledger", TRUE);

    UpdateJournal(oPC);

}
