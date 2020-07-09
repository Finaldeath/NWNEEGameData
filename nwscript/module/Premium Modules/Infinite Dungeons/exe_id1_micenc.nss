#include "inc_id1_debug"
#include "inc_id1_creature"
#include "inc_id_liltimmy"

void GenerateCreatureDetails(string sCreature, string s2DA);

void main()
{
    string sWaypoint = GetLocalString(OBJECT_SELF, "sVariable");
    object oDungeon = GetLocalObject(OBJECT_SELF, "oDungeon");
    int bHold = GetLocalInt(OBJECT_SELF, "bHold");
    int nBaseLevel = GetLocalInt(OBJECT_SELF, "nBaseLevel");
    int nBaseSize = GetLocalInt(OBJECT_SELF, "nBaseSize");
    int nPercentage = GetLocalInt(OBJECT_SELF, "nPercentage");
    int bBoss = GetLocalInt(OBJECT_SELF, "bBoss");
    int nTileset = GetLocalInt(OBJECT_SELF, "nTileset");
    int nTheme = GetLocalInt(OBJECT_SELF, "nTheme");

    DebugMessage("");
    DebugMessage("====ENCOUNTER GENERATION MICROPROCESS START====");
    DebugMessage("==== " + sWaypoint + " ====");
    DebugMessage("");

    int nEncounterSize = 0;
    int nCR;
    string sCreature;
    object oMicroCPU;
    int nMicroNum;
    int nPlotID;
    int nCreature;
    int nBossLevel;
    int nBossBoss;
    string sResRef;
    int nItemType;
    int nItemNum;

    int nFlag;
    int nModuleCreature;
    int bGenerated;
    string s2DA;
    string sMonsterType;
    if ((bBoss == TRUE) && (GetModuleFlag(ID1_FLAG_ENCOUNTER_TYPE) != ID1_ENCOUNTER_TYPE_CREATURE))
    {
        s2DA = "miniboss";
        sMonsterType = "MiniBoss";
    } else
    {
        s2DA = "creatures";
        sMonsterType = "Creature";
    }

    int nRandom = Random(nPercentage) + 1;
    DebugMessage("  Random number is " + IntToString(nRandom) + " vs " + IntToString(nPercentage));
    if (nRandom <= nPercentage)
    {
        // set the encounter as used
        SetLocalInt(oDungeon, "b" + sWaypoint + "Used", TRUE);

        // determine theme for this encounter if not set already
        if (nTheme == -1)
        {
            nFlag = GetModuleFlag(ID1_FLAG_ENCOUNTER_TYPE);
            if (nFlag == ID1_ENCOUNTER_TYPE_DUNGEON)
            {
                nTheme = -1;
            } else if (nFlag == ID1_ENCOUNTER_TYPE_THEME)
            {
                nTheme = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TYPE);
            } else if (nFlag == ID1_ENCOUNTER_TYPE_RANDOM)
            {
                nTheme = 1;
            }
        }

        // get how many creatures already present
        int nPlotSize = GetLocalInt(oDungeon, "n" + sWaypoint + "Size");
        DebugMessage("    There are currently " + IntToString(nPlotSize) + " plot creatures on this waypoint.");

        // get size of encounter
        if (bBoss == TRUE)
        {
            DebugMessage("    Boss selection.");
            nEncounterSize = 1;
        } else
        {
            nEncounterSize = GetEncounterSize(nBaseLevel, nBaseSize, nPlotSize);
        }
        SetLocalInt(oDungeon, "n" + sWaypoint + "Size", nEncounterSize);
        DebugMessage("    Encounter size is " + IntToString(nEncounterSize));

        // get level of encounter
        nCR = GetEncounterLevel(nBaseLevel, nEncounterSize);
        DebugMessage("    Encounter level is " + IntToString(nCR));
        if (bBoss == TRUE)
        {
            nCR += 2;
            DebugMessage("    Adjusted for boss creature is " + IntToString(nCR));
        }

        // generate CR for plot creatures
        DebugMessage("    Detailing plot creatures.");
        int nCreature = 1;
        while (nCreature <= nPlotSize)
        {
            sCreature = sWaypoint + "Creature" + IntToString(nCreature);
            SetLocalInt(oDungeon, "n" + sCreature + "CR", nCR);
            DebugMessage("      CR for plot creature " + IntToString(nCreature) + " is " + IntToString(nCR));

            nCreature++;
        }

        // generate normal creatures
        DebugMessage("    Detailing normal creatures.");
        while (nCreature <= nEncounterSize)
        {
            sCreature = sWaypoint + "Creature" + IntToString(nCreature);
            DebugMessage("      CR for creature " + IntToString(nCreature) + " is " + IntToString(nCR));

            // if a specific creature is chosen
            if (GetModuleFlag(ID1_FLAG_ENCOUNTER_TYPE) == ID1_ENCOUNTER_TYPE_CREATURE)
            {
                // get creature number
                nModuleCreature = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TYPE);
                DebugMessage("      Module creature is " + IntToString(nModuleCreature));

                // get if generated
/*                bGenerated = GetLocalInt(GetModule(), "b" + sMonsterType + IntToString(nModuleCreature) + "Generated");
                if (bGenerated == FALSE)
                {
                    // if not, generate
                    GenerateCreatureDetails(sMonsterType + IntToString(nModuleCreature), s2DA);
                }*/

                // get if on the dungeon
                int nSubType = 0;
                int nSubTypeNum = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nModuleCreature) + "SubTypeNum");
                if (nSubTypeNum > 0)
                {
                    nSubType = Random(nSubTypeNum) + 1;
                    sResRef = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nModuleCreature) + "SubType" + IntToString(nSubType) + "ResRef");
                } else
                {
                    sResRef = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nModuleCreature) + "ResRef");
                }

                if (sResRef == "")
                {
                    sResRef = "id1_penguin";
                }

                int nDungeonCreature = GetLocalInt(oDungeon, "nListCreature_" + sResRef);
                if (nDungeonCreature == 0)
                {
                    nDungeonCreature = GetLocalInt(oDungeon, "nListCreatureNum");
                    nDungeonCreature++;
                    SetLocalInt(oDungeon, "nListCreatureNum", nDungeonCreature);
                    SetLocalString(oDungeon, "sListCreature" + IntToString(nDungeonCreature) + "ResRef", sResRef);
                    SetLocalInt(oDungeon, "nListCreature_" + sResRef, nDungeonCreature);

                    string sSingular = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nModuleCreature) + "NameSingular");
                    SetLocalString(oDungeon, "sListCreature" + IntToString(nDungeonCreature) + "NameSingular", sSingular);
                    string sPlural = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nModuleCreature) + "NamePlural");
                    SetLocalString(oDungeon, "sListCreature" + IntToString(nDungeonCreature) + "NamePlural", sPlural);
                    DebugMessage("  Singular is " + sSingular + ", plural is " + sPlural);

                    // attributes
                    int nAttributes = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nModuleCreature) + "Attributes");
                    DebugMessage("  nAttributes is " + IntToString(nAttributes));
                    SetLocalInt(oDungeon, "nListCreature" + IntToString(nDungeonCreature) + "Attributes", nAttributes);

                    // class and class start
                    int nClass;
                    if (nSubType > 0)
                    {
                        nClass = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nModuleCreature) + "SubType" + IntToString(nSubType) + "Class");
                    } else
                    {
                        nClass = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nModuleCreature) + "Class");
                    }
                    int nClassStartHD = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nModuleCreature) + "ClassStartHD");
                    DebugMessage("  nClass is " + IntToString(nClass) + ", nClassStartHD is " + IntToString(nClassStartHD));
                    SetLocalInt(oDungeon, "nListCreature" + IntToString(nDungeonCreature) + "Class", nClass);
                    SetLocalInt(oDungeon, "nListCreature" + IntToString(nDungeonCreature) + "ClassStartHD", nClassStartHD);
                }
                DebugMessage("Creature is dungeon number " + IntToString(nDungeonCreature) + " with resref " + sResRef);
                SetLocalInt(oDungeon, "n" + sCreature, nDungeonCreature);
                SetLocalInt(oDungeon, "n" + sCreature + "CR", nCR);

                int nTreasurePercentage;
                if (bBoss == TRUE)
                {
                    nTreasurePercentage = GetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_FREQUENCY);
                } else
                {
                    nTreasurePercentage = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_FREQUENCY);
                }

                int nRandom = d100();
                DebugMessage("  Random treasure number is " + IntToString(nRandom) + " vs " + IntToString(nTreasurePercentage));
                if (nRandom <= nTreasurePercentage)
                {
                    // run the treasure process
                    object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU66");
                    SetLocalInt(oMicroCPU, "nLevel", nCR);
                    SetLocalString(oMicroCPU, "sContainer", sCreature);
                    SetLocalInt(oMicroCPU, "bCreateTreasure", FALSE);
                    SetLocalObject(oMicroCPU, "oDungeon", oDungeon);

                    // treasure value
                    int nValue;
                    float fValue;
                    if (bBoss == TRUE)
                    {
                        nValue = GetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_VALUE);
                        fValue = (nValue / 100.0);
                        SetLocalFloat(oMicroCPU, "fValueMultiplier", fValue);
                    } else
                    {
                        nValue = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_VALUE);
                        fValue = (nValue / 100.0);
                        SetLocalFloat(oMicroCPU, "fValueMultiplier", fValue);
                    }

                    // read treasure from the creature type
                    int bGoldPresent = GetLocalInt(oDungeon, "bListCreature" + IntToString(nDungeonCreature) + "TreasureGold");
                    int bGemPresent = GetLocalInt(oDungeon, "bListCreature" + IntToString(nDungeonCreature) + "TreasureGems");
                    int bItemPresent = GetLocalInt(oDungeon, "bListCreature" + IntToString(nDungeonCreature) + "TreasureItems");
                    DebugMessage("  bGoldPresent is " + IntToString(bGoldPresent) + ", bGemPresent is " + IntToString(bGemPresent) + ", bItemPresent is " + IntToString(bItemPresent));
                    SetLocalInt(oMicroCPU, "bGoldPresent", bGoldPresent);
                    SetLocalInt(oMicroCPU, "bGemPresent", bGemPresent);
                    SetLocalInt(oMicroCPU, "bItemPresent", bItemPresent);
                    SetLocalInt(oMicroCPU, "bHold", bHold);

                    if (bHold == TRUE)
                    {
                        // increment number of active microprocessors
                        int nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                        nMicroNum++;
                        SetLocalInt(GetModule(), "nMicroNum", nMicroNum);
                    }

                    DelayCommand(0.01, ExecuteScript("exe_id1_mictre", oMicroCPU));
                }
            } else // if the creature is theme-based
            {
                // microprocess object
                oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU67");
                SetLocalString(oMicroCPU, "sCreature", sCreature);
                SetLocalInt(oMicroCPU, "nCR", nCR);
                SetLocalInt(oMicroCPU, "bIntelligentOnly", FALSE);
                SetLocalInt(oMicroCPU, "bUnIntelligentOnly", FALSE);
                SetLocalInt(oMicroCPU, "bMediumSizeOnly", FALSE);
                SetLocalInt(oMicroCPU, "bBoss", bBoss);
                SetLocalInt(oMicroCPU, "nTileset", nTileset);
                SetLocalInt(oMicroCPU, "nTheme", nTheme);
                SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                SetLocalInt(oMicroCPU, "bHold", bHold);

                if (bHold == TRUE)
                {
                    // increment number of active microprocessors
                    nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                    nMicroNum++;
                    SetLocalInt(GetModule(), "nMicroNum", nMicroNum);
                }

                DelayCommand(0.01, ExecuteScript("exe_id1_micmon", oMicroCPU));
            }

            nCreature++;
        }
    }

    // check for plot items
    int nPlotNum = GetLocalInt(oDungeon, "n" + sWaypoint + "PlotNum");
    DebugMessage("Adding items for " + IntToString(nPlotNum) + " plots.");
    if (nPlotNum > 0)
    {
        // if no creature exist to put the plot items on
        if (nEncounterSize == 0)
        {
            nEncounterSize = 1;
            nCR = nBaseLevel + 2;
            sCreature = sWaypoint + "Creature1";
            DebugMessage("      Setting CR for " + sCreature + " to " + IntToString(nCR));

            // determine theme for this encounter if not set already
            if (nTheme == -1)
            {
                nFlag = GetModuleFlag(ID1_FLAG_ENCOUNTER_TYPE);
                if (nFlag == ID1_ENCOUNTER_TYPE_DUNGEON)
                {
                    nTheme = -1;
                } else if (nFlag == ID1_ENCOUNTER_TYPE_THEME)
                {
                    nTheme = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TYPE);
                } else if (nFlag == ID1_ENCOUNTER_TYPE_RANDOM)
                {
                    nTheme = 1;
                }
            }

            // create single creature
            SetLocalInt(oDungeon, "b" + sWaypoint + "Used", TRUE);
            SetLocalInt(oDungeon, "n" + sWaypoint + "Size", 1);

            s2DA = "creatures";
            sMonsterType = "Creature";

            // if a specific creature is chosen
            if (GetModuleFlag(ID1_FLAG_ENCOUNTER_TYPE) == ID1_ENCOUNTER_TYPE_CREATURE)
            {
                // get creature number
                nModuleCreature = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TYPE);
                DebugMessage("      Module creature is " + IntToString(nModuleCreature));

                // get if generated
/*                bGenerated = GetLocalInt(GetModule(), "b" + sMonsterType + IntToString(nModuleCreature) + "Generated");
                if (bGenerated == FALSE)
                {
                    // if not, generate
                    GenerateCreatureDetails(sMonsterType + IntToString(nModuleCreature), s2DA);
                }*/

                // get if on the dungeon
                int nSubType = 0;
                int nSubTypeNum = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nModuleCreature) + "SubTypeNum");
                if (nSubTypeNum > 0)
                {
                    nSubType = Random(nSubTypeNum) + 1;
                    sResRef = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nModuleCreature) + "SubType" + IntToString(nSubType) + "ResRef");
                } else
                {
                    sResRef = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nModuleCreature) + "ResRef");
                }

                if (sResRef == "")
                {
                    sResRef = "id1_penguin";
                }

                int nDungeonCreature = GetLocalInt(oDungeon, "nListCreature_" + sResRef);
                if (nDungeonCreature == 0)
                {
                    nDungeonCreature = GetLocalInt(oDungeon, "nListCreatureNum");
                    nDungeonCreature++;
                    SetLocalInt(oDungeon, "nListCreatureNum", nDungeonCreature);
                    SetLocalString(oDungeon, "sListCreature" + IntToString(nDungeonCreature) + "ResRef", sResRef);
                    SetLocalInt(oDungeon, "nListCreature_" + sResRef, nDungeonCreature);

                    string sSingular = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nModuleCreature) + "NameSingular");
                    SetLocalString(oDungeon, "sListCreature" + IntToString(nDungeonCreature) + "NameSingular", sSingular);
                    string sPlural = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nModuleCreature) + "NamePlural");
                    SetLocalString(oDungeon, "sListCreature" + IntToString(nDungeonCreature) + "NamePlural", sPlural);
                    DebugMessage("  Singular is " + sSingular + ", plural is " + sPlural);

                    // attributes
                    int nAttributes = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nModuleCreature) + "Attributes");
                    DebugMessage("  nAttributes is " + IntToString(nAttributes));
                    SetLocalInt(oDungeon, "nListCreature" + IntToString(nDungeonCreature) + "Attributes", nAttributes);

                    // class and class start
                    int nClass;
                    if (nSubType > 0)
                    {
                        nClass = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nModuleCreature) + "SubType" + IntToString(nSubType) + "Class");
                    } else
                    {
                        nClass = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nModuleCreature) + "Class");
                    }
                    int nClassStartHD = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nModuleCreature) + "ClassStartHD");
                    DebugMessage("  nClass is " + IntToString(nClass) + ", nClassStartHD is " + IntToString(nClassStartHD));
                    SetLocalInt(oDungeon, "nListCreature" + IntToString(nDungeonCreature) + "Class", nClass);
                    SetLocalInt(oDungeon, "nListCreature" + IntToString(nDungeonCreature) + "ClassStartHD", nClassStartHD);
                }
                DebugMessage("Creature is dungeon number " + IntToString(nDungeonCreature) + " with resref " + sResRef);
                SetLocalInt(oDungeon, "n" + sCreature, nDungeonCreature);
                SetLocalInt(oDungeon, "n" + sCreature + "CR", nCR);

                int nTreasurePercentage;
                if (bBoss == TRUE)
                {
                    nTreasurePercentage = GetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_FREQUENCY);
                } else
                {
                    nTreasurePercentage = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_FREQUENCY);
                }

                int nRandom = d100();
                DebugMessage("  Random treasure number is " + IntToString(nRandom) + " vs " + IntToString(nTreasurePercentage));
                if (nRandom <= nTreasurePercentage)
                {
                    // run the treasure process
                    object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU68");
                    SetLocalInt(oMicroCPU, "nLevel", nCR);
                    SetLocalString(oMicroCPU, "sContainer", sCreature);
                    SetLocalInt(oMicroCPU, "bCreateTreasure", FALSE);
                    SetLocalObject(oMicroCPU, "oDungeon", oDungeon);

                    // treasure value
                    int nValue;
                    float fValue;
                    if (bBoss == TRUE)
                    {
                        nValue = GetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_VALUE);
                        fValue = (nValue / 100.0);
                        SetLocalFloat(oMicroCPU, "fValueMultiplier", fValue);
                    } else
                    {
                        nValue = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_VALUE);
                        fValue = (nValue / 100.0);
                        SetLocalFloat(oMicroCPU, "fValueMultiplier", fValue);
                    }

                    // read treasure from the creature type
                    int bGoldPresent = GetLocalInt(oDungeon, "bListCreature" + IntToString(nDungeonCreature) + "TreasureGold");
                    int bGemPresent = GetLocalInt(oDungeon, "bListCreature" + IntToString(nDungeonCreature) + "TreasureGems");
                    int bItemPresent = GetLocalInt(oDungeon, "bListCreature" + IntToString(nDungeonCreature) + "TreasureItems");
                    DebugMessage("  bGoldPresent is " + IntToString(bGoldPresent) + ", bGemPresent is " + IntToString(bGemPresent) + ", bItemPresent is " + IntToString(bItemPresent));
                    SetLocalInt(oMicroCPU, "bGoldPresent", bGoldPresent);
                    SetLocalInt(oMicroCPU, "bGemPresent", bGemPresent);
                    SetLocalInt(oMicroCPU, "bItemPresent", bItemPresent);
                    SetLocalInt(oMicroCPU, "bHold", bHold);

                    if (bHold == TRUE)
                    {
                        // increment number of active microprocessors
                        int nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                        nMicroNum++;
                        SetLocalInt(GetModule(), "nMicroNum", nMicroNum);
                    }

                    DelayCommand(0.01, ExecuteScript("exe_id1_mictre", oMicroCPU));
                }
            } else // if the creature is theme-based
            {
                // microprocess object
                oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU69");
                SetLocalString(oMicroCPU, "sCreature", sCreature);
                SetLocalInt(oMicroCPU, "nCR", nCR);
                SetLocalInt(oMicroCPU, "bIntelligentOnly", FALSE);
                SetLocalInt(oMicroCPU, "bUnIntelligentOnly", FALSE);
                SetLocalInt(oMicroCPU, "bMediumSizeOnly", FALSE);
                SetLocalInt(oMicroCPU, "bBoss", bBoss);
                SetLocalInt(oMicroCPU, "nTileset", nTileset);
                SetLocalInt(oMicroCPU, "nTheme", nTheme);
                SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                SetLocalInt(oMicroCPU, "bHold", bHold);

                if (bHold == TRUE)
                {
                    // increment number of active microprocessors
                    nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                    nMicroNum++;
                    SetLocalInt(GetModule(), "nMicroNum", nMicroNum);
                }

                DelayCommand(0.01, ExecuteScript("exe_id1_micmon", oMicroCPU));
            }
        }

        int nPlot = 1;
        while (nPlot <= nPlotNum)
        {
            // get real plot number
            nPlotID = GetLocalInt(oDungeon, "n" + sWaypoint + "Plot" + IntToString(nPlot));
            nCreature = Random(nEncounterSize) + 1;
            sCreature = sWaypoint + "Creature" + IntToString(nCreature);
            DebugMessage("Adding item for dungeon plot " + IntToString(nPlotID) + " to creature " + sCreature);

            if (nPlotID == -1) // if the special dungeon plot
            {
                // get item information
                nBossLevel = GetLocalInt(oDungeon, "nBossQuestLevel");
                nBossBoss = GetLocalInt(oDungeon, "nBossQuestBoss");
                if (nBossLevel == 1) // lieutenants
                {
                    if (nBossBoss == ID_LOCAL_LIEUTENANT_WEREBOAR)
                    {
                        sResRef = "id1_bossplot_ant";
                    } else if (nBossBoss == ID_LOCAL_LIEUTENANT_GIANTESS)
                    {
                        sResRef = "id1_bossplot_hag";
                    } else if (nBossBoss == ID_LOCAL_LIEUTENANT_INSECT)
                    {
                        sResRef = "id1_bossplot_mag";
                    }
                } else if (nBossLevel == 2) // inner circle
                {
                    if (nBossBoss == ID_LOCAL_BOSS_DEMON)
                    {
                        sResRef = "id1_bossplot_har";
                    } else if (nBossBoss == ID_LOCAL_BOSS_BEHOLDER)
                    {
                        sResRef = "id1_bossplot_gzb";
                    } else if (nBossBoss == ID_LOCAL_BOSS_LICH)
                    {
                        sResRef = "id1_bossplot_mas";
                    }
                }
                DebugMessage("Dungeon plot item type is resref " + sResRef);

                nItemType = GetLocalInt(oDungeon, "nListItem_" + sResRef);
                if (nItemType == 0)
                {
                    nItemType = GetLocalInt(oDungeon, "nListItemNum");
                    nItemType++;
                    SetLocalInt(oDungeon, "nListItemNum", nItemType);
                    SetLocalString(oDungeon, "sListItem" + IntToString(nItemType) + "ResRef", sResRef);
                    SetLocalInt(oDungeon, "nListItem_" + sResRef, nItemType);
                }
                DebugMessage("Dungeon plot item is dungeon number " + IntToString(nItemType));
            } else // if a normal plot
            {
                // get item information
                nItemType = GetLocalInt(oDungeon, "nPlot" + IntToString(nPlotID) + "Item");
                sResRef = GetLocalString(oDungeon, "sListItem" + IntToString(nItemType) + "ResRef");
                DebugMessage("Plot item type is " + IntToString(nItemType) + " with resref " + sResRef);
            }

            // add the item
            nItemNum = GetLocalInt(oDungeon, "n" + sCreature + "ItemNum");
            nItemNum++;
            SetLocalInt(oDungeon, "n" + sCreature + "ItemNum", nItemNum);

            // item details
            SetLocalInt(oDungeon, "n" + sCreature + "Item" + IntToString(nItemNum) + "ItemType", 2);
            SetLocalInt(oDungeon, "n" + sCreature + "Item" + IntToString(nItemNum) + "Size", 1);
            SetLocalInt(oDungeon, "n" + sCreature + "Item" + IntToString(nItemNum) + "Item", nItemType);
//            SetLocalString(oDungeon, "s" + sCreature + "Item" + IntToString(nItemNum) + "ResRef", sResRef);

            // cycle to next plot
            nPlot++;
        }
    }

    // if guards are needed
    if (bBoss == TRUE)
    {
        object oWaypoint = GetLocalObject(OBJECT_SELF, "oWaypoint");
        string sGuardPrefix = GetLocalString(OBJECT_SELF, "sGuardPrefix");
        string sGuardSuffix = GetLocalString(OBJECT_SELF, "sGuardSuffix");
        int nGuardPercentage = GetLocalInt(OBJECT_SELF, "nGuardPercentage");

        int nWaypoint = 1;
        object oGuardWaypoint = GetNearestObjectByTag("ID1_STATIC_WP_BOSS_GUARD", oWaypoint, nWaypoint);
        float fDistance = 0.0;
        int nNumber;
        string sGuardWaypoint;
        int bUsed;
        nBaseLevel -= 2;
        while ((oGuardWaypoint != OBJECT_INVALID) && (fDistance <= 20.0))
        {
            fDistance = fabs(GetDistanceBetween(oWaypoint, oGuardWaypoint));
            nNumber = GetLocalInt(oGuardWaypoint, "nNumber");
            DebugMessage("Found guard waypoint " + IntToString(nNumber) + " at distance " + FloatToString(fDistance));

            // if not used
            sGuardWaypoint = sGuardPrefix + IntToString(nNumber) + sGuardSuffix;
            DebugMessage("Waypoint string is " + sGuardWaypoint);
            bUsed = GetLocalInt(oDungeon, "b" + sGuardWaypoint + "Used");
            if (bUsed == FALSE)
            {
                nRandom = d100();
                DebugMessage("Random number is " + IntToString(nRandom) + " vs " + IntToString(nGuardPercentage));
                if (nRandom <= nGuardPercentage)
                {
                    SetLocalInt(oDungeon, "b" + sGuardWaypoint + "Used", TRUE);

                    // determine theme for this encounter if not set already
                    if (nTheme == -1)
                    {
                        nFlag = GetModuleFlag(ID1_FLAG_ENCOUNTER_TYPE);
                        if (nFlag == ID1_ENCOUNTER_TYPE_DUNGEON)
                        {
                            nTheme = -1;
                        } else if (nFlag == ID1_ENCOUNTER_TYPE_THEME)
                        {
                            nTheme = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TYPE);
                        } else if (nFlag == ID1_ENCOUNTER_TYPE_RANDOM)
                        {
                            nTheme = 1;
                        }
                    }

                    nEncounterSize = GetEncounterSize(nBaseLevel, nBaseSize, 0);
                    SetLocalInt(oDungeon, "n" + sGuardWaypoint + "Size", nEncounterSize);
                    DebugMessage("    Encounter size is " + IntToString(nEncounterSize));

                    // get level of encounter
                    nCR = GetEncounterLevel(nBaseLevel, nEncounterSize);
                    DebugMessage("    Encounter level is " + IntToString(nCR));

                    s2DA = "creatures";
                    sMonsterType = "Creature";

                    // generate normal creatures
                    DebugMessage("    Detailing guard creatures.");
                    nCreature = 1;
                    while (nCreature <= nEncounterSize)
                    {
                        sCreature = sGuardWaypoint + "Creature" + IntToString(nCreature);
                        DebugMessage("      CR for creature " + IntToString(nCreature) + " is " + IntToString(nCR));

                        // if a specific creature is chosen
                        if (GetModuleFlag(ID1_FLAG_ENCOUNTER_TYPE) == ID1_ENCOUNTER_TYPE_CREATURE)
                        {
                            // get creature number
                            nModuleCreature = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TYPE);
                            DebugMessage("      Module creature is " + IntToString(nModuleCreature));

                            // get if generated
/*                            bGenerated = GetLocalInt(GetModule(), "b" + sMonsterType + IntToString(nModuleCreature) + "Generated");
                            if (bGenerated == FALSE)
                            {
                                // if not, generate
                                GenerateCreatureDetails(sMonsterType + IntToString(nModuleCreature), s2DA);
                            }*/

                            // get if on the dungeon
                            int nSubType = 0;
                            int nSubTypeNum = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nModuleCreature) + "SubTypeNum");
                            if (nSubTypeNum > 0)
                            {
                                nSubType = Random(nSubTypeNum) + 1;
                                sResRef = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nModuleCreature) + "SubType" + IntToString(nSubType) + "ResRef");
                            } else
                            {
                                sResRef = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nModuleCreature) + "ResRef");
                            }

                            if (sResRef == "")
                            {
                                sResRef = "id1_penguin";
                            }

                            int nDungeonCreature = GetLocalInt(oDungeon, "nListCreature_" + sResRef);
                            if (nDungeonCreature == 0)
                            {
                                nDungeonCreature = GetLocalInt(oDungeon, "nListCreatureNum");
                                nDungeonCreature++;
                                SetLocalInt(oDungeon, "nListCreatureNum", nDungeonCreature);
                                SetLocalString(oDungeon, "sListCreature" + IntToString(nDungeonCreature) + "ResRef", sResRef);
                                SetLocalInt(oDungeon, "nListCreature_" + sResRef, nDungeonCreature);

                                string sSingular = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nModuleCreature) + "NameSingular");
                                SetLocalString(oDungeon, "sListCreature" + IntToString(nDungeonCreature) + "NameSingular", sSingular);
                                string sPlural = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nModuleCreature) + "NamePlural");
                                SetLocalString(oDungeon, "sListCreature" + IntToString(nDungeonCreature) + "NamePlural", sPlural);
                                DebugMessage("  Singular is " + sSingular + ", plural is " + sPlural);

                                // attributes
                                int nAttributes = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nModuleCreature) + "Attributes");
                                DebugMessage("  nAttributes is " + IntToString(nAttributes));
                                SetLocalInt(oDungeon, "nListCreature" + IntToString(nDungeonCreature) + "Attributes", nAttributes);

                                // class and class start
                                int nClass;
                                if (nSubType > 0)
                                {
                                    nClass = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nModuleCreature) + "SubType" + IntToString(nSubType) + "Class");
                                } else
                                {
                                    nClass = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nModuleCreature) + "Class");
                                }
                                int nClassStartHD = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nModuleCreature) + "ClassStartHD");
                                DebugMessage("  nClass is " + IntToString(nClass) + ", nClassStartHD is " + IntToString(nClassStartHD));
                                SetLocalInt(oDungeon, "nListCreature" + IntToString(nDungeonCreature) + "Class", nClass);
                                SetLocalInt(oDungeon, "nListCreature" + IntToString(nDungeonCreature) + "ClassStartHD", nClassStartHD);
                            }
                            DebugMessage("Creature is dungeon number " + IntToString(nDungeonCreature) + " with resref " + sResRef);
                            SetLocalInt(oDungeon, "n" + sCreature, nDungeonCreature);
                            SetLocalInt(oDungeon, "n" + sCreature + "CR", nCR);

                            int nTreasurePercentage = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_FREQUENCY);

                            int nRandom = d100();
                            DebugMessage("  Random treasure number is " + IntToString(nRandom) + " vs " + IntToString(nTreasurePercentage));
                            if (nRandom <= nTreasurePercentage)
                            {
                                // run the treasure process
                                object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU70");
                                SetLocalInt(oMicroCPU, "nLevel", nCR);
                                SetLocalString(oMicroCPU, "sContainer", sCreature);
                                SetLocalInt(oMicroCPU, "bCreateTreasure", FALSE);
                                SetLocalObject(oMicroCPU, "oDungeon", oDungeon);

                                // treasure value
                                int nValue;
                                float fValue;
                                if (bBoss == TRUE)
                                {
                                    nValue = GetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_VALUE);
                                    fValue = (nValue / 100.0);
                                    SetLocalFloat(oMicroCPU, "fValueMultiplier", fValue);
                                } else
                                {
                                    nValue = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_VALUE);
                                    fValue = (nValue / 100.0);
                                    SetLocalFloat(oMicroCPU, "fValueMultiplier", fValue);
                                }

                                // read treasure from the creature type
                                int bGoldPresent = GetLocalInt(oDungeon, "bListCreature" + IntToString(nDungeonCreature) + "TreasureGold");
                                int bGemPresent = GetLocalInt(oDungeon, "bListCreature" + IntToString(nDungeonCreature) + "TreasureGems");
                                int bItemPresent = GetLocalInt(oDungeon, "bListCreature" + IntToString(nDungeonCreature) + "TreasureItems");
                                DebugMessage("  bGoldPresent is " + IntToString(bGoldPresent) + ", bGemPresent is " + IntToString(bGemPresent) + ", bItemPresent is " + IntToString(bItemPresent));
                                SetLocalInt(oMicroCPU, "bGoldPresent", bGoldPresent);
                                SetLocalInt(oMicroCPU, "bGemPresent", bGemPresent);
                                SetLocalInt(oMicroCPU, "bItemPresent", bItemPresent);
                                SetLocalInt(oMicroCPU, "bHold", bHold);

                                if (bHold == TRUE)
                                {
                                    // increment number of active microprocessors
                                    int nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                                    nMicroNum++;
                                    SetLocalInt(GetModule(), "nMicroNum", nMicroNum);
                                }

                                DelayCommand(0.01, ExecuteScript("exe_id1_mictre", oMicroCPU));
                            }
                        } else // if the creature is theme-based
                        {
                            // microprocess object
                            oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU71");
                            SetLocalString(oMicroCPU, "sCreature", sCreature);
                            SetLocalInt(oMicroCPU, "nCR", nCR);
                            SetLocalInt(oMicroCPU, "bIntelligentOnly", FALSE);
                            SetLocalInt(oMicroCPU, "bUnIntelligentOnly", FALSE);
                            SetLocalInt(oMicroCPU, "bMediumSizeOnly", FALSE);
                            SetLocalInt(oMicroCPU, "bBoss", FALSE);
                            SetLocalInt(oMicroCPU, "nTileset", nTileset);
                            SetLocalInt(oMicroCPU, "nTheme", nTheme);
                            SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                            SetLocalInt(oMicroCPU, "bHold", bHold);

                            if (bHold == TRUE)
                            {
                                // increment number of active microprocessors
                                nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                                nMicroNum++;
                                SetLocalInt(GetModule(), "nMicroNum", nMicroNum);
                            }

                            DelayCommand(0.01, ExecuteScript("exe_id1_micmon", oMicroCPU));
                        }

                        nCreature++;
                    }
                }
            }

            // get next guard waypoint
            nWaypoint++;
            oGuardWaypoint = GetNearestObjectByTag("ID1_STATIC_WP_BOSS_GUARD", oWaypoint, nWaypoint);
        }
    }

    if (bHold == TRUE)
    {
        // increment, showing that this process is finished
        int nMicroDead = GetLocalInt(GetModule(), "nMicroDead");
        nMicroDead++;
        SetLocalInt(GetModule(), "nMicroDead", nMicroDead);
    }

    DebugMessage("");
    DebugMessage("==== " + sCreature + " ====");
    DebugMessage("====ENCOUNTER GENERATION MICROPROCESS END====");
    DebugMessage("");

    // destroy this object
    DelayCommand(0.1, DestroyObject(OBJECT_SELF));
}

void GenerateCreatureDetails(string sCreature, string s2DA)
{
    string sRead;
    int nLine;
    int nRead;

    SetLocalInt(GetModule(), "b" + sCreature + "Generated", TRUE);

    nLine = GetLocalInt(GetModule(), "n" + sCreature + "Line");

    // store names
    sRead = Get2DAString(s2DA, "Name_Singular", nLine);
    SetLocalString(GetModule(), "s" + sCreature + "NameSingular", sRead);
    DebugMessage("  Singular is " + sRead);
    sRead = Get2DAString(s2DA, "Name_Plural", nLine);
    SetLocalString(GetModule(), "s" + sCreature + "NamePlural", sRead);
    DebugMessage("  Plural is " + sRead);

    // store base CR
    sRead = Get2DAString(s2DA, "MinCR", nLine);
    if (sRead == "1/8")
    {
        nRead = -2;
    } else if (sRead == "1/4")
    {
        nRead = -1;
    } else if (sRead == "1/2")
    {
        nRead = 0;
    } else
    {
        nRead = StringToInt(sRead);
    }
    if (nRead < -2)
    {
        nRead = -2;
    }
    if (nRead > 50)
    {
        nRead = 50;
    }
    SetLocalInt(GetModule(), "n" + sCreature + "MinCR", nRead);
    DebugMessage("  Setting n" + sCreature + "MinCR to " + IntToString(nRead));
    int nMinCR = nRead;

    // store max CR
    sRead = Get2DAString(s2DA, "MaxCR", nLine);
    if (sRead == "1/8")
    {
        nRead = -2;
    } else if (sRead == "1/4")
    {
        nRead = -1;
    } else if (sRead == "1/2")
    {
        nRead = 0;
    } else
    {
        nRead = StringToInt(sRead);
    }
    if (nRead < nMinCR)
    {
        nRead = nMinCR;
    }
    if (nRead > 50)
    {
        nRead = 50;
    }
    SetLocalInt(GetModule(), "n" + sCreature + "MaxCR", nRead);
    DebugMessage("  Setting n" + sCreature + "MaxCR to " + IntToString(nRead));
    int nMaxCR = nRead;

    // store base HD
    sRead = Get2DAString(s2DA, "MinHD", nLine);
    SetLocalInt(GetModule(), "n" + sCreature + "MinHD", nRead);
    DebugMessage("  Setting n" + sCreature + "MinHD to " + IntToString(nRead));

    // store max HD
    sRead = Get2DAString(s2DA, "MaxHD", nLine);
    SetLocalInt(GetModule(), "n" + sCreature + "MaxHD", nRead);
    DebugMessage("  Setting n" + sCreature + "MaxHD to " + IntToString(nRead));

    // intelligent
    sRead = Get2DAString(s2DA, "Intelligent", nLine);
    nRead = StringToInt(sRead);
    SetLocalInt(GetModule(), "b" + sCreature + "Intelligent", nRead);
    DebugMessage("  Setting b" + sCreature + "Intelligent to " + IntToString(nRead));
    int bIntelligent = nRead;

    // medium size
    sRead = Get2DAString(s2DA, "MediumSize", nLine);
    nRead = StringToInt(sRead);
    SetLocalInt(GetModule(), "b" + sCreature + "MediumSize", nRead);
    DebugMessage("  Setting b" + sCreature + "MediumSize to " + IntToString(nRead));
    int bMediumSize = nRead;

    // level up class
    sRead = Get2DAString(s2DA, "Class", nLine);
    if (sRead == "")
    {
        nRead = -1;
    } else
    {
        nRead = StringToInt(sRead);
    }
    SetLocalInt(GetModule(), "n" + sCreature + "Class", nRead);
    DebugMessage("  Setting class to " + IntToString(nRead));

    // level up class starting HD
    sRead = Get2DAString(s2DA, "ClassStartHD", nLine);
    if (sRead == "")
    {
        nRead = -1;
    } else
    {
        nRead = StringToInt(sRead);
    }
    SetLocalInt(GetModule(), "n" + sCreature + "ClassStartHD", nRead);
    DebugMessage("  Setting level up class start HD to " + IntToString(nRead));

    // treasure - gold
    sRead = Get2DAString(s2DA, "TreasureGold", nLine);
    nRead = StringToInt(sRead);
    SetLocalInt(GetModule(), "b" + sCreature + "TreasureGold", nRead);
    DebugMessage("  Setting TreasureGold to " + IntToString(nRead));

    // treasure - gems
    sRead = Get2DAString(s2DA, "TreasureGems", nLine);
    nRead = StringToInt(sRead);
    SetLocalInt(GetModule(), "b" + sCreature + "TreasureGems", nRead);
    DebugMessage("  Setting TreasureGems to " + IntToString(nRead));

    // treasure - items
    sRead = Get2DAString(s2DA, "TreasureItems", nLine);
    nRead = StringToInt(sRead);
    SetLocalInt(GetModule(), "b" + sCreature + "TreasureItems", nRead);
    DebugMessage("  Setting TreasureItems to " + IntToString(nRead));

    // equip weapon
    sRead = Get2DAString(s2DA, "EquipWeapon", nLine);
    nRead = StringToInt(sRead);
    SetLocalInt(GetModule(), "b" + sCreature + "EquipWeapon", nRead);
    DebugMessage("  Setting EquipWeapon to " + IntToString(nRead));

    // equip armor
    sRead = Get2DAString(s2DA, "EquipArmor", nLine);
    nRead = StringToInt(sRead);
    SetLocalInt(GetModule(), "b" + sCreature + "EquipArmor", nRead);
    DebugMessage("  Setting EquipArmor to " + IntToString(nRead));

    // sub type
    sRead = Get2DAString(s2DA, "SubType", nLine);
    nRead = StringToInt(sRead);
    SetLocalInt(GetModule(), "b" + sCreature + "SubType", nRead);

    // catalog subtypes
    if (nRead == TRUE)
    {
        string sResRef = GetLocalString(GetModule(), "s" + sCreature + "ResRef");
        DebugMessage("  Subtypes are present. Reading file " + sResRef);

        nRead = 0;
        sRead = Get2DAString(sResRef, "ResRef", nRead);
        DebugMessage("  sRead is " + sRead);
        while (sRead != "")
        {
            nRead++;
            SetLocalInt(GetModule(), "n" + sCreature + "SubTypeNum", nRead);

            // resref
            DebugMessage("    Setting subtype " + IntToString(nRead) + " to " + sRead);
            SetLocalString(GetModule(), "s" + sCreature + "SubType" + IntToString(nRead) + "ResRef", sRead);

            // class
            sRead = Get2DAString(sResRef, "Class", nRead - 1);
            DebugMessage("    Setting class " + IntToString(nRead) + " to " + sRead);
            if (sRead == "")
            {
                SetLocalInt(GetModule(), "n" + sCreature + "SubType" + IntToString(nRead) + "Class", -1);
            } else
            {
                SetLocalInt(GetModule(), "n" + sCreature + "SubType" + IntToString(nRead) + "Class", StringToInt(sRead));
            }

            sRead = Get2DAString(sResRef, "ResRef", nRead);
        }
    }
}

