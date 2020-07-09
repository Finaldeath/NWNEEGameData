#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_utility"
#include "inc_id_liltimmy"

void main()
{
    object oPC = GetLocalObject(GetModule(), "oTempPC");
    object oDestinationDoor = GetLocalObject(GetModule(), "oTempDestinationDoor");
    object oDungeon = GetLocalObject(GetModule(), "oTempDungeon");
    object oArea = GetArea(oDestinationDoor);
    int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

    // get current level
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");

    // check to see if current area is the first stairs up on the current level
    int nStairsUp = GetLocalInt(oDungeon, "nLevel" + IntToString(nCurrentLevel) + "StairsUp1");
    DebugMessage("StairsUp is area " + IntToString(nStairsUp) + " vs current area " + IntToString(nAreaNum));
    if (nAreaNum == nStairsUp)
    {
        string sLevel = "EmergencyLevel" + IntToString(nCurrentLevel);
        DebugMessage("Starting " + sLevel);

        int nPartyLevel = GetPartyLevel(oPC, TRUE);
        DebugMessage("Party CR is " + IntToString(nPartyLevel));

        // get the number of creatures
        int nCreatureNum = GetLocalInt(oDungeon, "n" + sLevel + "CreatureNum");
        DebugMessage("There are " + IntToString(nCreatureNum) + " emergency creatures.");
        int nCreature = 1;
        while (nCreature < nCreatureNum)
        {
            SetLocalInt(oDungeon, "n" + sLevel + "Creature" + IntToString(nCreature) + "CR", nPartyLevel);

            // cycle to next creature
            nCreature++;
        }

        // get the number of placeables
        int nPlaceableNum = GetLocalInt(oDungeon, "n" + sLevel + "PlaceableNum");
        DebugMessage("There are " + IntToString(nPlaceableNum) + " emergency placeables.");

        // get the number of items
        int nItemNum = GetLocalInt(oDungeon, "n" + sLevel + "ItemNum");
        DebugMessage("There are " + IntToString(nItemNum) + " emergency items.");

        if (nCreatureNum > 0) // if there are creatures
        {
            string sCreature;
            int nCreatureItemNum;
            int nCreatureItemType;
            int nItem = 1;
            string sResRef;
            int nBossQuestLevel = GetLocalInt(oDungeon, "nBossQuestLevel");
            int nBossQuestBoss = GetLocalInt(oDungeon, "nBossQuestBoss");
            while (nItem <= nItemNum)
            {
                nCreature = Random(nCreatureNum) + 1;
                sCreature = sLevel + "Creature" + IntToString(nCreature);
                nCreatureItemNum = GetLocalInt(oDungeon, "n" + sCreature + "ItemNum");
                nCreatureItemNum++;
                SetLocalInt(oDungeon, "n" + sCreature + "ItemNum", nCreatureItemNum);
                SetLocalInt(oDungeon, "n" + sCreature + "Item" + IntToString(nCreatureItemNum) + "ItemType", 2);
                SetLocalInt(oDungeon, "n" + sCreature + "Item" + IntToString(nCreatureItemNum) + "Size", 1);
                nCreatureItemType = GetLocalInt(oDungeon, "n" + sLevel + "Item" + IntToString(nItem));
                if (nCreatureItemType == -1) // special dungeon plot item
                {
                    if (nBossQuestLevel == 1) // lieutenants
                    {
                        if (nBossQuestBoss == ID_LOCAL_LIEUTENANT_WEREBOAR)
                        {
                            sResRef = "id1_bossplot_ant";
                        } else if (nBossQuestBoss == ID_LOCAL_LIEUTENANT_GIANTESS)
                        {
                            sResRef = "id1_bossplot_hag";
                        } else if (nBossQuestBoss == ID_LOCAL_LIEUTENANT_INSECT)
                        {
                            sResRef = "id1_bossplot_mag";
                        }
                    } else if (nBossQuestLevel == 1) // inner circle
                    {
                        if (nBossQuestBoss == ID_LOCAL_BOSS_DEMON)
                        {
                            sResRef = "id1_bossplot_har";
                        } else if (nBossQuestBoss == ID_LOCAL_BOSS_BEHOLDER)
                        {
                            sResRef = "id1_bossplot_gzb";
                        } else if (nBossQuestBoss == ID_LOCAL_BOSS_LICH)
                        {
                            sResRef = "id1_bossplot_mas";
                        }
                    }
                } else // normal plot item
                {
                    sResRef = GetLocalString(oDungeon, "sListItem" + IntToString(nCreatureItemType) + "ResRef");
                }
                SetLocalString(oDungeon, "s" + sCreature + "Item" + IntToString(nCreatureItemNum) + "ResRef", sResRef);
                DebugMessage("        Added item " + IntToString(nItem) + " to n" + sCreature + "Item" + IntToString(nCreatureItemNum));

                // cycle to next item
                nItem++;
            }
        } else if (nItemNum > 0) // if there are no creatures, but there are items
        {
            // create single creature
            SetLocalInt(oDungeon, "n" + sLevel + "CreatureNum", 1);
            DebugMessage("    Setting emergency creature num to 1");
            string sCreature = sLevel + "Creature1";

            DebugMessage("      Basic CR for monster is " + IntToString(nPartyLevel));

            // tileset info
            string sTileset = GetTilesetResRef(oArea);
            int nTileset = GetLocalInt(GetModule(), "nTileset_" + sTileset);

            // microprocess object
            object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU39");
            SetLocalString(oMicroCPU, "sCreature", sCreature);
            SetLocalInt(oMicroCPU, "nCR", nPartyLevel);
            SetLocalInt(oMicroCPU, "bIntelligentOnly", FALSE);
            SetLocalInt(oMicroCPU, "bUnIntelligentOnly", FALSE);
            SetLocalInt(oMicroCPU, "bMediumSizeOnly", FALSE);
            SetLocalInt(oMicroCPU, "bMiniBoss", FALSE);
            SetLocalInt(oMicroCPU, "nTileset", nTileset);
            SetLocalInt(oMicroCPU, "nTheme", -1);
            SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
            SetLocalInt(oMicroCPU, "bHold", TRUE);

            // increment number of active microprocessors
            int nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
            nMicroNum++;
            SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

            DelayCommand(0.01, ExecuteScript("exe_id1_micmon", oMicroCPU));

            int nItem = 1;
            int nCreatureItemNum;
            int nCreatureItemType;
            string sResRef;
            int nBossQuestLevel = GetLocalInt(oDungeon, "nBossQuestLevel");
            int nBossQuestBoss = GetLocalInt(oDungeon, "nBossQuestBoss");
            while (nItem <= nItemNum)
            {
                nCreatureItemNum = GetLocalInt(oDungeon, "n" + sCreature + "ItemNum");
                nCreatureItemNum++;
                SetLocalInt(oDungeon, "n" + sCreature + "ItemNum", nCreatureItemNum);
                SetLocalInt(oDungeon, "n" + sCreature + "Item" + IntToString(nCreatureItemNum) + "ItemType", 2);
                SetLocalInt(oDungeon, "n" + sCreature + "Item" + IntToString(nCreatureItemNum) + "Size", 1);
                nCreatureItemType = GetLocalInt(oDungeon, "n" + sLevel + "Item" + IntToString(nItem));
                if (nCreatureItemType == -1) // special dungeon plot item
                {
                    if (nBossQuestLevel == 1) // lieutenants
                    {
                        if (nBossQuestBoss == ID_LOCAL_LIEUTENANT_WEREBOAR)
                        {
                            sResRef = "id1_bossplot_ant";
                        } else if (nBossQuestBoss == ID_LOCAL_LIEUTENANT_GIANTESS)
                        {
                            sResRef = "id1_bossplot_hag";
                        } else if (nBossQuestBoss == ID_LOCAL_LIEUTENANT_INSECT)
                        {
                            sResRef = "id1_bossplot_mag";
                        }
                    } else if (nBossQuestLevel == 1) // inner circle
                    {
                        if (nBossQuestBoss == ID_LOCAL_BOSS_DEMON)
                        {
                            sResRef = "id1_bossplot_har";
                        } else if (nBossQuestBoss == ID_LOCAL_BOSS_BEHOLDER)
                        {
                            sResRef = "id1_bossplot_gzb";
                        } else if (nBossQuestBoss == ID_LOCAL_BOSS_LICH)
                        {
                            sResRef = "id1_bossplot_mas";
                        }
                    }
                } else // normal plot item
                {
                    sResRef = GetLocalString(oDungeon, "sListItem" + IntToString(nCreatureItemType) + "ResRef");
                }
                SetLocalString(oDungeon, "s" + sCreature + "Item" + IntToString(nCreatureItemNum) + "ResRef", sResRef);
                DebugMessage("        Added item " + IntToString(nItem) + " to n" + sCreature + "Item" + IntToString(nCreatureItemNum));

                // cycle to next item
                nItem++;
            }
        }
    }

    // enter holding pattern
    DebugMessage("Entering holding pattern.");
    DelayCommand(0.01, ExecuteScript("exe_id1_acthold", GetNextCPU()));
}

