#include "ddf_util"
#include "ddf_journal"

void TestRatholeStreets01(object oModule, object oPC);
void TestRatholeStreets02(object oModule, object oPC);
void TestRatholeStreets03(object oModule, object oPC);

void main()
{
    object oModule = GetModule();
    object oPC = GetFirstPC();

    debug("Journal Complete Tests");

    debug("-- Rings");
    SetLocalInt(oModule, "ddf_number_of_rings_found", 2);
    SetLocalInt(oModule, "ddf_spoke_with_shavann", TRUE);

    debug("-- Aladara");
    SetLocalInt(oModule, "ddf_examined_grimy_ledger", TRUE);
    SetLocalInt(oModule, "ddf_aladara_dead", TRUE);
    CreateItemOnObject("ringofsending", oPC, 1, "RING_ALADARA");

    debug("-- Corano");
    SetLocalInt(oModule, "ddf_property_deed", TRUE);
    SetLocalInt(oModule, "ddf_examined_spirit_letter", TRUE);

    debug("-- Ulan");
    SetLocalInt(oModule, "ddf_examined_south_market_deed", TRUE);
    SetLocalInt(oModule, "ddf_deal_with_ulan", TRUE);
    CreateItemOnObject("ringofsending", oPC, 1, "RING_ULAN");

    debug("-- Warehouse");
    SetLocalInt(oModule, "dlg_quill_002_done", TRUE);
    SetLocalInt(oModule, "ddf_property_deed", TRUE);

    debug("-- Worldwine");
    SetLocalInt(oModule, "dlg_quill_001_done", TRUE);
    SetLocalInt(oModule, "ddf_karkualii_defeated", TRUE);

    debug("-- Nightmare");
    SetLocalInt(oModule, "ddf_met_nightmare_karkualii", TRUE);

    debug("-- Choice");
    SetLocalInt(oModule, "ddf_choice_made", TRUE);

    debug("-- Harasi");
    SetLocalInt(oModule, "ddf_examined_bloody_ledger", TRUE);
    SetLocalInt(oModule, "ddf_harasi_dead", TRUE);
    SetLocalInt(oModule, "ddf_confront_harasi", TRUE);

    debug("-- Distribution - Roosters Roost");
    SetLocalInt(oModule, "ddf_examined_bottle_worldwine", TRUE);
    SetLocalInt(oModule, "ddf_examined_harasi_documents", TRUE);

    UpdateJournal(oPC);

    SetLocalInt(oModule, "ddf_examined_spirit_letter", FALSE);
    SetLocalInt(oModule, "ddf_examined_bloody_ledger", FALSE);

    TestRatholeStreets01(oModule, oPC);
    TestRatholeStreets02(oModule, oPC);
    TestRatholeStreets03(oModule, oPC);

}


void TestRatholeStreets01(object oModule, object oPC)
{
    debug("-- Rathole Streets (via harasi day 3)");
    SetLocalInt(oModule, JOURNAL_STREET + "updates", 0);
    SetLocalInt(oModule, "dlg_quill_002_done", TRUE);
    SetLocalInt(oModule, "ddf_examined_harasi_documents", TRUE);
    SetLocalInt(oModule, "DDF_CURRENT_DAY", 3);

    UpdateJournal(oPC);

}

void TestRatholeStreets02(object oModule, object oPC)
{
    debug("-- Rathole Streets (via harasi day 2)");
    SetLocalInt(oModule, JOURNAL_STREET + "updates", 0);
    SetLocalInt(oModule, "ddf_learn_harasi_day2", TRUE);
    SetLocalInt(oModule, "dlg_quill_002_done", TRUE);
    SetLocalInt(oModule, "DDF_CURRENT_DAY", 2);

    SetQuestState(AREA_RATHOLE_STREETS, INVESTIGATION_INPROGRESS);

    UpdateJournal(oPC);
}

void TestRatholeStreets03(object oModule, object oPC)
{
    debug("-- Rathole Streets (killed em all)");
    SetLocalInt(oModule, JOURNAL_STREET + "updates", 0);
    SetLocalInt(oModule, "ddf_learn_harasi_day2", FALSE);
    SetLocalInt(oModule, "ddf_examined_harasi_documents", FALSE);
    SetLocalInt(oModule, "dlg_quill_002_done", TRUE);
    SetLocalInt(oModule, "ddf_dealers_dead", TRUE);
    SetLocalInt(oModule, "DDF_CURRENT_DAY", 2);

    SetQuestState(AREA_RATHOLE_STREETS, INVESTIGATION_INPROGRESS);

    UpdateJournal(oPC);

}
