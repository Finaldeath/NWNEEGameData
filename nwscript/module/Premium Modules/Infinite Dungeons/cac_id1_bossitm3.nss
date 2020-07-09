//::////////////////////////////////////////////////////////////////////////////
//:: cac_id1_bossitem
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Conversation action taken script to have the boss creture give the player
    one of his items. The script is generalized to use the tag of the creature
    running it to determine the item that should be given.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Nov 18, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_boss"

void main()
{
    object oPC = GetPCSpeaker();
    string sTag = GetTag(OBJECT_SELF);

    string sItemTag;
    string sItem2Tag;

    // select the appropriate boss item and set the quest as active
    if (sTag == ANTOINE_TAG) // baccha
    {
        sItemTag = "itm_id1_anttot";
        sItem2Tag = "id1_bossplot_ant";
        SetLocalInt(GetModule(), "bBacchaQuestCompleted", TRUE);
        AddJournalQuestEntry("id1_baccha", 30, oPC, TRUE, TRUE, TRUE);

        // destroy the teleporter in the dungeon entrance
        DestroyObject(GetObjectByTag("id1_bactel"));
    } else if (sTag == HAGATHA_TAG) // hagatha
    {
        sItemTag = "itm_id1_widhair";
        sItem2Tag = "id1_bossplot_hag";
        SetLocalInt(GetModule(), "bHagathaQuestCompleted", TRUE);
        AddJournalQuestEntry("id1_hagatha", 30, oPC, TRUE, TRUE, TRUE);

        // destroy the teleporter in the dungeon entrance
        DestroyObject(GetObjectByTag("id1_hagtel"));
    } else if (sTag == MAGGRIS_TAG) // maggris
    {
        sItemTag = "itm_id1_maggegg";
        sItem2Tag = "id1_bossplot_mag";
        SetLocalInt(GetModule(), "bMaggrisQuestCompleted", TRUE);
        AddJournalQuestEntry("id1_maggris", 30, oPC, TRUE, TRUE, TRUE);

        // destroy the teleporter in the dungeon entrance
        DestroyObject(GetObjectByTag("id1_magtel"));
    } else if (sTag == HARAT_TAG) // harat
    {
        sItemTag = "itm_id1_harattg";
        if (GetLocalInt(GetModule(), "bHaratOpened") == TRUE)
        {
            sItem2Tag = "id1_bossplot_har2";
        } else
        {
            sItem2Tag = "id1_bossplot_har1";
        }
        SetLocalInt(GetModule(), "bHaratQuestCompleted", TRUE);
        AddJournalQuestEntry("id1_harat", 30, oPC, TRUE, TRUE, TRUE);

        // destroy the teleporter in the dungeon entrance
        DestroyObject(GetObjectByTag("id1_hartel"));
    } else if (sTag == GZHORB_TAG) // gzhorb
    {
        sItemTag = "itm_id1_gzrbeye";
        sItem2Tag = "id1_bossplot_gzb";
        SetLocalInt(GetModule(), "bGzhorbQuestCompleted", TRUE);
        AddJournalQuestEntry("id1_gzhorb", 30, oPC, TRUE, TRUE, TRUE);

        // destroy the teleporter in the dungeon entrance
        DestroyObject(GetObjectByTag("id1_gzbtel"));
    } else if (sTag == MASTERIUS_TAG) // masterius
    {
        sItemTag = "itm_id1_masbone";
        sItem2Tag = "id1_bossplot_mas";
        SetLocalInt(GetModule(), "bMasteriusQuestCompleted", TRUE);
        AddJournalQuestEntry("id1_masterius", 30, oPC, TRUE, TRUE, TRUE);

        // destroy the teleporter in the dungeon entrance
        DestroyObject(GetObjectByTag("id1_mastel"));
    }

    DebugMessage("Searching for item " + sItemTag + "_dormant");
    object oItem = GetItemPossessedBy(oPC, sItemTag + "_dormant");
    if (oItem == OBJECT_INVALID)
    {
        DebugMessage("Player " + GetTag(oPC) + " didn't have " + sItemTag + "_dormant.");

        object oPC = GetFirstPC();
        while ((oPC != OBJECT_INVALID) && (oItem == OBJECT_INVALID))
        {
            DebugMessage("Player " + GetTag(oPC) + " didn't have " + sItemTag + "_dormant.");

            oItem = GetItemPossessedBy(oPC, sItemTag + "_dormant");

            if (oItem == OBJECT_INVALID)
            {
                oPC = GetNextPC();
            }
        }
    }

    // if no one has the item
    object oCreated;
    if (oItem == OBJECT_INVALID)
    {
        // get original PC
        oPC = GetPCSpeaker();
        oCreated = CreateItemOnObject(sItemTag + "2", oPC);
        DebugMessage("No one has the item. Creating " + sItemTag + "2 on " + GetTag(oPC));
    } else // if the item was found
    {
        oPC = GetItemPossessor(oItem);
        DestroyObject(oItem);
        oCreated = CreateItemOnObject(sItemTag + "2", oPC);
        DebugMessage("Creating " + sItemTag + "2 on " + GetTag(oPC));
    }
    if (GetTag(oCreated) == "itm_id1_maggegg2")
    {
        SetName(oCreated, "Egg of the Hive Mother (5 Charges)");
    }

    DebugMessage("Searching for item " + sItem2Tag);
    object oItem2 = GetItemPossessedBy(oPC, sItem2Tag);
    if (oItem2 == OBJECT_INVALID)
    {
        DebugMessage("Player " + GetTag(oPC) + " didn't have " + sItem2Tag);

        object oPC = GetFirstPC();
        while ((oPC != OBJECT_INVALID) && (oItem2 == OBJECT_INVALID))
        {
            DebugMessage("Player " + GetTag(oPC) + " didn't have " + sItem2Tag);

            oItem2 = GetItemPossessedBy(oPC, sItem2Tag);

            if (oItem2 == OBJECT_INVALID)
            {
                oPC = GetNextPC();
            }
        }
    }

    if (oItem2 != OBJECT_INVALID)
    {
        DestroyObject(oItem2);
    }

    // give each player an experience reward for completing the boss quest
    object oDungeon = GetCurrentDungeon();
    int nBossLevel = GetLocalInt(oDungeon, "nBossLevel");
    int nReward = nBossLevel * 500;
    oPC = GetFirstPC();
    while (oPC != OBJECT_INVALID)
    {
        GiveXPToCreature(oPC, nReward);

        oPC = GetNextPC();
    }
}
