//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_bghunt_v1
//:: DATE: January 10, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt - Vaporandir
//:: PC accepts Vaporandirs suggestion to fool
//:: Baerdeth with the tongue of a green dragon
//::////////////////////////////////////////////////////

#include "hf_in_plot"

// Dead green dragon
const string NPC_RESREF_DEAD_DRAGON = "drggreen002";
const string NPC_TAG_DEAD_DRAGON = "cr_corm_for_deaddragon";
const string WP_TAG_DEAD_DRAGON = "WP_corm_for_deaddragon_spawn";


// Create a new dragon corpse and destroy the the old one.
void RespawnDragon(object oPC)
{
    object oWpDeadDragonSpawn = GetWaypointByTag(WP_TAG_DEAD_DRAGON);
    object oDragonCorpse = GetNearestObjectByTag(NPC_TAG_DEAD_DRAGON, oWpDeadDragonSpawn);
    if (GetIsObjectValid(oDragonCorpse))
    {
        AssignCommand(oDragonCorpse, SetIsDestroyable(TRUE, FALSE));
        DestroyObject(oDragonCorpse, 0.5f);
    }
    oDragonCorpse = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_DEAD_DRAGON, GetLocation(oWpDeadDragonSpawn), FALSE, NPC_TAG_DEAD_DRAGON);
}


void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet("biggamehunt_status_vapo", 1);
    AddJournalQuestEntry("BigGameHunt-Vaporandir", 30, oPC);

    RespawnDragon(oPC);
}
