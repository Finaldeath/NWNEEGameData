#include "ddf_util"
#include "ddf_jrnl_wwine"
#include "ddf_jrnl_whouse"
#include "ddf_jrnl_street"
#include "ddf_jrnl_corano"
#include "ddf_jrnl_aladara"
#include "ddf_jrnl_ulan"
#include "ddf_jrnl_rings"
#include "ddf_jrnl_nmare"
#include "ddf_jrnl_choice"
#include "ddf_jrnl_distrib"
#include "ddf_jrnl_harasi"
#include "ddf_jrnl_npc"

void UpdateJournal(object oPC)
{
    //debug("Updating Journals... ");
    UpdateWorldwineJournal(oPC);
    UpdateWarehouseJournal(oPC);
    UpdateStreetJournal(oPC);
    UpdateCoranoJournal(oPC);
    UpdateAladaraJournal(oPC);
    UpdateUlanJournal(oPC);
    UpdateRingsJournal(oPC);
    UpdateNightmareJournal(oPC);
    UpdateChoiceJournal(oPC);
    UpdateDistributionJournal(oPC);
    UpdateHarasiJournal(oPC);
    UpdateNpcJournal(oPC);
}

