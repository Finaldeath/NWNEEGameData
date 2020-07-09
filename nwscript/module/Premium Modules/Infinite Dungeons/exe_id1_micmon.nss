#include "inc_id1_debug"
#include "inc_id1_creature"

void main()
{
    // get variables
    string sCreature;
    int nCR;
    int bIntelligentOnly;
    int bUnIntelligentOnly;
    int bMediumSizeOnly;
    int bBoss;
    int nTileset;
    int nTheme;
    object oDungeon;
    int bHold;
    int bNoTreasure;
    object oTempHolder;

    // multistage creature generation process
    int nCreatureProcess = GetLocalInt(OBJECT_SELF, "nCreatureProcess");
    if (nCreatureProcess == 0) // select a theme, create holder
    {
        oTempHolder = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "TempHolder");

        // get variables
        sCreature = GetLocalString(OBJECT_SELF, "sCreature");
        SetLocalString(oTempHolder, "sCreature", sCreature);

        bIntelligentOnly = GetLocalInt(OBJECT_SELF, "bIntelligentOnly");
        SetLocalInt(oTempHolder, "bIntelligentOnly", bIntelligentOnly);

        bUnIntelligentOnly = GetLocalInt(OBJECT_SELF, "bUnIntelligentOnly");
        SetLocalInt(oTempHolder, "bUnIntelligentOnly", bUnIntelligentOnly);

        bMediumSizeOnly = GetLocalInt(OBJECT_SELF, "bMediumSizeOnly");
        SetLocalInt(oTempHolder, "bMediumSizeOnly", bMediumSizeOnly);

        bBoss = GetLocalInt(OBJECT_SELF, "bBoss");
        SetLocalInt(oTempHolder, "bBoss", bBoss);

        nCR = GetLocalInt(OBJECT_SELF, "nCR");
        if (bBoss == TRUE)
        {
            if (nCR < 1)
            {
                nCR = 1;
            }
        } else
        {
            if (nCR < -1)
            {
                nCR = -1;
            }
        }
        SetLocalInt(oTempHolder, "nCR", nCR);

        nTileset = GetLocalInt(OBJECT_SELF, "nTileset");
        SetLocalInt(oTempHolder, "nTileset", nTileset);

        nTheme = GetLocalInt(OBJECT_SELF, "nTheme");

        oDungeon = GetLocalObject(OBJECT_SELF, "oDungeon");
        SetLocalObject(oTempHolder, "oDungeon", oDungeon);

        bHold = GetLocalInt(OBJECT_SELF, "bHold");
        SetLocalInt(oTempHolder, "bHold", bHold);

        bNoTreasure = GetLocalInt(OBJECT_SELF, "bNoTreasure");
        SetLocalInt(oTempHolder, "bNoTreasure", bNoTreasure);

        string sMonsterType;
        if (bBoss == TRUE)
        {
            sMonsterType = "MiniBoss";
        } else
        {
            sMonsterType = "Creature";
        }

        DebugMessage("");
        DebugMessage("====CREATURE GENERATION MICROPROCESS START====");
        DebugMessage("==== " + sCreature + " ====");
        DebugMessage("");

        DebugMessage("");
        DebugMessage("==== " + sCreature + " Theme Selection Start ====");
        DebugMessage("");

        // if there is no theme specified
        if (nTheme < 1)
        {
            // if all creatures are a specific theme, use that theme
            if (GetModuleFlag(ID1_FLAG_ENCOUNTER_TYPE) == ID1_ENCOUNTER_TYPE_THEME)
            {
                nTheme = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TYPE);
                DebugMessage("Flag theme selected was " + IntToString(nTheme));
            } else // pick from primary and secondary themes
            {
                DebugMessage("Selecting random theme.");
                // determine max
                int nMax = 60;
                int nRandom = d100();
                int nThemeChoice;
                int nPrimaryTheme = GetLocalInt(oDungeon, "nPrimaryTheme");
                int nSecondaryTheme = GetLocalInt(oDungeon, "nSecondaryTheme");
                DebugMessage("  Primary num is " + IntToString(nPrimaryTheme) + ", Secondary num is " + IntToString(nSecondaryTheme));

                if ((nPrimaryTheme > 0) || (nSecondaryTheme > 0))
                {
                    int nActualTheme;
                    if (nPrimaryTheme < 1)
                    {
                        nMax = 0;
                    }
                    if (nSecondaryTheme < 1)
                    {
                        nMax = 100;
                    }
                    DebugMessage("  nRandom is " + IntToString(nRandom) + " and nMax is " + IntToString(nMax));
                    if (nRandom <= nMax) // use primary
                    {
                        // select a random primary
                        int nRandomTheme = Random(nPrimaryTheme) + 1;
                        int nStart = nRandomTheme;
                        string sThemeName = GetLocalString(oDungeon, "sPrimaryTheme" + IntToString(nRandomTheme) + "Name");
                        nActualTheme = GetLocalInt(GetModule(), "nTheme_" + sThemeName);
                        DebugMessage("  Primary theme is " + IntToString(nRandomTheme) + ", actual theme is " + IntToString(nActualTheme));
                        if (nTileset > 0)
                        {
                            int bAccept = GetLocalInt(GetModule(), "bTileset" + IntToString(nTileset) + "Theme" + IntToString(nActualTheme));
                            if (bAccept == FALSE)
                            {
                                DebugMessage("    Theme not accepted.");
                                nRandomTheme++;
                                if (nRandomTheme > nPrimaryTheme)
                                {
                                    nRandomTheme = 1;
                                }
                            }
                            while ((bAccept == FALSE) && (nRandomTheme != nStart))
                            {
                                sThemeName = GetLocalString(oDungeon, "sPrimaryTheme" + IntToString(nRandomTheme) + "Name");
                                nActualTheme = GetLocalInt(GetModule(), "nTheme_" + sThemeName);
                                DebugMessage("  Primary theme is " + IntToString(nRandomTheme) + ", actual theme is " + IntToString(nActualTheme));
                                bAccept = GetLocalInt(GetModule(), "bTileset" + IntToString(nTileset) + "Theme" + IntToString(nActualTheme));
                                if (bAccept == FALSE)
                                {
                                    DebugMessage("    Theme not accepted.");
                                    nRandomTheme++;
                                    if (nRandomTheme > nPrimaryTheme)
                                    {
                                        nRandomTheme = 1;
                                    }
                                }
                            }
                        }
                    } else
                    {
                        // select a random primary
                        int nRandomTheme = Random(nSecondaryTheme) + 1;
                        int nStart = nRandomTheme;
                        string sThemeName = GetLocalString(oDungeon, "sSecondaryTheme" + IntToString(nRandomTheme) + "Name");
                        nActualTheme = GetLocalInt(GetModule(), "nTheme_" + sThemeName);
                        DebugMessage("  Secondary theme is " + IntToString(nRandomTheme) + ", actual theme is " + IntToString(nActualTheme));
                        if (nTileset > 0)
                        {
                            int bAccept = GetLocalInt(GetModule(), "bTileset" + IntToString(nTileset) + "Theme" + IntToString(nActualTheme));
                            if (bAccept == FALSE)
                            {
                                DebugMessage("    Theme not accepted.");
                                nRandomTheme++;
                                if (nRandomTheme > nSecondaryTheme)
                                {
                                    nRandomTheme = 1;
                                }
                            }
                            while ((bAccept == FALSE) && (nRandomTheme != nStart))
                            {
                                sThemeName = GetLocalString(oDungeon, "sSecondaryTheme" + IntToString(nRandomTheme) + "Name");
                                nActualTheme = GetLocalInt(GetModule(), "nTheme_" + sThemeName);
                                DebugMessage("  Secondary theme is " + IntToString(nRandomTheme) + ", actual theme is " + IntToString(nActualTheme));
                                bAccept = GetLocalInt(GetModule(), "bTileset" + IntToString(nTileset) + "Theme" + IntToString(nActualTheme));
                                if (bAccept == FALSE)
                                {
                                    DebugMessage("    Theme not accepted.");
                                    nRandomTheme++;
                                    if (nRandomTheme > nSecondaryTheme)
                                    {
                                        nRandomTheme = 1;
                                    }
                                }
                            }
                        }
                    }
                    nTheme = nActualTheme;
                } else // if there are no themes, use THEME_ALL
                {
                    nTheme = 1;
                }
            }

            DebugMessage("  Theme set to " + IntToString(nTheme));

            SetLocalInt(oTempHolder, "nTheme", nTheme);
        } else // if a theme is already specified
        {
            DebugMessage("Theme already specified at " + IntToString(nTheme));

            SetLocalInt(oTempHolder, "nTheme", nTheme);
        }

        DebugMessage("");
        DebugMessage("==== " + sCreature + " Theme Selection End ====");
        DebugMessage("");

        if (nTheme == 1)
        {
            nCreatureProcess = 3;
        } else
        {
            nCreatureProcess = 1;
        }

        SetLocalInt(oTempHolder, "nPosition", 1);

        object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU89");
        SetLocalInt(oMicroCPU, "nCreatureProcess", nCreatureProcess);
        SetLocalObject(oMicroCPU, "oTempHolder", oTempHolder);
        DelayCommand(0.01, ExecuteScript("exe_id1_micmon", oMicroCPU));
    } else  if (nCreatureProcess == 1) // parse creature list for acceptable ones, and select a creature
    {
        oTempHolder = GetLocalObject(OBJECT_SELF, "oTempHolder");
        oDungeon = GetLocalObject(oTempHolder, "oDungeon");
        string sProcessCreature = GetLocalString(oTempHolder, "sCreature");

        string sMonsterType;
        bBoss = GetLocalInt(oTempHolder, "bBoss");
        if (bBoss == TRUE)
        {
            sMonsterType = "MiniBoss";
        } else
        {
            sMonsterType = "Creature";
        }

        DebugMessage("");
        DebugMessage("==== " + sProcessCreature + " " + sMonsterType + " Parsing Start ====");
        DebugMessage("");

        int nTheme = GetLocalInt(oTempHolder, "nTheme");
        string sThemeCreature = "nTheme" + IntToString(nTheme) + sMonsterType;
        int nCreatureNum = GetLocalInt(GetModule(), sThemeCreature);
        DebugMessage("There are " + IntToString(nCreatureNum) + " creatures in " + sThemeCreature);
        int nPosition = GetLocalInt(oTempHolder, "nPosition");
        int nCount = 0;
        int nMinCR;
        int nMaxCR;
        nCR = GetLocalInt(oTempHolder, "nCR");
        bIntelligentOnly = GetLocalInt(oTempHolder, "bIntelligentOnly");
        bUnIntelligentOnly = GetLocalInt(oTempHolder, "bUnIntelligentOnly");
        bMediumSizeOnly = GetLocalInt(oTempHolder, "bMediumSizeOnly");
        int bIntelligentTest;
        int bMediumTest;
        int bIntelligent;
        int bMediumSize;
        int nCreature;
        int nParseNum;
        int nParse;
        string sName;
        int nAttributes;

        while ((nPosition <= nCreatureNum) && (nCount < 100))
        {
            nCreature = GetLocalInt(GetModule(), sThemeCreature + IntToString(nPosition));
            DebugMessage("Checking " + sThemeCreature + IntToString(nPosition) + " which is " + sMonsterType + " " + IntToString(nCreature));

            sCreature = sMonsterType + IntToString(nCreature);

            sName = GetLocalString(GetModule(), "s" + sCreature + "NameSingular");
            DebugMessage("  Creature is name " + sName);

            nMinCR = GetLocalInt(GetModule(), "n" + sCreature + "MinCR");
            nMaxCR = GetLocalInt(GetModule(), "n" + sCreature + "MaxCR");
            DebugMessage("  " + sCreature + " has min CR " + IntToString(nMinCR) + " and max " + IntToString(nMaxCR) + " vs target " + IntToString(nCR));
            if ((nCR >= nMinCR) && (nCR <= nMaxCR))
            {
                DebugMessage("    Creature is of correct level range.");

                nAttributes = GetLocalInt(GetModule(), "n" + sCreature + "Attributes");

                if ((bIntelligentOnly == TRUE) || (bUnIntelligentOnly == TRUE))
                {
                    bIntelligent = GetIsIntelligent(nAttributes);
                    if ((bIntelligent == TRUE) && (bIntelligentOnly == TRUE))
                    {
                        bIntelligentTest = TRUE;
                    } else if ((bIntelligent == FALSE) && (bUnIntelligentOnly == TRUE))
                    {
                        bIntelligentTest = TRUE;
                    } else
                    {
                        bIntelligentTest = FALSE;
                    }
                } else
                {
                    bIntelligentTest = TRUE;
                }

                if (bMediumSizeOnly == TRUE)
                {
                    bMediumSize = GetIsMediumSize(nAttributes);
                    if ((bMediumSize == TRUE) && (bMediumSizeOnly == TRUE))
                    {
                        bMediumTest = TRUE;
                    } else
                    {
                        bMediumTest = FALSE;
                    }
                } else
                {
                    bMediumTest = TRUE;
                }

                if ((bMediumTest == TRUE) && (bIntelligentTest == TRUE))
                {
                    DebugMessage("    " + sMonsterType + " passes intelligence and size tests. Adding.");

                    nParseNum = GetLocalInt(oTempHolder, "nParseNum");
                    nParseNum++;
                    SetLocalInt(oTempHolder, "nParseNum", nParseNum);
                    SetLocalInt(oTempHolder, "nParse" + IntToString(nParseNum), nCreature);
                    DebugMessage("    Set nParse" + IntToString(nParseNum) + " to " + IntToString(nCreature));
                }
            }

            nPosition++;
            nCount++;
        }

        if (nPosition > nCreatureNum)
        {
            nParseNum = GetLocalInt(oTempHolder, "nParseNum");
            if (nParseNum > 0)
            {
                nParse = Random(nParseNum) + 1;
                nCreature = GetLocalInt(oTempHolder, "nParse" + IntToString(nParse));
            } else
            {
                nCreature = -1;
            }
            DebugMessage("  Selected " + sMonsterType + " " + IntToString(nParse) + " out of " + IntToString(nParseNum) + " which is actual creature " + IntToString(nCreature));

            // check for subtypes
            string sResRef = "";
            int nSubType = 0;
            int nSubTypeNum = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nCreature) + "SubTypeNum");
            if (nSubTypeNum > 0)
            {
                nSubType = Random(nSubTypeNum) + 1;
                sResRef = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nCreature) + "SubType" + IntToString(nSubType) + "ResRef");
            } else
            {
                sResRef = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nCreature) + "ResRef");
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

                string sSingular = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nCreature) + "NameSingular");
                SetLocalString(oDungeon, "sListCreature" + IntToString(nDungeonCreature) + "NameSingular", sSingular);
                string sPlural = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nCreature) + "NamePlural");
                SetLocalString(oDungeon, "sListCreature" + IntToString(nDungeonCreature) + "NamePlural", sPlural);
                DebugMessage("  Singular is " + sSingular + ", plural is " + sPlural);

                // attributes
                int nAttributes = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nCreature) + "Attributes");
                DebugMessage("  nAttributes is " + IntToString(nAttributes));
                SetLocalInt(oDungeon, "nListCreature" + IntToString(nDungeonCreature) + "Attributes", nAttributes);

                // class and class start
                int nClass;
                if (nSubType > 0)
                {
                    nClass = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nCreature) + "SubType" + IntToString(nSubType) + "Class");
                } else
                {
                    nClass = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nCreature) + "Class");
                }
                int nClassStartHD = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nCreature) + "ClassStartHD");
                DebugMessage("  nClass is " + IntToString(nClass) + ", nClassStartHD is " + IntToString(nClassStartHD));
                SetLocalInt(oDungeon, "nListCreature" + IntToString(nDungeonCreature) + "Class", nClass);
                SetLocalInt(oDungeon, "nListCreature" + IntToString(nDungeonCreature) + "ClassStartHD", nClassStartHD);
            }
            DebugMessage("Creature is dungeon number " + IntToString(nDungeonCreature) + " with resref " + sResRef);
            SetLocalInt(oDungeon, "n" + sProcessCreature, nDungeonCreature);
            SetLocalInt(oDungeon, "n" + sProcessCreature + "CR", nCR);
            DebugMessage("Set n" + sProcessCreature + " to " + IntToString(nDungeonCreature) + " with CR " + IntToString(nCR));
            SetLocalInt(oDungeon, "b" + sProcessCreature + "Dead", FALSE);

            bNoTreasure = GetLocalInt(oTempHolder, "bNoTreasure");
            if (bNoTreasure == TRUE)
            {
                DestroyObject(oTempHolder);

                DebugMessage("");
                DebugMessage("==== " + sProcessCreature + " " + sMonsterType + " Parsing End ====");
                DebugMessage("");


                bHold = GetLocalInt(oTempHolder, "bHold");
                if (bHold == TRUE)
                {
                    // increment, showing that this process is finished
                    int nMicroDead = GetLocalInt(GetModule(), "nMicroDead");
                    nMicroDead++;
                    SetLocalInt(GetModule(), "nMicroDead", nMicroDead);
                }
            } else
            {
                int nTreasurePercentage;
                if (bBoss == TRUE)
                {
                    nTreasurePercentage = GetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_FREQUENCY);
                } else
                {
                    nTreasurePercentage = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_FREQUENCY);
                }

                DebugMessage("");
                DebugMessage("==== " + sProcessCreature + " " + sMonsterType + " Parsing End ====");
                DebugMessage("");

                int nRandom = d100();
                DebugMessage("  Random treasure number is " + IntToString(nRandom) + " vs " + IntToString(nTreasurePercentage));
                if (nRandom <= nTreasurePercentage)
                {
                    nCreatureProcess = 2;

                    object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU90");
                    SetLocalInt(oMicroCPU, "nCreatureProcess", nCreatureProcess);
                    SetLocalObject(oMicroCPU, "oTempHolder", oTempHolder);
                    SetLocalInt(oMicroCPU, "nCreature", nDungeonCreature);
                    DelayCommand(0.01, ExecuteScript("exe_id1_micmon", oMicroCPU));
                } else
                {
                    DestroyObject(oTempHolder);

                    bHold = GetLocalInt(oTempHolder, "bHold");
                    if (bHold == TRUE)
                    {
                        // increment, showing that this process is finished
                        int nMicroDead = GetLocalInt(GetModule(), "nMicroDead");
                        nMicroDead++;
                        SetLocalInt(GetModule(), "nMicroDead", nMicroDead);
                    }
                }
            }
        } else
        {
            SetLocalInt(oTempHolder, "nPosition", nPosition);

            object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU91");
            SetLocalInt(oMicroCPU, "nCreatureProcess", nCreatureProcess);
            SetLocalObject(oMicroCPU, "oTempHolder", oTempHolder);
            DelayCommand(0.01, ExecuteScript("exe_id1_micmon", oMicroCPU));
        }
    } else  if (nCreatureProcess == 2) // generate treasure
    {
        oTempHolder = GetLocalObject(OBJECT_SELF, "oTempHolder");
        oDungeon = GetLocalObject(oTempHolder, "oDungeon");
        nCR = GetLocalInt(oTempHolder, "nCR");
        string sProcessCreature = GetLocalString(oTempHolder, "sCreature");
        int nCreatureType = GetLocalInt(OBJECT_SELF, "nCreature");

        string sMonsterType;
        bBoss = GetLocalInt(oTempHolder, "bBoss");
        if (bBoss == TRUE)
        {
            sMonsterType = "MiniBoss";
        } else
        {
            sMonsterType = "Creature";
        }

        DebugMessage("");
        DebugMessage("==== " + sProcessCreature + " " + sMonsterType + " Treasure Start ====");
        DebugMessage("");

        // run the treasure process
        object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU92");
        SetLocalInt(oMicroCPU, "nLevel", nCR);
        SetLocalString(oMicroCPU, "sContainer", sProcessCreature);
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
        int nAttributes = GetLocalInt(oDungeon, "nListCreature" + IntToString(nCreatureType) + "Attributes");
        int bGoldPresent = GetIsGoldPresent(nAttributes);
        int bGemPresent = GetIsGemPresent(nAttributes);
        int bItemPresent = GetIsItemPresent(nAttributes);
        DebugMessage("  nAttributes is " + IntToString(nAttributes) + ", bGoldPresent is " + IntToString(bGoldPresent) + ", bGemPresent is " + IntToString(bGemPresent) + ", bItemPresent is " + IntToString(bItemPresent));
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

        // clean up
        DestroyObject(oTempHolder);

        DebugMessage("");
        DebugMessage("==== " + sProcessCreature + " " + sMonsterType + " Treasure End ====");
        DebugMessage("");


        bHold = GetLocalInt(oTempHolder, "bHold");
        if (bHold == TRUE)
        {
            // increment, showing that this process is finished
            int nMicroDead = GetLocalInt(GetModule(), "nMicroDead");
            nMicroDead++;
            SetLocalInt(GetModule(), "nMicroDead", nMicroDead);
        }
    } else if (nCreatureProcess == 3) // generate generic
    {
        oTempHolder = GetLocalObject(OBJECT_SELF, "oTempHolder");
        oDungeon = GetLocalObject(oTempHolder, "oDungeon");
        string sProcessCreature = GetLocalString(oTempHolder, "sCreature");

        string sMonsterType;
        bBoss = GetLocalInt(oTempHolder, "bBoss");
        if (bBoss == TRUE)
        {
            sMonsterType = "MiniBoss";
        } else
        {
            sMonsterType = "Creature";
        }

        DebugMessage("");
        DebugMessage("==== " + sProcessCreature + " " + sMonsterType + " Parsing Start ====");
        DebugMessage("");

        nCR = GetLocalInt(oTempHolder, "nCR");
        string sThemeCreature = "nGeneric" + IntToString(nCR) + sMonsterType;
        int nCreatureNum = GetLocalInt(GetModule(), sThemeCreature + "Num");
        DebugMessage("There are " + IntToString(nCreatureNum) + " creatures in " + sThemeCreature + "Num");
        int nPosition = GetLocalInt(oTempHolder, "nPosition");
        int nCount = 0;
        bIntelligentOnly = GetLocalInt(oTempHolder, "bIntelligentOnly");
        bUnIntelligentOnly = GetLocalInt(oTempHolder, "bUnIntelligentOnly");
        bMediumSizeOnly = GetLocalInt(oTempHolder, "bMediumSizeOnly");
        int bIntelligentTest;
        int bMediumTest;
        int bIntelligent;
        int bMediumSize;
        int nCreature;
        int nParseNum;
        int nParse;
        string sName;
        int nAttributes;

        while ((nPosition <= nCreatureNum) && (nCount < 100))
        {
            nCreature = GetLocalInt(GetModule(), sThemeCreature + IntToString(nPosition));
            DebugMessage("Checking " + sThemeCreature + IntToString(nPosition) + " which is " + sMonsterType + " " + IntToString(nCreature));

            sCreature = sMonsterType + IntToString(nCreature);

            sName = GetLocalString(GetModule(), "s" + sCreature + "NameSingular");
            DebugMessage("  Creature is name " + sName);

            nAttributes = GetLocalInt(GetModule(), "n" + sCreature + "Attributes");

            if ((bIntelligentOnly == TRUE) || (bUnIntelligentOnly == TRUE))
            {
                bIntelligent = GetIsIntelligent(nAttributes);
                if ((bIntelligent == TRUE) && (bIntelligentOnly == TRUE))
                {
                    bIntelligentTest = TRUE;
                } else if ((bIntelligent == FALSE) && (bUnIntelligentOnly == TRUE))
                {
                    bIntelligentTest = TRUE;
                } else
                {
                    bIntelligentTest = FALSE;
                }
            } else
            {
                bIntelligentTest = TRUE;
            }

            if (bMediumSizeOnly == TRUE)
            {
                bMediumSize = GetIsMediumSize(nAttributes);
                if ((bMediumSize == TRUE) && (bMediumSizeOnly == TRUE))
                {
                    bMediumTest = TRUE;
                } else
                {
                    bMediumTest = FALSE;
                }
            } else
            {
                bMediumTest = TRUE;
            }

            if ((bMediumTest == TRUE) && (bIntelligentTest == TRUE))
            {
                DebugMessage("    " + sMonsterType + " passes intelligence and size tests. Adding.");

                nParseNum = GetLocalInt(oTempHolder, "nParseNum");
                nParseNum++;
                SetLocalInt(oTempHolder, "nParseNum", nParseNum);
                SetLocalInt(oTempHolder, "nParse" + IntToString(nParseNum), nCreature);
                DebugMessage("    Set nParse" + IntToString(nParseNum) + " to " + IntToString(nCreature));
            }

            nPosition++;
            nCount++;
        }

        if (nPosition > nCreatureNum)
        {
            nParseNum = GetLocalInt(oTempHolder, "nParseNum");
            if (nParseNum > 0)
            {
                nParse = Random(nParseNum) + 1;
                nCreature = GetLocalInt(oTempHolder, "nParse" + IntToString(nParse));
            } else
            {
                nCreature = -1;
            }
            DebugMessage("  Selected " + sMonsterType + " " + IntToString(nParse) + " out of " + IntToString(nParseNum) + " which is actual creature " + IntToString(nCreature));

            // check for subtypes
            string sResRef = "";
            int nSubType = 0;
            int nSubTypeNum = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nCreature) + "SubTypeNum");
            if (nSubTypeNum > 0)
            {
                nSubType = Random(nSubTypeNum) + 1;
                sResRef = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nCreature) + "SubType" + IntToString(nSubType) + "ResRef");
            } else
            {
                sResRef = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nCreature) + "ResRef");
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

                string sSingular = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nCreature) + "NameSingular");
                SetLocalString(oDungeon, "sListCreature" + IntToString(nDungeonCreature) + "NameSingular", sSingular);
                string sPlural = GetLocalString(GetModule(), "s" + sMonsterType + IntToString(nCreature) + "NamePlural");
                SetLocalString(oDungeon, "sListCreature" + IntToString(nDungeonCreature) + "NamePlural", sPlural);
                DebugMessage("  Singular is " + sSingular + ", plural is " + sPlural);

                // attributes
                int nAttributes = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nCreature) + "Attributes");
                DebugMessage("  nAttributes is " + IntToString(nAttributes));
                SetLocalInt(oDungeon, "nListCreature" + IntToString(nDungeonCreature) + "Attributes", nAttributes);

                // class and class start
                int nClass;
                if (nSubType > 0)
                {
                    nClass = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nCreature) + "SubType" + IntToString(nSubType) + "Class");
                } else
                {
                    nClass = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nCreature) + "Class");
                }
                int nClassStartHD = GetLocalInt(GetModule(), "n" + sMonsterType + IntToString(nCreature) + "ClassStartHD");
                DebugMessage("  nClass is " + IntToString(nClass) + ", nClassStartHD is " + IntToString(nClassStartHD));
                SetLocalInt(oDungeon, "nListCreature" + IntToString(nDungeonCreature) + "Class", nClass);
                SetLocalInt(oDungeon, "nListCreature" + IntToString(nDungeonCreature) + "ClassStartHD", nClassStartHD);
            }
            DebugMessage("Creature is dungeon number " + IntToString(nDungeonCreature) + " with resref " + sResRef);
            SetLocalInt(oDungeon, "n" + sProcessCreature, nDungeonCreature);
            SetLocalInt(oDungeon, "n" + sProcessCreature + "CR", nCR);
            DebugMessage("Set n" + sProcessCreature + " to " + IntToString(nDungeonCreature) + " with CR " + IntToString(nCR));
            SetLocalInt(oDungeon, "b" + sProcessCreature + "Dead", FALSE);

            bNoTreasure = GetLocalInt(oTempHolder, "bNoTreasure");
            if (bNoTreasure == TRUE)
            {
                DestroyObject(oTempHolder);

                DebugMessage("");
                DebugMessage("==== " + sProcessCreature + " " + sMonsterType + " Parsing End ====");
                DebugMessage("");


                bHold = GetLocalInt(oTempHolder, "bHold");
                if (bHold == TRUE)
                {
                    // increment, showing that this process is finished
                    int nMicroDead = GetLocalInt(GetModule(), "nMicroDead");
                    nMicroDead++;
                    SetLocalInt(GetModule(), "nMicroDead", nMicroDead);
                }
            } else
            {
                int nTreasurePercentage;
                if (bBoss == TRUE)
                {
                    nTreasurePercentage = GetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_FREQUENCY);
                } else
                {
                    nTreasurePercentage = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_FREQUENCY);
                }

                DebugMessage("");
                DebugMessage("==== " + sProcessCreature + " " + sMonsterType + " Parsing End ====");
                DebugMessage("");

                int nRandom = d100();
                DebugMessage("  Random treasure number is " + IntToString(nRandom) + " vs " + IntToString(nTreasurePercentage));
                if (nRandom <= nTreasurePercentage)
                {
                    nCreatureProcess = 2;

                    object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU90");
                    SetLocalInt(oMicroCPU, "nCreatureProcess", nCreatureProcess);
                    SetLocalObject(oMicroCPU, "oTempHolder", oTempHolder);
                    SetLocalInt(oMicroCPU, "nCreature", nDungeonCreature);
                    DelayCommand(0.01, ExecuteScript("exe_id1_micmon", oMicroCPU));
                } else
                {
                    DestroyObject(oTempHolder);

                    bHold = GetLocalInt(oTempHolder, "bHold");
                    if (bHold == TRUE)
                    {
                        // increment, showing that this process is finished
                        int nMicroDead = GetLocalInt(GetModule(), "nMicroDead");
                        nMicroDead++;
                        SetLocalInt(GetModule(), "nMicroDead", nMicroDead);
                    }
                }
            }
        } else
        {
            SetLocalInt(oTempHolder, "nPosition", nPosition);

            object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU91");
            SetLocalInt(oMicroCPU, "nCreatureProcess", nCreatureProcess);
            SetLocalObject(oMicroCPU, "oTempHolder", oTempHolder);
            DelayCommand(0.01, ExecuteScript("exe_id1_micmon", oMicroCPU));
        }
    }

    // destroy this object
    DelayCommand(0.1, DestroyObject(OBJECT_SELF));
}

