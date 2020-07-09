#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_utility"

void GenerateCreature(string sCreature, int nCR, int bIntelligent, int bUnIntelligent, int bMediumSize, int bMiniBoss, int nSpecificCreature, int nTileset, int nTheme, int bCreateCreature, object oLocation, object oDungeon);
int GetEncounterSize(int nEncounterLevel, int nPartySize, int nMinSize);
int GetEncounterLevel(int nEncounterLevel, int nEncounterSize);
int GetPartyLevelSize(int nPartyLevel, int nPartySize);

int GetIsMediumSize(int nAttributes);
int GetIsIntelligent(int nAttributes);
int GetIsSpellcaster(int nAttributes);
int GetIsGoldPresent(int nAttributes);
int GetIsGemPresent(int nAttributes);
int GetIsItemPresent(int nAttributes);
int GetIsEquipWeapon(int nAttributes);
int GetIsEquipArmor(int nAttributes);

void GenerateCreature(string sCreature, // the variable location of the creature
                        int nCR, // the difficulty level of the creature
                        int bIntelligent, // if only an intelligen creature should be chosen
                        int bUnIntelligent, // if only an unintelligent creature should be chosen
                        int bMediumSize, // if only a medium-sized creature should be chosen
                        int bMiniBoss, // if only a mini-boss should be chosen
                        int nSpecificCreature, // if a specific creature should be used
                        int nTileset, // the tileset of the area in which the creature appears (-1 to ignore)
                        int nTheme, // a specific theme to be used (-1 for dungeon themes)
                        int bCreateCreature, // if the creature should be created right away
                        object oLocation, // the object at whose location the creature should be spawned
                        object oDungeon) // the dungeon object on which all information is stored or retrieved from
{
    if (oDungeon == OBJECT_INVALID)
    {
        oDungeon = GetCurrentDungeon();
    }

    if (nCR < -1)
    {
        nCR = -1;
    }

    if (nCR > 50)
    {
        nCR = 50;
    }

    string sCreatureClass = "";
/*    if (bIntelligent == TRUE)
    {
        sCreatureClass += "Intelligent";
    } else if (bUnIntelligent == TRUE)
    {
        sCreatureClass += "UnIntelligent";
    }
    if (bMediumSize == TRUE)
    {
        sCreatureClass += "MediumSize";
    }*/
    if (bMiniBoss == TRUE)
    {
        sCreatureClass += "MiniBoss";
    } else
    {
        sCreatureClass += "Creature";
    }
    DebugMessage("      Set sCreatureClass to " + sCreatureClass);

    DebugMessage("      Intelligent = " + IntToString(bIntelligent) + ", UnIntelligent = " + IntToString(bUnIntelligent) + ", MediumSize = " + IntToString(bMediumSize));

    int bFound = FALSE;
    int nCreature;

    if (nSpecificCreature > 0)
    {
        bFound = TRUE;
        nCreature = nSpecificCreature;
        DebugMessage("      Creature was specified to be " + IntToString(nCreature));
    }

    // if a specific theme is not specified, use dungeon themes
    int nThemeNum;
    if (nTheme < 1)
    {
        // get number of primary themes
        nThemeNum = GetLocalInt(oDungeon, "nPrimaryTheme");
    } else // if using specific theme
    {
        DebugMessage("      Setting primary theme to theme " + IntToString(nTheme));
        nThemeNum = 1;
    }
    DebugMessage("      There are " + IntToString(nThemeNum) + " primary themes to examine.");

    // check each primary theme to find a creature
    int nTheme = 1;
    string sCurrentTheme;
    int nCurrentTheme;
    int bThemePresent;
    string sCreatureType;
    int nCreatureNum;
    int nRandom;
    int nStart;
    int bAcceptable;
    string sSpecificCreature;
    int bCreatureIntelligent;
    int bCreatureMediumSize;
    while ((nTheme <= nThemeNum) && (bFound == FALSE))
    {
        DebugMessage("        On theme " + IntToString(nTheme) + " of " + IntToString(nThemeNum));

        // if using dungeon themes
        if (nTheme < 1)
        {
            sCurrentTheme = GetLocalString(oDungeon, "sPrimaryTheme" + IntToString(nTheme) + "Name");
            nCurrentTheme = GetLocalInt(GetModule(), "nTheme_" + sCurrentTheme);
        } else // using specific them
        {
            sCurrentTheme = GetLocalString(GetModule(), "sTheme" + IntToString(nTheme) + "Name");
            nCurrentTheme = 1;
        }
        bThemePresent = GetLocalInt(GetModule(), "bTileset" + IntToString(nTileset) + "Theme" + IntToString(nCurrentTheme));
        DebugMessage("      For theme " + sCurrentTheme + ", bThemePresent is " + IntToString(bThemePresent));

        // if this theme is in the tileset, or tilesets are ignored
        if ((bThemePresent == TRUE) || (nTileset < 1))
        {
            // get number of creatures available at this level
            sCreatureType = "Theme" + IntToString(nCurrentTheme) + "CR" + IntToString(nCR) + sCreatureClass;
            nCreatureNum = GetLocalInt(GetModule(), "n" + sCreatureType);
            DebugMessage("      There are " + IntToString(nCreatureNum) + " creatures in " + sCreatureType);

            if (nCreatureNum > 0)
            {
                bAcceptable = TRUE;
                nRandom = Random(nCreatureNum) + 1;
                nStart = nRandom;

                sSpecificCreature = sCreatureType + IntToString(nRandom);
                nCreature = GetLocalInt(GetModule(), "n" + sSpecificCreature);
                DebugMessage("      Creature selected was " + IntToString(nRandom) + " in list, and actual creature " + IntToString(nCreature));
                bCreatureIntelligent = GetLocalInt(GetModule(), "bCreature" + IntToString(nCreature) + "Intelligent");
                bCreatureMediumSize = GetLocalInt(GetModule(), "bCreature" + IntToString(nCreature) + "MediumSize");
                DebugMessage("      Creature is intelligent " + IntToString(bCreatureIntelligent) + " and medium size " + IntToString(bCreatureMediumSize));
                if ((bIntelligent == TRUE) && (bCreatureIntelligent == FALSE))
                {
                    DebugMessage("        Creature is unintelligent, but seeking intelligent.");
                    bAcceptable = FALSE;
                }
                if ((bUnIntelligent == TRUE) && (bCreatureIntelligent == TRUE))
                {
                    DebugMessage("        Creature is intelligent, but seeking unintelligent.");
                    bAcceptable = FALSE;
                }
                if ((bMediumSize == TRUE) && (bCreatureMediumSize == FALSE))
                {
                    DebugMessage("        Creature is not medium size, but seeking medium size.");
                    bAcceptable = FALSE;
                }
                if (bAcceptable == FALSE)
                {
                    DebugMessage("        Unacceptable.");
                    nRandom++;
                    if (nRandom > nCreatureNum)
                    {
                        nRandom = 1;
                    }
                }
                while ((bAcceptable == FALSE) && (nRandom != nStart))
                {
                    sSpecificCreature = sCreatureType + IntToString(nRandom);
                    nCreature = GetLocalInt(GetModule(), "n" + sSpecificCreature);
                    DebugMessage("      Creature selected was " + IntToString(nRandom) + " in list, and actual creature " + IntToString(nCreature));
                    bCreatureIntelligent = GetLocalInt(GetModule(), "bCreature" + IntToString(nCreature) + "Intelligent");
                    bCreatureMediumSize = GetLocalInt(GetModule(), "bCreature" + IntToString(nCreature) + "MediumSize");
                    DebugMessage("      Creature is intelligent " + IntToString(bCreatureIntelligent) + " and medium size " + IntToString(bCreatureMediumSize));
                    if ((bIntelligent == TRUE) && (bCreatureIntelligent == FALSE))
                    {
                        DebugMessage("        Creature is unintelligent, but seeking intelligent.");
                        bAcceptable = FALSE;
                    }
                    if ((bUnIntelligent == TRUE) && (bCreatureIntelligent == TRUE))
                    {
                        DebugMessage("        Creature is intelligent, but seeking unintelligent.");
                        bAcceptable = FALSE;
                    }
                    if ((bMediumSize == TRUE) && (bCreatureMediumSize == FALSE))
                    {
                        DebugMessage("        Creature is not medium size, but seeking medium size.");
                        bAcceptable = FALSE;
                    }
                    if (bAcceptable == FALSE)
                    {
                        DebugMessage("        Unacceptable.");
                        nRandom++;
                        if (nRandom > nCreatureNum)
                        {
                            nRandom = 1;
                        }
                    }
                }

                if (bAcceptable == TRUE)
                {
                    DebugMessage("        Accepted.");
                    bFound = TRUE;
                } else
                {
                    DebugMessage("        Not accepted.");
                    nTheme++;
                }
            } else
            {
                nTheme++;
            }
        } else
        {
            nTheme++;
        }
    }

    // if a result has not been found and this is using dungeon themes
    if ((bFound == FALSE) && (nTheme < 1))
    {
        // get number of secondary themes
        nThemeNum = GetLocalInt(oDungeon, "nSecondaryTheme");
        DebugMessage("      There are " + IntToString(nThemeNum) + " secondary themes to examine.");

        // check each secondary theme to find a creature
        nTheme = 1;
        while ((nTheme <= nThemeNum) && (bFound == FALSE))
        {
            DebugMessage("        On theme " + IntToString(nTheme) + " of " + IntToString(nThemeNum));

            sCurrentTheme = GetLocalString(oDungeon, "sSecondaryTheme" + IntToString(nTheme) + "Name");
            nCurrentTheme = GetLocalInt(GetModule(), "nTheme_" + sCurrentTheme);
            bThemePresent = GetLocalInt(GetModule(), "bTileset" + IntToString(nTileset) + "Theme" + IntToString(nCurrentTheme));
            DebugMessage("      bThemePresent is " + IntToString(bThemePresent));

            // if this theme is in the tileset, or tilesets are ignored
            if ((bThemePresent == TRUE) || (nTileset < 1))
            {
                // get number of creatures available at this level
                sCreatureType = "Theme" + IntToString(nCurrentTheme) + "CR" + IntToString(nCR) + sCreatureClass;
                nCreatureNum = GetLocalInt(GetModule(), "n" + sCreatureType);
                DebugMessage("      There are " + IntToString(nCreatureNum) + " creatures in " + sCreatureType);

                if (nCreatureNum > 0)
                {
                    bAcceptable = TRUE;
                    nRandom = Random(nCreatureNum) + 1;
                    nStart = nRandom;

                    sSpecificCreature = sCreatureType + IntToString(nRandom);
                    nCreature = GetLocalInt(GetModule(), "n" + sSpecificCreature);
                    DebugMessage("      Creature selected was " + IntToString(nRandom) + " in list, and actual creature " + IntToString(nCreature));
                    bCreatureIntelligent = GetLocalInt(GetModule(), "bCreature" + IntToString(nCreature) + "Intelligent");
                    bCreatureMediumSize = GetLocalInt(GetModule(), "bCreature" + IntToString(nCreature) + "MediumSize");
                    DebugMessage("      Creature is intelligent " + IntToString(bCreatureIntelligent) + " and medium size " + IntToString(bCreatureMediumSize));
                    if ((bIntelligent == TRUE) && (bCreatureIntelligent == FALSE))
                    {
                        DebugMessage("        Creature is unintelligent, but seeking intelligent.");
                        bAcceptable = FALSE;
                    }
                    if ((bUnIntelligent == TRUE) && (bCreatureIntelligent == TRUE))
                    {
                        DebugMessage("        Creature is intelligent, but seeking unintelligent.");
                        bAcceptable = FALSE;
                    }
                    if ((bMediumSize == TRUE) && (bCreatureMediumSize == FALSE))
                    {
                        DebugMessage("        Creature is not medium size, but seeking medium size.");
                        bAcceptable = FALSE;
                    }
                    if (bAcceptable == FALSE)
                    {
                        DebugMessage("        Unacceptable.");
                        nRandom++;
                        if (nRandom > nCreatureNum)
                        {
                            nRandom = 1;
                        }
                    }
                    while ((bAcceptable == FALSE) && (nRandom != nStart))
                    {
                        sSpecificCreature = sCreatureType + IntToString(nRandom);
                        nCreature = GetLocalInt(GetModule(), "n" + sSpecificCreature);
                        DebugMessage("      Creature selected was " + IntToString(nRandom) + " in list, and actual creature " + IntToString(nCreature));
                        bCreatureIntelligent = GetLocalInt(GetModule(), "bCreature" + IntToString(nCreature) + "Intelligent");
                        bCreatureMediumSize = GetLocalInt(GetModule(), "bCreature" + IntToString(nCreature) + "MediumSize");
                        DebugMessage("      Creature is intelligent " + IntToString(bCreatureIntelligent) + " and medium size " + IntToString(bCreatureMediumSize));
                        if ((bIntelligent == TRUE) && (bCreatureIntelligent == FALSE))
                        {
                            DebugMessage("        Creature is unintelligent, but seeking intelligent.");
                            bAcceptable = FALSE;
                        }
                        if ((bUnIntelligent == TRUE) && (bCreatureIntelligent == TRUE))
                        {
                            DebugMessage("        Creature is intelligent, but seeking unintelligent.");
                            bAcceptable = FALSE;
                        }
                        if ((bMediumSize == TRUE) && (bCreatureMediumSize == FALSE))
                        {
                            DebugMessage("        Creature is not medium size, but seeking medium size.");
                            bAcceptable = FALSE;
                        }
                        if (bAcceptable == FALSE)
                        {
                            DebugMessage("        Unacceptable.");
                            nRandom++;
                            if (nRandom > nCreatureNum)
                            {
                                nRandom = 1;
                            }
                        }
                    }

                    if (bAcceptable == TRUE)
                    {
                        DebugMessage("        Accepted.");
                        bFound = TRUE;
                    } else
                    {
                        DebugMessage("        Not accepted.");
                        nTheme++;
                    }
                } else
                {
                    nTheme++;
                }
            } else
            {
                nTheme++;
            }
        }
    }

    // if a creature has been found
    if (bFound == TRUE)
    {
        DebugMessage("      A creature has been found.");

        if (bCreateCreature == FALSE)
        {
            SetLocalInt(oDungeon, "n" + sCreature + "CR", nCR);
            DebugMessage("      Setting n" + sCreature + "CR to " + IntToString(nCR));

            SetLocalInt(oDungeon, "n" + sCreature, nCreature);

            // if creature has a subtype
            int nSubTypeNum;
            if (bMiniBoss == FALSE)
            {
                nSubTypeNum = GetLocalInt(GetModule(), "nCreature" + IntToString(nCreature) + "SubTypeNum");
            } else
            {
                nSubTypeNum = GetLocalInt(GetModule(), "nMiniBoss" + IntToString(nCreature) + "SubTypeNum");
            }

            if (nSubTypeNum > 0)
            {
                int nSubType = Random(nSubTypeNum) + 1;
                SetLocalInt(oDungeon, "n" + sCreature + "SubType", nSubType);
                DebugMessage("Selected subtype " + IntToString(nSubType));
            }
        } else
        {
            // create the creature at the desired location
            string sResRef = GetLocalString(GetModule(), "sCreature" + IntToString(nCreature) + "ResRef");
//            int nMinHD = GetLocalInt(GetModule(), "nCreature" + IntToString(nCreature) + "MinHD");
            int nClassStartHD = GetLocalInt(GetModule(), "nCreature" + IntToString(nCreature) + "ClassStartHD");
            int nClass = GetLocalInt(GetModule(), "nCreature" + IntToString(nCreature) + "Class");

            object oCreature = CreateObject(OBJECT_TYPE_CREATURE, sResRef, GetLocation(oLocation));
            SetLocalInt(oCreature, "nCreatureType", 3);
            SetLocalInt(oCreature, "nCR", nCR);
//            SetLocalInt(oCreature, "nBaseHD", nMinHD);
            SetLocalInt(oCreature, "nClassStartHD", nClassStartHD);
            SetLocalInt(oCreature, "nClass", nClass);
        }
    } else // if no creature was found
    {
        DebugMessage("      No creature found.");

        if (bCreateCreature == FALSE)
        {
            // spawn in a penguin with an appropriate label
            SetLocalInt(oDungeon, "n" + sCreature, -1);
            SetLocalInt(oDungeon, "n" + sCreature + "CR", nCR);
        } else
        {
            // create a penguin at the desired location
            object oCreature = CreateObject(OBJECT_TYPE_CREATURE, "id1_penguin", GetLocation(oLocation));
            SetLocalInt(oCreature, "nCreatureType", 3);
            SetLocalInt(oCreature, "nCR", nCR);
//            SetLocalInt(oCreature, "nBaseHD", 1);
            SetLocalInt(oCreature, "nClassStartHD", 1);
            SetLocalInt(oCreature, "nClass", -1);
            SetName(oCreature, "Penguin CR " + IntToString(nCR));
        }
    }
}

int GetEncounterSize(int nEncounterLevel, int nPartySize, int nMinSize)
{
    if (nPartySize < 1)
    {
        nPartySize = 1;
    }
    DebugMessage("Getting encounter size for encounter level " + IntToString(nEncounterLevel) + " and party size " + IntToString(nPartySize) + " and minimum number of creatures " + IntToString(nMinSize));

    int nEncounterMin;
    int nEncounterMax;
    int nSizeMultiplier;

    int nSize = GetModuleFlag(ID1_FLAG_ENCOUNTER_SIZE);
    if (nSize == ID1_ENCOUNTER_SIZE_SINGLE)
    {
        DebugMessage("  Single encounter only.");

        nEncounterMin = 1;
        nEncounterMax = 1;
    } else // if multiple creatures
    {
        // determine number of creatures
        nEncounterMin = nPartySize;

        // if the encounter is a large size
        if (nSize == ID1_ENCOUNTER_SIZE_LARGE)
        {
            DebugMessage("  Large encounter.");

            // size is 1.5 to 2-3 times normal encounter size
            nSizeMultiplier = Random(2) + 2;
            nEncounterMax = nEncounterMin * nSizeMultiplier;
            nEncounterMin = FloatToInt(nEncounterMin * 1.5);
        } else if (nSize == ID1_ENCOUNTER_SIZE_HORDE) // if the encounter is a very large size
        {
            DebugMessage("  Horde encounter.");

            // size is 3.5 to 4-6 times normal encounter size
            nSizeMultiplier = Random(3) + 4;
            nEncounterMax = nEncounterMin * nSizeMultiplier;
            nEncounterMin = FloatToInt(nEncounterMin * 3.5);
        } else
        {
            DebugMessage("    Normal encounter.");

            nEncounterMax = nEncounterMin;
        }
    }
    DebugMessage("  Initial minimum number of creatures is " + IntToString(nEncounterMin) + " and max is " + IntToString(nEncounterMax));

    int nEncounterMaxSize = 1;
    int nTempLevel = nEncounterLevel + 2;
    DebugMessage("  Max encounter level is " + IntToString(nTempLevel) + " at size " + IntToString(nEncounterMaxSize));
    while ((nEncounterMaxSize < nEncounterMax) && (nTempLevel > -1))
    {
        nEncounterMaxSize *= 2;
        nTempLevel--;
        DebugMessage("  Max encounter level is " + IntToString(nTempLevel) + " at size " + IntToString(nEncounterMaxSize));
    }

    // if there is a potential limitation
    if (nTempLevel == -1)
    {
        // if the encounter cant have that many creatures
        if (nEncounterMaxSize < nEncounterMax)
        {
            nEncounterMax = nEncounterMaxSize;

            if (nEncounterMin > nEncounterMax)
            {
                nEncounterMin = nEncounterMax;
            }
        }
    }

    if (nEncounterMin < nMinSize)
    {
        DebugMessage("  Set encounter min to min size.");
        nEncounterMin = nMinSize;
    }
    if (nEncounterMax < nMinSize)
    {
        DebugMessage("  Set encounter max to min size.");
        nEncounterMax = nMinSize;
    }
    DebugMessage("  Final minimum number of creatures is " + IntToString(nEncounterMin) + " and max is " + IntToString(nEncounterMax));

    // adding hard limits to encounter size
    if (nEncounterMax > 8)
    {
        nEncounterMax = 8;
    }
    if (nEncounterMin > 8)
    {
        nEncounterMin = 8;
    }
    DebugMessage("  Hard-limited minimum number of creatures is " + IntToString(nEncounterMin) + " and max is " + IntToString(nEncounterMax));

    int nEncounterSize = Random(nEncounterMax - nEncounterMin + 1) + nEncounterMin;

    return nEncounterSize;
}

int GetEncounterLevel(int nEncounterLevel, int nEncounterSize)
{
    int nSize = 1;
    int nLevel = nEncounterLevel + 2;
    DebugMessage("  Encounter level is " + IntToString(nLevel) + " at size " + IntToString(nSize));
    while (nSize < nEncounterSize)
    {
        nSize *= 2;
        nLevel--;
        DebugMessage("  Encounter level is " + IntToString(nLevel) + " at size " + IntToString(nSize));
    }

    if (nLevel < -1)
    {
        nLevel = -1;
    }

    return nLevel;
}

int GetPartyLevelSize(int nPartyLevel, int nPartySize)
{
    int nSize = 1;
    int nLevel = nPartyLevel - 2;
    while (nSize < nPartySize)
    {
        nSize *= 2;
        nLevel++;
    }

    return nLevel;
}

int GetIsMediumSize(int nAttributes)
{
    if (nAttributes >= 10000000)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}

int GetIsIntelligent(int nAttributes)
{
    if (nAttributes >= 10000000)
    {
        nAttributes -= 10000000;
    }
    if (nAttributes >= 1000000)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}

int GetIsSpellcaster(int nAttributes)
{
    if (nAttributes >= 10000000)
    {
        nAttributes -= 10000000;
    }
    if (nAttributes >= 1000000)
    {
        nAttributes -= 1000000;
    }
    if (nAttributes >= 100000)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}

int GetIsGoldPresent(int nAttributes)
{
    if (nAttributes >= 10000000)
    {
        nAttributes -= 10000000;
    }
    if (nAttributes >= 1000000)
    {
        nAttributes -= 1000000;
    }
    if (nAttributes >= 100000)
    {
        nAttributes -= 100000;
    }
    if (nAttributes >= 10000)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}

int GetIsGemPresent(int nAttributes)
{
    if (nAttributes >= 10000000)
    {
        nAttributes -= 10000000;
    }
    if (nAttributes >= 1000000)
    {
        nAttributes -= 1000000;
    }
    if (nAttributes >= 100000)
    {
        nAttributes -= 100000;
    }
    if (nAttributes >= 10000)
    {
        nAttributes -= 10000;
    }
    if (nAttributes >= 1000)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}

int GetIsItemPresent(int nAttributes)
{
    if (nAttributes >= 10000000)
    {
        nAttributes -= 10000000;
    }
    if (nAttributes >= 1000000)
    {
        nAttributes -= 1000000;
    }
    if (nAttributes >= 100000)
    {
        nAttributes -= 100000;
    }
    if (nAttributes >= 10000)
    {
        nAttributes -= 10000;
    }
    if (nAttributes >= 1000)
    {
        nAttributes -= 1000;
    }
    if (nAttributes >= 100)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}

int GetIsEquipWeapon(int nAttributes)
{
    if (nAttributes >= 10000000)
    {
        nAttributes -= 10000000;
    }
    if (nAttributes >= 1000000)
    {
        nAttributes -= 1000000;
    }
    if (nAttributes >= 100000)
    {
        nAttributes -= 100000;
    }
    if (nAttributes >= 10000)
    {
        nAttributes -= 10000;
    }
    if (nAttributes >= 1000)
    {
        nAttributes -= 1000;
    }
    if (nAttributes >= 100)
    {
        nAttributes -= 100;
    }
    if (nAttributes >= 10)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}

int GetIsEquipArmor(int nAttributes)
{
    if (nAttributes >= 10000000)
    {
        nAttributes -= 10000000;
    }
    if (nAttributes >= 1000000)
    {
        nAttributes -= 1000000;
    }
    if (nAttributes >= 100000)
    {
        nAttributes -= 100000;
    }
    if (nAttributes >= 10000)
    {
        nAttributes -= 10000;
    }
    if (nAttributes >= 1000)
    {
        nAttributes -= 1000;
    }
    if (nAttributes >= 100)
    {
        nAttributes -= 100;
    }
    if (nAttributes >= 10)
    {
        nAttributes -= 10;
    }
    if (nAttributes >= 1)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}

//void main(){}

