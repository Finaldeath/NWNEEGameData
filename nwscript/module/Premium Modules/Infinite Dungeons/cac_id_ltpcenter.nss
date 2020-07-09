//::///////////////////////////////////////////////
//:: cac_id_ltpcenter
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sets that the PC has agreed to enter the dungeon
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"
#include "inc_id1_debug"

void main()
{
    lt_SetIsEntryAgreed();

    // unlock the dungeon entrance
    SetLocked(GetObjectByTag("DungeonEntranceStairs"), FALSE);

    // generate first lieutenant
    int nLieutenant = Random(3) + 1;
    lt_SetFirstLieutenant(nLieutenant);

    // generate dungeon parameters
    SetDungeonParameters(1, nLieutenant);
//    lt_SetDungeonLevel(ID_LOCAL_FIRST_DUNGEON_CREATED);
    SetLocalInt(GetModule(), "bPlotDungeon", TRUE);

    // give the player a dungeon map and journal
    object oPC = GetPCSpeaker();

    // give players journal quest entry
    AddJournalQuestEntry("id1_main", 10, oPC, TRUE, TRUE);

    // if the player doesn't have a map
    if (GetItemPossessedBy(oPC, "itm_id1_map") == OBJECT_INVALID)
    {
        DebugMessage("  Player does not have a dungeon map. Creating.");

        // give player the map object
        CreateItemOnObject("itm_id1_map", oPC);
    }

    // if the player doesn't have a dungeon journal
    if (GetItemPossessedBy(oPC, "itm_id1_journal") == OBJECT_INVALID)
    {
        DebugMessage("  Player does not have a dungeon journal. Creating.");

        // give player the map object
        CreateItemOnObject("itm_id1_journal", oPC);
    }
}
