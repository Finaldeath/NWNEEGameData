//::////////////////////////////////////////////////////////////////////////////
//:: pds_id1_treasure
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Disturbed Event script for the treasure containers of Infinite Dungeons.
    When an object is removed from a container the dungeon object has a flag
    set to indicate the object's absence.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 26, 2005
//::////////////////////////////////////////////////////////////////////////////

//#include "inc_debug"
#include "inc_id1_utility"

void main()
{
    object oContainer = OBJECT_SELF;
    object oDungeon = GetCurrentDungeon();

    // Establish the dungeon variable identifier for the container.
    string sVariable = GetLocalString(oContainer, "sVariable");

    DebugMessage("pds_id1_treasure::main()");

    // Objects removed from the chest should be tracked on the Dungeon.
    if (GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_REMOVED)
    {
        object oItem = GetInventoryDisturbItem();
        object oPC = GetLastDisturbed();
        string sTag = GetTag(oItem);
        DebugMessage("Treasure chest lost item " + sTag);

        int bDropped = GetLocalInt(oItem, "bDropped");
        if (bDropped == TRUE)
        {
            DebugMessage("  Item is this chest's treasure.");
            SetLocalInt(oItem, "bDropped", FALSE);

            // check to see if a boss plot item
            if (sTag == "id1_bossplot_ant")
            {
                SetLocalInt(GetModule(), "bBacchaQuestItemFound", TRUE);
                AddJournalQuestEntry("id1_baccha", 20, GetFirstPC(), TRUE, TRUE, TRUE);
            } else if (sTag == "id1_bossplot_hag")
            {
                SetLocalInt(GetModule(), "bHagathaQuestItemFound", TRUE);
                AddJournalQuestEntry("id1_hagatha", 20, GetFirstPC(), TRUE, TRUE, TRUE);
            } else if (sTag == "id1_bossplot_mag")
            {
                SetLocalInt(GetModule(), "bMaggrisQuestItemFound", TRUE);
                AddJournalQuestEntry("id1_maggris", 20, GetFirstPC(), TRUE, TRUE, TRUE);
            } else if (sTag == "id1_bossplot_har1")
            {
                SetLocalInt(GetModule(), "bHaratQuestItemFound", TRUE);
                AddJournalQuestEntry("id1_harat", 20, GetFirstPC(), TRUE, TRUE, TRUE);
            } else if (sTag == "id1_bossplot_gzb")
            {
                SetLocalInt(GetModule(), "bGzhorbQuestItemFound", TRUE);
                AddJournalQuestEntry("id1_gzhorb", 20, GetFirstPC(), TRUE, TRUE, TRUE);
            } else if (sTag == "id1_bossplot_mas")
            {
                SetLocalInt(GetModule(), "bMasteriusQuestItemFound", TRUE);
                AddJournalQuestEntry("id1_masterius", 20, GetFirstPC(), TRUE, TRUE, TRUE);
            }

            int nDroppedNum = GetLocalInt(oItem, "nDroppedNum");
            DebugMessage("  Dropped num is " + IntToString(nDroppedNum));
            if (nDroppedNum > 0)
            {
                SetLocalInt(oDungeon, "b" + sVariable + "Item" + IntToString(nDroppedNum) + "Taken", TRUE);
                DebugMessage("  Player took b" + sVariable + "Item" + IntToString(nDroppedNum) + "Taken");
            }
        } else
        {
            DebugMessage("  Item is a different piece of treasure.");

            if (sTag == "")
            {
                DebugMessage("  Item was gold.");

                int nItem = 1;
                int nItemNum = GetLocalInt(oDungeon, "n" + sVariable + "ItemNum");
                int nItemType;
                int nStackSize;
                int bTaken;
                while (nItem <= nItemNum)
                {
                    nItemType = GetLocalInt(oDungeon, "n" + sVariable + "Item" + IntToString(nItem) + "ItemType");
                    DebugMessage("    Checking item " + IntToString(nItem) + " with type " + IntToString(nItemType));
                    if (nItemType == 1)
                    {
                        DebugMessage("      Item was gold.");
                        bTaken = GetLocalInt(oDungeon, "b" + sVariable + "Item" + IntToString(nItem) + "Taken");
                        if (bTaken == FALSE)
                        {
                            DebugMessage("      Has not been taken.");

                            SetLocalInt(oDungeon, "b" + sVariable + "Item" + IntToString(nItem) + "Taken", TRUE);

                            // find out how much
                            nStackSize = GetLocalInt(oDungeon, "n" + sVariable + "Item" + IntToString(nItem) + "Size");
                            DebugMessage("      Stack size is " + IntToString(nStackSize));

                            // tithe for henchmen
                            PayHenchmanTithe(oPC, nStackSize);
                        }
                    }

                    // check next item
                    nItem++;
                }
            } else
            {
                DebugMessage("  Item was a stackable.");
            }
        }

        int bEmpty = TRUE;
        int nItem = 1;
        int nItemNum = GetLocalInt(oDungeon, "n" + sVariable + "ItemNum");
        while ((nItem <= nItemNum) && (bEmpty == TRUE))
        {
            DebugMessage("  Checking item " + IntToString(nItem));
            if (GetLocalInt(oDungeon, "b" + sVariable + "Item" + IntToString(nItem) + "Taken") == FALSE)
            {
                DebugMessage("    Item is not taken.");
                bEmpty = FALSE;

                // EDIT: check for presence of tag in inventory (stackables)
            } else
            {
                DebugMessage("    Item has been taken.");
            }

            if (bEmpty == TRUE)
            {
                // check next item
                nItem++;
            }
        }

        if (bEmpty == TRUE)
        {
            DebugMessage("  All items taken.");

            effect eEffect = GetFirstEffect(oContainer);

            while (GetIsEffectValid(eEffect) == TRUE)
            {
                if (GetEffectType(eEffect) == EFFECT_TYPE_VISUALEFFECT)
                {
                    RemoveEffect(oContainer, eEffect);
                }

                eEffect = GetNextEffect(oContainer);
            }
        }
    } // if (GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_REMOVED)
} // main()
