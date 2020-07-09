#include "inc_id1_treasure"
void main()
{
    object oContainer = GetLocalObject(OBJECT_SELF, "oContainer");
    string sLevel = GetLocalString(OBJECT_SELF, "sLevel");
    int bCreature = GetLocalInt(OBJECT_SELF, "bCreature");
    object oDungeon = GetLocalObject(OBJECT_SELF, "oDungeon");
    int bContainer = GetLocalInt(OBJECT_SELF, "bContainer");

    DebugMessage("");
    DebugMessage("====TREASURE SPAWNING MICROPROCESS START====");
    DebugMessage("====" + sLevel + "====");
    DebugMessage("");

    // get the number of items to spawn
    int nItemNum = GetLocalInt(oDungeon, "n" + sLevel + "ItemNum");

    int bTaken;

    location lLocation = GetLocation(oContainer);

    // spawn all items
    int nItem = 1;
    string sItem;
    string sItemTag;
    object oItem;
    int bSpawned = FALSE;
    while (nItem <= nItemNum)
    {
        DebugMessage("On item " + IntToString(nItem) + " of " + IntToString(nItemNum));

        sItem = sLevel + "Item" + IntToString(nItem);

        // check to see if item is taken
        bTaken = GetLocalInt(oDungeon, "b" + sItem + "Taken");
        if (bTaken == FALSE)
        {
            bSpawned = TRUE;

            // spawn loot on self
            oItem = CreateItemInContainer(sItem, oContainer, oDungeon);

            // if this is a treasure chest
            if (bCreature == FALSE)
            {
                DebugMessage("  Marking item as dropped.");

                // mark item as having not been picked up
                SetLocalInt(oItem, "bDropped", TRUE);

                // record item number
                SetLocalInt(oItem, "nDroppedNum", nItem);
            } else // this is a creature
            {
                // if this item is a boss plot item
                sItemTag = GetTag(oItem);
                if (sItemTag == "id1_bossplot_ant")
                {
                    DebugMessage("  Dropped Baccha's find item.");
                    SetLocalInt(GetModule(), "bBacchaQuestItemFound", TRUE);
                    AddJournalQuestEntry("id1_baccha", 20, GetFirstPC(), TRUE, TRUE, TRUE);
                    CreateObject(OBJECT_TYPE_PLACEABLE, "bossitemmarker", lLocation, FALSE, "ant_marker");
                } else if (sItemTag == "id1_bossplot_hag")
                {
                    DebugMessage("  Dropped Hagatha's find item.");
                    SetLocalInt(GetModule(), "bHagathaQuestItemFound", TRUE);
                    AddJournalQuestEntry("id1_hagatha", 20, GetFirstPC(), TRUE, TRUE, TRUE);
                    CreateObject(OBJECT_TYPE_PLACEABLE, "bossitemmarker", lLocation, FALSE, "hag_marker");
                } else if (sItemTag == "id1_bossplot_mag")
                {
                    DebugMessage("  Dropped Maggris' find item.");
                    SetLocalInt(GetModule(), "bMaggrisQuestItemFound", TRUE);
                    AddJournalQuestEntry("id1_maggris", 20, GetFirstPC(), TRUE, TRUE, TRUE);
                    CreateObject(OBJECT_TYPE_PLACEABLE, "bossitemmarker", lLocation, FALSE, "mag_marker");
                } else if (sItemTag == "id1_bossplot_har1")
                {
                    DebugMessage("  Dropped Harat's find item.");
                    SetLocalInt(GetModule(), "bHaratQuestItemFound", TRUE);
                    AddJournalQuestEntry("id1_harat", 20, GetFirstPC(), TRUE, TRUE, TRUE);
                    CreateObject(OBJECT_TYPE_PLACEABLE, "bossitemmarker", lLocation, FALSE, "har_marker");
                } else if (sItemTag == "id1_bossplot_gzb")
                {
                    DebugMessage("  Dropped Gzhorb's find item.");
                    SetLocalInt(GetModule(), "bGzhorbQuestItemFound", TRUE);
                    AddJournalQuestEntry("id1_gzhorb", 20, GetFirstPC(), TRUE, TRUE, TRUE);
                    CreateObject(OBJECT_TYPE_PLACEABLE, "bossitemmarker", lLocation, FALSE, "gzb_marker");
                } else if (sItemTag == "id1_bossplot_mas")
                {
                    DebugMessage("  Dropped Masterius' find item.");
                    SetLocalInt(GetModule(), "bMasteriusQuestItemFound", TRUE);
                    AddJournalQuestEntry("id1_masterius", 20, GetFirstPC(), TRUE, TRUE, TRUE);
                    CreateObject(OBJECT_TYPE_PLACEABLE, "bossitemmarker", lLocation, FALSE, "mas_marker");
                }
            }

            if (oItem == OBJECT_INVALID)
            {
                DebugMessage("Item did not spawn properly.");
            }

            // make item drop when killed
            SetDroppableFlag(oItem, TRUE);
        }

        // spawn next item
        nItem++;
    }

    if ((bSpawned == TRUE) && (bContainer == TRUE))
    {
        DebugMessage("An item was created. Adding glow.");

        // spawn glow
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_AURA_WHITE), oContainer);
    }

    DebugMessage("");
    DebugMessage("====" + sLevel + "====");
    DebugMessage("====TREASURE SPAWNING MICROPROCESS END====");
    DebugMessage("");

    // destroy itself
    if (bCreature == FALSE)
    {
        DelayCommand(0.1, DestroyObject(OBJECT_SELF));
    }
}
