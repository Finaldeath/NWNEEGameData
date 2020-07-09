#include "inc_id1_debug"

const int N = 1;
const int E = 2;
const int S = 4;
const int W = 8;
const int NE = 3;
const int NS = 5;
const int NW = 9;
const int ES = 6;
const int EW = 10;
const int SW = 12;
const int NES = 7;
const int NEW = 11;
const int NSW = 13;
const int ESW = 14;
const int NESW = 15;

const int BEHOLDER_CAVES = 1;
const int CASTLE_INTERIOR = 2;
const int CRYPT = 3;
const int DESERT = 4;
const int DROW_INTERIOR = 5;
const int DUNGEON = 6;
const int FOREST = 7;
const int FROZEN_WASTES = 8;
const int ILLITHID_INTERIOR = 9;
const int MINES_AND_CAVERNS = 10;
const int RUINS = 11;
const int SEWERS = 12;
const int UNDERDARK = 13;
const int STEAMWORKS = 14;
const int KEEP_INTERIOR_STONE = 15;

int GetDistanceArea(int nTileset, int nNumber, int nDistance, int nIdealConfiguration, int nMandatoryConfiguration, int nLevel, object oDungeon);
int GetAreaCategorySize(int nMandatoryConfiguration);
int GetAreaCategoryConfiguration(int nIdealConfiguration, int nMandatoryConfiguration, int nNumber);
string GetTilesetArea(int nTileset, int nConfiguration);
int GetStairsUpArea(int nLevel, object oDungeon);
int GetTilesetNumber(int nAreaIdentifier);

// return the area number of an area closest to the desired one at the given distance
int GetDistanceArea(int nTileset, int nNumber, int nDistance, int nIdealConfiguration, int nMandatoryConfiguration, int nLevel, object oDungeon)
{
    int nArea;

    // get the specific configuration being searched for
    int nConfiguration = GetAreaCategoryConfiguration(nIdealConfiguration, nMandatoryConfiguration, nNumber);
    DebugMessage("    Configuration desired is " + IntToString(nConfiguration));

    // get the number of tilesets at this distance
    int nTilesetListNum = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "DistanceList" + IntToString(nDistance));
    DebugMessage("There are " + IntToString(nTilesetListNum) + " tilesets in nTileset" + IntToString(nTileset) + "DistanceList" + IntToString(nDistance));

    if (nTilesetListNum > 0)
    {
        // pick a random starting point
        int nTilesetList = Random(nTilesetListNum) + 1;
        int nStartingList = -1;

        int nCurrentTileset;
        int bPresent;
        string sAreaList;
        object oArea;
        int nAreaIdentifier;
        int nAreaNum;
        int bUsed;

        // cycle through each tileset
        while ((nTilesetList != nStartingList) && (nArea == 0))
        {
            DebugMessage("  Examining tileset " + IntToString(nTilesetList) + " out of " + IntToString(nTilesetListNum));

            // get actual tileset
            nCurrentTileset = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "DistanceList" + IntToString(nDistance) + "_" + IntToString(nTilesetList));
            DebugMessage("  nTileset" + IntToString(nTileset) + "DistanceList" + IntToString(nDistance) + "_" + IntToString(nTilesetList) + " is " + IntToString(nCurrentTileset));

            // if tileset used
            bPresent = GetLocalInt(oDungeon, "bTileset" + IntToString(nCurrentTileset) + "Present");
            DebugMessage("  bTileset" + IntToString(nCurrentTileset) + "Present is " + IntToString(bPresent));

            if (bPresent == TRUE)
            {
                // get the actual area to examine
                sAreaList = GetTilesetArea(nCurrentTileset, nConfiguration);
                DebugMessage("      Returned area tag is " + sAreaList);
                oArea = GetObjectByTag(sAreaList);

                if (oArea != OBJECT_INVALID)
                {
                    // get area identifier
                    nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
                    DebugMessage("      nAreaIdentifier is " + IntToString(nAreaIdentifier));

                    // get area dungeon number
                    nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");
                    DebugMessage("      nAreaNum is " + IntToString(nAreaNum));

                    if (nAreaNum > 0)
                    {
                        // determine if used on this level already
                        bUsed = GetLocalInt(oDungeon, "bArea" + IntToString(nAreaNum) + "Level" + IntToString(nLevel) + "Used");
                        DebugMessage("      bArea" + IntToString(nAreaNum) + "Level" + IntToString(nLevel) + "Used is " + IntToString(bUsed));
                        if (bUsed == FALSE)
                        {
                            nArea = nAreaIdentifier;
                        }
                    } else
                    {
                        DebugMessage("      Not present in dungeon. Set as selected area.");

                        nArea = nAreaIdentifier;
                    }
                }
            }

            if (nStartingList == -1)
            {
                nStartingList = nTilesetList;
            }

            nTilesetList++;
            if (nTilesetList > nTilesetListNum)
            {
                nTilesetList = 1;
            }
        }
    }


/*
    // get the number of tilesets at this distance from the originating tileset
    int nTilesetListNum = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "DistanceList" + IntToString(nDistance));
    DebugMessage("There are " + IntToString(nTilesetListNum) + " tilesets in nTileset" + IntToString(nTileset) + "DistanceList" + IntToString(nDistance));
    int nTilesetList = 1;
    int nCurrentTileset;
    int nAreaListNum;
    int nAreaList;
    int nConfiguration;
    string sAreaList;
    object oArea;
    int nAreaIdentifier;
    int nAreaNum;
    int bPresent;
    int bUsed;

    // for each tileset or until area found
    while ((nTilesetList <= nTilesetListNum) && (nArea == 0))
    {
        // the actual tileset being examined
        nCurrentTileset = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "DistanceList" + IntToString(nDistance) + "_" + IntToString(nTilesetList));
        DebugMessage("  nTileset" + IntToString(nTileset) + "DistanceList" + IntToString(nDistance) + "_" + IntToString(nTilesetList) + " is " + IntToString(nCurrentTileset));

        // determine if this tileset is used in this dungeon
        bPresent = GetLocalInt(oDungeon, "bTileset" + IntToString(nCurrentTileset) + "Present");
        DebugMessage("  bTileset" + IntToString(nCurrentTileset) + "Present is " + IntToString(bPresent));
        if (bPresent == TRUE)
        {
            // determine number of areas for ideal and mandatory configuration numbers
            nAreaListNum = GetAreaCategorySize(nMandatoryConfiguration);
            DebugMessage("  There are " + IntToString(nAreaListNum) + " possible areas");
            nAreaList = 1;

            // for each area or until area found
            while ((nAreaList <= nAreaListNum) && (nArea == 0))
            {
                // get configuration
                nConfiguration = GetAreaCategoryConfiguration(nIdealConfiguration, nMandatoryConfiguration, nAreaList);
                DebugMessage("    Checking configuration " + IntToString(nConfiguration));

                // get tileset area
                sAreaList = GetTilesetArea(nTileset, nConfiguration);
                DebugMessage("      Returned area tag is " + sAreaList);
                oArea = GetObjectByTag(sAreaList);

                if (oArea != OBJECT_INVALID)
                {
                    // get area identifier
                    nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
                    DebugMessage("      nAreaIdentifier is " + IntToString(nAreaIdentifier));

                    // get area dungeon number
                    nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");
                    DebugMessage("      nAreaNum is " + IntToString(nAreaNum));

                    if (nAreaNum > 0)
                    {
                        // determine if used on this level already
                        bUsed = GetLocalInt(oDungeon, "bArea" + IntToString(nAreaNum) + "Level" + IntToString(nLevel) + "Used");
                        DebugMessage("      bArea" + IntToString(nAreaNum) + "Level" + IntToString(nLevel) + "Used is " + IntToString(bUsed));
                        if (bUsed == FALSE)
                        {
                            nArea = nAreaIdentifier;
                        }
                    } else
                    {
                        DebugMessage("      Not present in dungeon. Set as selected area.");

                        nArea = nAreaIdentifier;
                    }
                }

                nAreaList++;
            }
        }

        nTilesetList++;
    }*/

    return nArea;
}

// get the number of areas to be searched in this mandatory category
int GetAreaCategorySize(int nMandatoryConfiguration)
{
    int nNum;

    switch (nMandatoryConfiguration)
    {
        // 1 mandatory area
        case 1:
        case 2:
        case 4:
        case 8:
            nNum = 8;
            break;
        // 2 mandatory areas
        case 3:
        case 5:
        case 6:
        case 9:
        case 10:
        case 12:
            nNum = 12;
            break;
        // 3 mandatory areas
        case 7:
        case 11:
        case 13:
        case 14:
            nNum = 14;
            break;
        // 4 mandatory areas
        case 15:
            nNum = 15;
            break;
    }

    return nNum;
}

int GetAreaCategoryConfiguration(int nIdealConfiguration, int nMandatoryConfiguration, int nNumber)
{
    int nConfiguration;
    if (nIdealConfiguration == N) // 1 exit N
    {
        // padding
            if (nNumber == 1)
            {
                nConfiguration = N;
            } else if (nNumber == 2)
            {
                nConfiguration = NE;
            } else if (nNumber == 3)
            {
                nConfiguration = NS;
            } else if (nNumber == 4)
            {
                nConfiguration = NW;
            } else if (nNumber == 5)
            {
                nConfiguration = NES;
            } else if (nNumber == 6)
            {
                nConfiguration = NEW;
            } else if (nNumber == 7)
            {
                nConfiguration = NSW;
            } else if (nNumber == 8)
            {
                nConfiguration = NESW;
            }
    } else if (nIdealConfiguration == E) // 1 exit E
    {
        // padding
            if (nNumber == 1)
            {
                nConfiguration = E;
            } else if (nNumber == 2)
            {
                nConfiguration = NE;
            } else if (nNumber == 3)
            {
                nConfiguration = ES;
            } else if (nNumber == 4)
            {
                nConfiguration = EW;
            } else if (nNumber == 5)
            {
                nConfiguration = NES;
            } else if (nNumber == 6)
            {
                nConfiguration = NEW;
            } else if (nNumber == 7)
            {
                nConfiguration = ESW;
            } else if (nNumber == 8)
            {
                nConfiguration = NESW;
            }
    } else if (nIdealConfiguration == NE) // 2 exit NE
    {
        if (nMandatoryConfiguration == N) // N
        {
            if (nNumber == 1)
            {
                nConfiguration = NE;
            } else if (nNumber == 2)
            {
                nConfiguration = NES;
            } else if (nNumber == 3)
            {
                nConfiguration = NEW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NS;
            } else if (nNumber == 6)
            {
                nConfiguration = NW;
            } else if (nNumber == 7)
            {
                nConfiguration = NSW;
            } else if (nNumber == 8)
            {
                nConfiguration = N;
            }
        } else if (nMandatoryConfiguration == E) // E
        {
            if (nNumber == 1)
            {
                nConfiguration = NE;
            } else if (nNumber == 2)
            {
                nConfiguration = NES;
            } else if (nNumber == 3)
            {
                nConfiguration = NEW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = ES;
            } else if (nNumber == 6)
            {
                nConfiguration = EW;
            } else if (nNumber == 7)
            {
                nConfiguration = ESW;
            } else if (nNumber == 8)
            {
                nConfiguration = E;
            }
        } else if (nMandatoryConfiguration == NE) // NE
        {
            if (nNumber == 1)
            {
                nConfiguration = NE;
            } else if (nNumber == 2)
            {
                nConfiguration = NES;
            } else if (nNumber == 3)
            {
                nConfiguration = NEW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NS;
            } else if (nNumber == 6)
            {
                nConfiguration = ES;
            } else if (nNumber == 7)
            {
                nConfiguration = NW;
            } else if (nNumber == 8)
            {
                nConfiguration = EW;
            } else if (nNumber == 9)
            {
                nConfiguration = NSW;
            } else if (nNumber == 10)
            {
                nConfiguration = ESW;
            } else if (nNumber == 11)
            {
                nConfiguration = N;
            } else if (nNumber == 12)
            {
                nConfiguration = E;
            }
        }
    } else if (nIdealConfiguration == S) // 1 exit S
    {
        // padding
            if (nNumber == 1)
            {
                nConfiguration = S;
            } else if (nNumber == 2)
            {
                nConfiguration = NS;
            } else if (nNumber == 3)
            {
                nConfiguration = ES;
            } else if (nNumber == 4)
            {
                nConfiguration = SW;
            } else if (nNumber == 5)
            {
                nConfiguration = NES;
            } else if (nNumber == 6)
            {
                nConfiguration = ESW;
            } else if (nNumber == 7)
            {
                nConfiguration = NSW;
            } else if (nNumber == 8)
            {
                nConfiguration = NESW;
            }
    } else if (nIdealConfiguration == NS) // 2 exit NS
    {
        if (nMandatoryConfiguration == N) // N
        {
            if (nNumber == 1)
            {
                nConfiguration = NS;
            } else if (nNumber == 2)
            {
                nConfiguration = NES;
            } else if (nNumber == 3)
            {
                nConfiguration = NSW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NE;
            } else if (nNumber == 6)
            {
                nConfiguration = NW;
            } else if (nNumber == 7)
            {
                nConfiguration = NEW;
            } else if (nNumber == 8)
            {
                nConfiguration = N;
            }
        } else if (nMandatoryConfiguration == S) // S
        {
            if (nNumber == 1)
            {
                nConfiguration = NS;
            } else if (nNumber == 2)
            {
                nConfiguration = NES;
            } else if (nNumber == 3)
            {
                nConfiguration = NSW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = ES;
            } else if (nNumber == 6)
            {
                nConfiguration = SW;
            } else if (nNumber == 7)
            {
                nConfiguration = ESW;
            } else if (nNumber == 8)
            {
                nConfiguration = S;
            }
        } else if (nMandatoryConfiguration == NS) // NS
        {
            if (nNumber == 1)
            {
                nConfiguration = NS;
            } else if (nNumber == 2)
            {
                nConfiguration = NES;
            } else if (nNumber == 3)
            {
                nConfiguration = NSW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NE;
            } else if (nNumber == 6)
            {
                nConfiguration = ES;
            } else if (nNumber == 7)
            {
                nConfiguration = NW;
            } else if (nNumber == 8)
            {
                nConfiguration = SW;
            } else if (nNumber == 9)
            {
                nConfiguration = NEW;
            } else if (nNumber == 10)
            {
                nConfiguration = ESW;
            } else if (nNumber == 11)
            {
                nConfiguration = N;
            } else if (nNumber == 12)
            {
                nConfiguration = S;
            }
        }
    } else if (nIdealConfiguration == ES) // 2 exit ES
    {
        if (nMandatoryConfiguration == E) // E
        {
            if (nNumber == 1)
            {
                nConfiguration = ES;
            } else if (nNumber == 2)
            {
                nConfiguration = NES;
            } else if (nNumber == 3)
            {
                nConfiguration = ESW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NE;
            } else if (nNumber == 6)
            {
                nConfiguration = EW;
            } else if (nNumber == 7)
            {
                nConfiguration = NEW;
            } else if (nNumber == 8)
            {
                nConfiguration = E;
            }
        } else if (nMandatoryConfiguration == S) // S
        {
            if (nNumber == 1)
            {
                nConfiguration = ES;
            } else if (nNumber == 2)
            {
                nConfiguration = NES;
            } else if (nNumber == 3)
            {
                nConfiguration = ESW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NS;
            } else if (nNumber == 6)
            {
                nConfiguration = SW;
            } else if (nNumber == 7)
            {
                nConfiguration = NSW;
            } else if (nNumber == 8)
            {
                nConfiguration = S;
            }
        } else if (nMandatoryConfiguration == ES) // ES
        {
            if (nNumber == 1)
            {
                nConfiguration = ES;
            } else if (nNumber == 2)
            {
                nConfiguration = NES;
            } else if (nNumber == 3)
            {
                nConfiguration = ESW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NE;
            } else if (nNumber == 6)
            {
                nConfiguration = NS;
            } else if (nNumber == 7)
            {
                nConfiguration = EW;
            } else if (nNumber == 8)
            {
                nConfiguration = SW;
            } else if (nNumber == 9)
            {
                nConfiguration = NEW;
            } else if (nNumber == 10)
            {
                nConfiguration = NSW;
            } else if (nNumber == 11)
            {
                nConfiguration = E;
            } else if (nNumber == 12)
            {
                nConfiguration = S;
            }
        }
    } else if (nIdealConfiguration == NES) // 3 exit NES
    {
        if (nMandatoryConfiguration == N) // N
        {
            if (nNumber == 1)
            {
                nConfiguration = NES;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NEW;
            } else if (nNumber == 4)
            {
                nConfiguration = NSW;
            } else if (nNumber == 5)
            {
                nConfiguration = NE;
            } else if (nNumber == 6)
            {
                nConfiguration = NS;
            } else if (nNumber == 7)
            {
                nConfiguration = NW;
            } else if (nNumber == 8)
            {
                nConfiguration = N;
            }
        } else if (nMandatoryConfiguration == E) // E
        {
            if (nNumber == 1)
            {
                nConfiguration = NES;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NEW;
            } else if (nNumber == 4)
            {
                nConfiguration = ESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NE;
            } else if (nNumber == 6)
            {
                nConfiguration = ES;
            } else if (nNumber == 7)
            {
                nConfiguration = EW;
            } else if (nNumber == 8)
            {
                nConfiguration = E;
            }
        } else if (nMandatoryConfiguration == S) // S
        {
            if (nNumber == 1)
            {
                nConfiguration = NES;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NSW;
            } else if (nNumber == 4)
            {
                nConfiguration = ESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NS;
            } else if (nNumber == 6)
            {
                nConfiguration = ES;
            } else if (nNumber == 7)
            {
                nConfiguration = SW;
            } else if (nNumber == 8)
            {
                nConfiguration = S;
            }
        } else if (nMandatoryConfiguration == NE) // NE
        {
            if (nNumber == 1)
            {
                nConfiguration = NES;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NEW;
            } else if (nNumber == 4)
            {
                nConfiguration = NE;
            } else if (nNumber == 5)
            {
                nConfiguration = NSW;
            } else if (nNumber == 6)
            {
                nConfiguration = ESW;
            } else if (nNumber == 7)
            {
                nConfiguration = NS;
            } else if (nNumber == 8)
            {
                nConfiguration = ES;
            } else if (nNumber == 9)
            {
                nConfiguration = NW;
            } else if (nNumber == 10)
            {
                nConfiguration = EW;
            } else if (nNumber == 11)
            {
                nConfiguration = N;
            } else if (nNumber == 12)
            {
                nConfiguration = E;
            }
        } else if (nMandatoryConfiguration == NS) // NS
        {
            if (nNumber == 1)
            {
                nConfiguration = NES;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NSW;
            } else if (nNumber == 4)
            {
                nConfiguration = NS;
            } else if (nNumber == 5)
            {
                nConfiguration = NEW;
            } else if (nNumber == 6)
            {
                nConfiguration = ESW;
            } else if (nNumber == 7)
            {
                nConfiguration = NE;
            } else if (nNumber == 8)
            {
                nConfiguration = ES;
            } else if (nNumber == 9)
            {
                nConfiguration = NW;
            } else if (nNumber == 10)
            {
                nConfiguration = SW;
            } else if (nNumber == 11)
            {
                nConfiguration = N;
            } else if (nNumber == 12)
            {
                nConfiguration = S;
            }
        } else if (nMandatoryConfiguration == ES) // ES
        {
            if (nNumber == 1)
            {
                nConfiguration = NES;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = ESW;
            } else if (nNumber == 4)
            {
                nConfiguration = ES;
            } else if (nNumber == 5)
            {
                nConfiguration = NEW;
            } else if (nNumber == 6)
            {
                nConfiguration = NSW;
            } else if (nNumber == 7)
            {
                nConfiguration = NE;
            } else if (nNumber == 8)
            {
                nConfiguration = NS;
            } else if (nNumber == 9)
            {
                nConfiguration = EW;
            } else if (nNumber == 10)
            {
                nConfiguration = SW;
            } else if (nNumber == 11)
            {
                nConfiguration = E;
            } else if (nNumber == 12)
            {
                nConfiguration = S;
            }
        } else if (nMandatoryConfiguration == NES) // NES
        {
            if (nNumber == 1)
            {
                nConfiguration = NES;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NEW;
            } else if (nNumber == 4)
            {
                nConfiguration = NSW;
            } else if (nNumber == 5)
            {
                nConfiguration = ESW;
            } else if (nNumber == 6)
            {
                nConfiguration = NE;
            } else if (nNumber == 7)
            {
                nConfiguration = NS;
            } else if (nNumber == 8)
            {
                nConfiguration = ES;
            } else if (nNumber == 9)
            {
                nConfiguration = NW;
            } else if (nNumber == 10)
            {
                nConfiguration = EW;
            } else if (nNumber == 11)
            {
                nConfiguration = SW;
            } else if (nNumber == 12)
            {
                nConfiguration = N;
            } else if (nNumber == 13)
            {
                nConfiguration = E;
            } else if (nNumber == 14)
            {
                nConfiguration = S;
            }
        }
    } else if (nIdealConfiguration == W) // 1 exit W
    {
        // padding
            if (nNumber == 1)
            {
                nConfiguration = W;
            } else if (nNumber == 2)
            {
                nConfiguration = NW;
            } else if (nNumber == 3)
            {
                nConfiguration = EW;
            } else if (nNumber == 4)
            {
                nConfiguration = SW;
            } else if (nNumber == 5)
            {
                nConfiguration = NEW;
            } else if (nNumber == 6)
            {
                nConfiguration = NSW;
            } else if (nNumber == 7)
            {
                nConfiguration = ESW;
            } else if (nNumber == 8)
            {
                nConfiguration = NESW;
            }
    } else if (nIdealConfiguration == NW) // 2 exit NW
    {
        if (nMandatoryConfiguration == N) // N
        {
            if (nNumber == 1)
            {
                nConfiguration = NW;
            } else if (nNumber == 2)
            {
                nConfiguration = NEW;
            } else if (nNumber == 3)
            {
                nConfiguration = NSW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NE;
            } else if (nNumber == 6)
            {
                nConfiguration = NS;
            } else if (nNumber == 7)
            {
                nConfiguration = NES;
            } else if (nNumber == 8)
            {
                nConfiguration = N;
            }
        } else if (nMandatoryConfiguration == W) // W
        {
            if (nNumber == 1)
            {
                nConfiguration = NW;
            } else if (nNumber == 2)
            {
                nConfiguration = NEW;
            } else if (nNumber == 3)
            {
                nConfiguration = NSW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = EW;
            } else if (nNumber == 6)
            {
                nConfiguration = SW;
            } else if (nNumber == 7)
            {
                nConfiguration = ESW;
            } else if (nNumber == 8)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == NW) // NW
        {
            if (nNumber == 1)
            {
                nConfiguration = NW;
            } else if (nNumber == 2)
            {
                nConfiguration = NEW;
            } else if (nNumber == 3)
            {
                nConfiguration = NSW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NE;
            } else if (nNumber == 6)
            {
                nConfiguration = EW;
            } else if (nNumber == 7)
            {
                nConfiguration = NS;
            } else if (nNumber == 8)
            {
                nConfiguration = SW;
            } else if (nNumber == 9)
            {
                nConfiguration = NES;
            } else if (nNumber == 10)
            {
                nConfiguration = ESW;
            } else if (nNumber == 11)
            {
                nConfiguration = N;
            } else if (nNumber == 12)
            {
                nConfiguration = W;
            }
        }
    } else if (nIdealConfiguration == EW) // 2 exit EW
    {
        if (nMandatoryConfiguration == E) // E
        {
            if (nNumber == 1)
            {
                nConfiguration = EW;
            } else if (nNumber == 2)
            {
                nConfiguration = NEW;
            } else if (nNumber == 3)
            {
                nConfiguration = ESW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NE;
            } else if (nNumber == 6)
            {
                nConfiguration = ES;
            } else if (nNumber == 7)
            {
                nConfiguration = NES;
            } else if (nNumber == 8)
            {
                nConfiguration = E;
            }
        } else if (nMandatoryConfiguration == W) // W
        {
            if (nNumber == 1)
            {
                nConfiguration = EW;
            } else if (nNumber == 2)
            {
                nConfiguration = NEW;
            } else if (nNumber == 3)
            {
                nConfiguration = ESW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NW;
            } else if (nNumber == 6)
            {
                nConfiguration = SW;
            } else if (nNumber == 7)
            {
                nConfiguration = NSW;
            } else if (nNumber == 8)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == EW) // EW
        {
            if (nNumber == 1)
            {
                nConfiguration = EW;
            } else if (nNumber == 2)
            {
                nConfiguration = NEW;
            } else if (nNumber == 3)
            {
                nConfiguration = ESW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NE;
            } else if (nNumber == 6)
            {
                nConfiguration = NW;
            } else if (nNumber == 7)
            {
                nConfiguration = ES;
            } else if (nNumber == 8)
            {
                nConfiguration = SW;
            } else if (nNumber == 9)
            {
                nConfiguration = NES;
            } else if (nNumber == 10)
            {
                nConfiguration = NSW;
            } else if (nNumber == 11)
            {
                nConfiguration = E;
            } else if (nNumber == 12)
            {
                nConfiguration = W;
            }
        }
    } else if (nIdealConfiguration == NEW) // 3 exit NEW
    {
        if (nMandatoryConfiguration == N) // N
        {
            if (nNumber == 1)
            {
                nConfiguration = NEW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NES;
            } else if (nNumber == 4)
            {
                nConfiguration = NSW;
            } else if (nNumber == 5)
            {
                nConfiguration = NE;
            } else if (nNumber == 6)
            {
                nConfiguration = NS;
            } else if (nNumber == 7)
            {
                nConfiguration = NW;
            } else if (nNumber == 8)
            {
                nConfiguration = N;
            }
        } else if (nMandatoryConfiguration == E) // E
        {
            if (nNumber == 1)
            {
                nConfiguration = NEW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NES;
            } else if (nNumber == 4)
            {
                nConfiguration = ESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NE;
            } else if (nNumber == 6)
            {
                nConfiguration = ES;
            } else if (nNumber == 7)
            {
                nConfiguration = EW;
            } else if (nNumber == 8)
            {
                nConfiguration = E;
            }
        } else if (nMandatoryConfiguration == W) // W
        {
            if (nNumber == 1)
            {
                nConfiguration = NEW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = ESW;
            } else if (nNumber == 4)
            {
                nConfiguration = NSW;
            } else if (nNumber == 5)
            {
                nConfiguration = NW;
            } else if (nNumber == 6)
            {
                nConfiguration = EW;
            } else if (nNumber == 7)
            {
                nConfiguration = SW;
            } else if (nNumber == 8)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == NE) // NE
        {
            if (nNumber == 1)
            {
                nConfiguration = NEW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NES;
            } else if (nNumber == 4)
            {
                nConfiguration = NE;
            } else if (nNumber == 5)
            {
                nConfiguration = NSW;
            } else if (nNumber == 6)
            {
                nConfiguration = ESW;
            } else if (nNumber == 7)
            {
                nConfiguration = NW;
            } else if (nNumber == 8)
            {
                nConfiguration = EW;
            } else if (nNumber == 9)
            {
                nConfiguration = NS;
            } else if (nNumber == 10)
            {
                nConfiguration = ES;
            } else if (nNumber == 11)
            {
                nConfiguration = N;
            } else if (nNumber == 12)
            {
                nConfiguration = E;
            }
        } else if (nMandatoryConfiguration == NW) // NW
        {
            if (nNumber == 1)
            {
                nConfiguration = NEW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NSW;
            } else if (nNumber == 4)
            {
                nConfiguration = NW;
            } else if (nNumber == 5)
            {
                nConfiguration = NES;
            } else if (nNumber == 6)
            {
                nConfiguration = ESW;
            } else if (nNumber == 7)
            {
                nConfiguration = NE;
            } else if (nNumber == 8)
            {
                nConfiguration = EW;
            } else if (nNumber == 9)
            {
                nConfiguration = NS;
            } else if (nNumber == 10)
            {
                nConfiguration = SW;
            } else if (nNumber == 11)
            {
                nConfiguration = N;
            } else if (nNumber == 12)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == EW) // EW
        {
            if (nNumber == 1)
            {
                nConfiguration = NEW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = ESW;
            } else if (nNumber == 4)
            {
                nConfiguration = EW;
            } else if (nNumber == 5)
            {
                nConfiguration = NES;
            } else if (nNumber == 6)
            {
                nConfiguration = NSW;
            } else if (nNumber == 7)
            {
                nConfiguration = NE;
            } else if (nNumber == 8)
            {
                nConfiguration = NW;
            } else if (nNumber == 9)
            {
                nConfiguration = ES;
            } else if (nNumber == 10)
            {
                nConfiguration = SW;
            } else if (nNumber == 11)
            {
                nConfiguration = E;
            } else if (nNumber == 12)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == NEW) // NEW
        {
            if (nNumber == 1)
            {
                nConfiguration = NEW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NES;
            } else if (nNumber == 4)
            {
                nConfiguration = NSW;
            } else if (nNumber == 5)
            {
                nConfiguration = ESW;
            } else if (nNumber == 6)
            {
                nConfiguration = NE;
            } else if (nNumber == 7)
            {
                nConfiguration = NW;
            } else if (nNumber == 8)
            {
                nConfiguration = EW;
            } else if (nNumber == 9)
            {
                nConfiguration = NS;
            } else if (nNumber == 10)
            {
                nConfiguration = ES;
            } else if (nNumber == 11)
            {
                nConfiguration = SW;
            } else if (nNumber == 12)
            {
                nConfiguration = N;
            } else if (nNumber == 13)
            {
                nConfiguration = E;
            } else if (nNumber == 14)
            {
                nConfiguration = W;
            }
        }
    } else if (nIdealConfiguration == SW) // 2 exit SW
    {
        if (nMandatoryConfiguration == S) // S
        {
            if (nNumber == 1)
            {
                nConfiguration = SW;
            } else if (nNumber == 2)
            {
                nConfiguration = NSW;
            } else if (nNumber == 3)
            {
                nConfiguration = ESW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NS;
            } else if (nNumber == 6)
            {
                nConfiguration = ES;
            } else if (nNumber == 7)
            {
                nConfiguration = NES;
            } else if (nNumber == 8)
            {
                nConfiguration = S;
            }
        } else if (nMandatoryConfiguration == W) // W
        {
            if (nNumber == 1)
            {
                nConfiguration = SW;
            } else if (nNumber == 2)
            {
                nConfiguration = NSW;
            } else if (nNumber == 3)
            {
                nConfiguration = ESW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NW;
            } else if (nNumber == 6)
            {
                nConfiguration = EW;
            } else if (nNumber == 7)
            {
                nConfiguration = NEW;
            } else if (nNumber == 8)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == SW) // SW
        {
            if (nNumber == 1)
            {
                nConfiguration = SW;
            } else if (nNumber == 2)
            {
                nConfiguration = NSW;
            } else if (nNumber == 3)
            {
                nConfiguration = ESW;
            } else if (nNumber == 4)
            {
                nConfiguration = NESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NS;
            } else if (nNumber == 6)
            {
                nConfiguration = NW;
            } else if (nNumber == 7)
            {
                nConfiguration = ES;
            } else if (nNumber == 8)
            {
                nConfiguration = EW;
            } else if (nNumber == 9)
            {
                nConfiguration = NES;
            } else if (nNumber == 10)
            {
                nConfiguration = NEW;
            } else if (nNumber == 11)
            {
                nConfiguration = S;
            } else if (nNumber == 12)
            {
                nConfiguration = W;
            }
        }
    } else if (nIdealConfiguration == NSW) // 3 exit NSW
    {
        if (nMandatoryConfiguration == N) // N
        {
            if (nNumber == 1)
            {
                nConfiguration = NSW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NES;
            } else if (nNumber == 4)
            {
                nConfiguration = NEW;
            } else if (nNumber == 5)
            {
                nConfiguration = NS;
            } else if (nNumber == 6)
            {
                nConfiguration = NW;
            } else if (nNumber == 7)
            {
                nConfiguration = NE;
            } else if (nNumber == 8)
            {
                nConfiguration = N;
            }
        } else if (nMandatoryConfiguration == S) // S
        {
            if (nNumber == 1)
            {
                nConfiguration = NSW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NES;
            } else if (nNumber == 4)
            {
                nConfiguration = ESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NS;
            } else if (nNumber == 6)
            {
                nConfiguration = SW;
            } else if (nNumber == 7)
            {
                nConfiguration = ES;
            } else if (nNumber == 8)
            {
                nConfiguration = S;
            }
        } else if (nMandatoryConfiguration == W) // W
        {
            if (nNumber == 1)
            {
                nConfiguration = NSW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NEW;
            } else if (nNumber == 4)
            {
                nConfiguration = ESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NW;
            } else if (nNumber == 6)
            {
                nConfiguration = SW;
            } else if (nNumber == 7)
            {
                nConfiguration = EW;
            } else if (nNumber == 8)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == NS) // NS
        {
            if (nNumber == 1)
            {
                nConfiguration = NSW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NES;
            } else if (nNumber == 4)
            {
                nConfiguration = NS;
            } else if (nNumber == 5)
            {
                nConfiguration = NEW;
            } else if (nNumber == 6)
            {
                nConfiguration = ESW;
            } else if (nNumber == 7)
            {
                nConfiguration = NW;
            } else if (nNumber == 8)
            {
                nConfiguration = SW;
            } else if (nNumber == 9)
            {
                nConfiguration = NE;
            } else if (nNumber == 10)
            {
                nConfiguration = ES;
            } else if (nNumber == 11)
            {
                nConfiguration = N;
            } else if (nNumber == 12)
            {
                nConfiguration = S;
            }
        } else if (nMandatoryConfiguration == NW) // NW
        {
            if (nNumber == 1)
            {
                nConfiguration = NSW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NEW;
            } else if (nNumber == 4)
            {
                nConfiguration = NW;
            } else if (nNumber == 5)
            {
                nConfiguration = NES;
            } else if (nNumber == 6)
            {
                nConfiguration = ESW;
            } else if (nNumber == 7)
            {
                nConfiguration = NS;
            } else if (nNumber == 8)
            {
                nConfiguration = SW;
            } else if (nNumber == 9)
            {
                nConfiguration = NE;
            } else if (nNumber == 10)
            {
                nConfiguration = EW;
            } else if (nNumber == 11)
            {
                nConfiguration = N;
            } else if (nNumber == 12)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == SW) // SW
        {
            if (nNumber == 1)
            {
                nConfiguration = NSW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = ESW;
            } else if (nNumber == 4)
            {
                nConfiguration = SW;
            } else if (nNumber == 5)
            {
                nConfiguration = NES;
            } else if (nNumber == 6)
            {
                nConfiguration = NEW;
            } else if (nNumber == 7)
            {
                nConfiguration = NS;
            } else if (nNumber == 8)
            {
                nConfiguration = NW;
            } else if (nNumber == 9)
            {
                nConfiguration = ES;
            } else if (nNumber == 10)
            {
                nConfiguration = EW;
            } else if (nNumber == 11)
            {
                nConfiguration = S;
            } else if (nNumber == 12)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == NSW) // NSW
        {
            if (nNumber == 1)
            {
                nConfiguration = NSW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NES;
            } else if (nNumber == 4)
            {
                nConfiguration = NEW;
            } else if (nNumber == 5)
            {
                nConfiguration = ESW;
            } else if (nNumber == 6)
            {
                nConfiguration = NS;
            } else if (nNumber == 7)
            {
                nConfiguration = NW;
            } else if (nNumber == 8)
            {
                nConfiguration = SW;
            } else if (nNumber == 9)
            {
                nConfiguration = NE;
            } else if (nNumber == 10)
            {
                nConfiguration = ES;
            } else if (nNumber == 11)
            {
                nConfiguration = EW;
            } else if (nNumber == 12)
            {
                nConfiguration = N;
            } else if (nNumber == 13)
            {
                nConfiguration = S;
            } else if (nNumber == 14)
            {
                nConfiguration = W;
            }
        }
    } else if (nIdealConfiguration == ESW) // 3 exit ESW
    {
        if (nMandatoryConfiguration == E) // E
        {
            if (nNumber == 1)
            {
                nConfiguration = ESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NES;
            } else if (nNumber == 4)
            {
                nConfiguration = NEW;
            } else if (nNumber == 5)
            {
                nConfiguration = ES;
            } else if (nNumber == 6)
            {
                nConfiguration = EW;
            } else if (nNumber == 7)
            {
                nConfiguration = NE;
            } else if (nNumber == 8)
            {
                nConfiguration = E;
            }
        } else if (nMandatoryConfiguration == S) // S
        {
            if (nNumber == 1)
            {
                nConfiguration = ESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NES;
            } else if (nNumber == 4)
            {
                nConfiguration = NSW;
            } else if (nNumber == 5)
            {
                nConfiguration = ES;
            } else if (nNumber == 6)
            {
                nConfiguration = SW;
            } else if (nNumber == 7)
            {
                nConfiguration = NS;
            } else if (nNumber == 8)
            {
                nConfiguration = S;
            }
        } else if (nMandatoryConfiguration == W) // W
        {
            if (nNumber == 1)
            {
                nConfiguration = ESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NEW;
            } else if (nNumber == 4)
            {
                nConfiguration = NSW;
            } else if (nNumber == 5)
            {
                nConfiguration = EW;
            } else if (nNumber == 6)
            {
                nConfiguration = SW;
            } else if (nNumber == 7)
            {
                nConfiguration = NW;
            } else if (nNumber == 8)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == ES) // ES
        {
            if (nNumber == 1)
            {
                nConfiguration = ESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NES;
            } else if (nNumber == 4)
            {
                nConfiguration = ES;
            } else if (nNumber == 5)
            {
                nConfiguration = NEW;
            } else if (nNumber == 6)
            {
                nConfiguration = NSW;
            } else if (nNumber == 7)
            {
                nConfiguration = EW;
            } else if (nNumber == 8)
            {
                nConfiguration = SW;
            } else if (nNumber == 9)
            {
                nConfiguration = NE;
            } else if (nNumber == 10)
            {
                nConfiguration = NS;
            } else if (nNumber == 11)
            {
                nConfiguration = E;
            } else if (nNumber == 12)
            {
                nConfiguration = S;
            }
        } else if (nMandatoryConfiguration == EW) // EW
        {
            if (nNumber == 1)
            {
                nConfiguration = ESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NEW;
            } else if (nNumber == 4)
            {
                nConfiguration = EW;
            } else if (nNumber == 5)
            {
                nConfiguration = NES;
            } else if (nNumber == 6)
            {
                nConfiguration = NSW;
            } else if (nNumber == 7)
            {
                nConfiguration = ES;
            } else if (nNumber == 8)
            {
                nConfiguration = SW;
            } else if (nNumber == 9)
            {
                nConfiguration = NE;
            } else if (nNumber == 10)
            {
                nConfiguration = NW;
            } else if (nNumber == 11)
            {
                nConfiguration = E;
            } else if (nNumber == 12)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == SW) // SW
        {
            if (nNumber == 1)
            {
                nConfiguration = ESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NSW;
            } else if (nNumber == 4)
            {
                nConfiguration = SW;
            } else if (nNumber == 5)
            {
                nConfiguration = NES;
            } else if (nNumber == 6)
            {
                nConfiguration = NEW;
            } else if (nNumber == 7)
            {
                nConfiguration = ES;
            } else if (nNumber == 8)
            {
                nConfiguration = EW;
            } else if (nNumber == 9)
            {
                nConfiguration = NS;
            } else if (nNumber == 10)
            {
                nConfiguration = NW;
            } else if (nNumber == 11)
            {
                nConfiguration = S;
            } else if (nNumber == 12)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == ESW) // ESW
        {
            if (nNumber == 1)
            {
                nConfiguration = ESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NES;
            } else if (nNumber == 4)
            {
                nConfiguration = NEW;
            } else if (nNumber == 5)
            {
                nConfiguration = NSW;
            } else if (nNumber == 6)
            {
                nConfiguration = ES;
            } else if (nNumber == 7)
            {
                nConfiguration = EW;
            } else if (nNumber == 8)
            {
                nConfiguration = SW;
            } else if (nNumber == 9)
            {
                nConfiguration = NE;
            } else if (nNumber == 10)
            {
                nConfiguration = NS;
            } else if (nNumber == 11)
            {
                nConfiguration = NW;
            } else if (nNumber == 12)
            {
                nConfiguration = E;
            } else if (nNumber == 13)
            {
                nConfiguration = S;
            } else if (nNumber == 14)
            {
                nConfiguration = W;
            }
        }
    } else if (nIdealConfiguration == NESW) // 4 exit NESW
    {
        if (nMandatoryConfiguration == N) // N
        {
            if (nNumber == 1)
            {
                nConfiguration = NESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NES;
            } else if (nNumber == 3)
            {
                nConfiguration = NEW;
            } else if (nNumber == 4)
            {
                nConfiguration = NSW;
            } else if (nNumber == 5)
            {
                nConfiguration = NE;
            } else if (nNumber == 6)
            {
                nConfiguration = NS;
            } else if (nNumber == 7)
            {
                nConfiguration = NW;
            } else if (nNumber == 8)
            {
                nConfiguration = N;
            }
        } else if (nMandatoryConfiguration == E) // E
        {
            if (nNumber == 1)
            {
                nConfiguration = NESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NES;
            } else if (nNumber == 3)
            {
                nConfiguration = NEW;
            } else if (nNumber == 4)
            {
                nConfiguration = ESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NE;
            } else if (nNumber == 6)
            {
                nConfiguration = ES;
            } else if (nNumber == 7)
            {
                nConfiguration = EW;
            } else if (nNumber == 8)
            {
                nConfiguration = E;
            }
        } else if (nMandatoryConfiguration == S) // S
        {
            if (nNumber == 1)
            {
                nConfiguration = NESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NES;
            } else if (nNumber == 3)
            {
                nConfiguration = NSW;
            } else if (nNumber == 4)
            {
                nConfiguration = ESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NS;
            } else if (nNumber == 6)
            {
                nConfiguration = ES;
            } else if (nNumber == 7)
            {
                nConfiguration = SW;
            } else if (nNumber == 8)
            {
                nConfiguration = S;
            }
        } else if (nMandatoryConfiguration == W) // W
        {
            if (nNumber == 1)
            {
                nConfiguration = NESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NEW;
            } else if (nNumber == 3)
            {
                nConfiguration = NSW;
            } else if (nNumber == 4)
            {
                nConfiguration = ESW;
            } else if (nNumber == 5)
            {
                nConfiguration = NW;
            } else if (nNumber == 6)
            {
                nConfiguration = EW;
            } else if (nNumber == 7)
            {
                nConfiguration = SW;
            } else if (nNumber == 8)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == NE) // NE
        {
            if (nNumber == 1)
            {
                nConfiguration = NESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NES;
            } else if (nNumber == 3)
            {
                nConfiguration = NEW;
            } else if (nNumber == 4)
            {
                nConfiguration = NE;
            } else if (nNumber == 5)
            {
                nConfiguration = NSW;
            } else if (nNumber == 6)
            {
                nConfiguration = ESW;
            } else if (nNumber == 7)
            {
                nConfiguration = NS;
            } else if (nNumber == 8)
            {
                nConfiguration = ES;
            } else if (nNumber == 9)
            {
                nConfiguration = NW;
            } else if (nNumber == 10)
            {
                nConfiguration = EW;
            } else if (nNumber == 11)
            {
                nConfiguration = N;
            } else if (nNumber == 12)
            {
                nConfiguration = E;
            }
        } else if (nMandatoryConfiguration == NS) // NS
        {
            if (nNumber == 1)
            {
                nConfiguration = NESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NES;
            } else if (nNumber == 3)
            {
                nConfiguration = NSW;
            } else if (nNumber == 4)
            {
                nConfiguration = NS;
            } else if (nNumber == 5)
            {
                nConfiguration = NEW;
            } else if (nNumber == 6)
            {
                nConfiguration = ESW;
            } else if (nNumber == 7)
            {
                nConfiguration = NE;
            } else if (nNumber == 8)
            {
                nConfiguration = ES;
            } else if (nNumber == 9)
            {
                nConfiguration = NW;
            } else if (nNumber == 10)
            {
                nConfiguration = SW;
            } else if (nNumber == 11)
            {
                nConfiguration = N;
            } else if (nNumber == 12)
            {
                nConfiguration = S;
            }
        } else if (nMandatoryConfiguration == NW) // NW
        {
            if (nNumber == 1)
            {
                nConfiguration = NESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NEW;
            } else if (nNumber == 3)
            {
                nConfiguration = NSW;
            } else if (nNumber == 4)
            {
                nConfiguration = NW;
            } else if (nNumber == 5)
            {
                nConfiguration = NES;
            } else if (nNumber == 6)
            {
                nConfiguration = ESW;
            } else if (nNumber == 7)
            {
                nConfiguration = NE;
            } else if (nNumber == 8)
            {
                nConfiguration = EW;
            } else if (nNumber == 9)
            {
                nConfiguration = NS;
            } else if (nNumber == 10)
            {
                nConfiguration = SW;
            } else if (nNumber == 11)
            {
                nConfiguration = N;
            } else if (nNumber == 12)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == ES) // ES
        {
            if (nNumber == 1)
            {
                nConfiguration = NESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NES;
            } else if (nNumber == 3)
            {
                nConfiguration = ESW;
            } else if (nNumber == 4)
            {
                nConfiguration = ES;
            } else if (nNumber == 5)
            {
                nConfiguration = NEW;
            } else if (nNumber == 6)
            {
                nConfiguration = NSW;
            } else if (nNumber == 7)
            {
                nConfiguration = NE;
            } else if (nNumber == 8)
            {
                nConfiguration = NS;
            } else if (nNumber == 9)
            {
                nConfiguration = EW;
            } else if (nNumber == 10)
            {
                nConfiguration = SW;
            } else if (nNumber == 11)
            {
                nConfiguration = E;
            } else if (nNumber == 12)
            {
                nConfiguration = S;
            }
        } else if (nMandatoryConfiguration == EW) // EW
        {
            if (nNumber == 1)
            {
                nConfiguration = NESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NEW;
            } else if (nNumber == 3)
            {
                nConfiguration = ESW;
            } else if (nNumber == 4)
            {
                nConfiguration = EW;
            } else if (nNumber == 5)
            {
                nConfiguration = NES;
            } else if (nNumber == 6)
            {
                nConfiguration = NSW;
            } else if (nNumber == 7)
            {
                nConfiguration = NE;
            } else if (nNumber == 8)
            {
                nConfiguration = NW;
            } else if (nNumber == 9)
            {
                nConfiguration = ES;
            } else if (nNumber == 10)
            {
                nConfiguration = SW;
            } else if (nNumber == 11)
            {
                nConfiguration = E;
            } else if (nNumber == 12)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == SW) // SW
        {
            if (nNumber == 1)
            {
                nConfiguration = NESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NSW;
            } else if (nNumber == 3)
            {
                nConfiguration = ESW;
            } else if (nNumber == 4)
            {
                nConfiguration = SW;
            } else if (nNumber == 5)
            {
                nConfiguration = NES;
            } else if (nNumber == 6)
            {
                nConfiguration = NEW;
            } else if (nNumber == 7)
            {
                nConfiguration = NS;
            } else if (nNumber == 8)
            {
                nConfiguration = NW;
            } else if (nNumber == 9)
            {
                nConfiguration = ES;
            } else if (nNumber == 10)
            {
                nConfiguration = EW;
            } else if (nNumber == 11)
            {
                nConfiguration = S;
            } else if (nNumber == 12)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == NES) // NES
        {
            if (nNumber == 1)
            {
                nConfiguration = NESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NES;
            } else if (nNumber == 3)
            {
                nConfiguration = NEW;
            } else if (nNumber == 4)
            {
                nConfiguration = NSW;
            } else if (nNumber == 5)
            {
                nConfiguration = ESW;
            } else if (nNumber == 6)
            {
                nConfiguration = NE;
            } else if (nNumber == 7)
            {
                nConfiguration = NS;
            } else if (nNumber == 8)
            {
                nConfiguration = ES;
            } else if (nNumber == 9)
            {
                nConfiguration = NW;
            } else if (nNumber == 10)
            {
                nConfiguration = EW;
            } else if (nNumber == 11)
            {
                nConfiguration = SW;
            } else if (nNumber == 12)
            {
                nConfiguration = N;
            } else if (nNumber == 13)
            {
                nConfiguration = E;
            } else if (nNumber == 14)
            {
                nConfiguration = S;
            }
        } else if (nMandatoryConfiguration == NEW) // NEW
        {
            if (nNumber == 1)
            {
                nConfiguration = NESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NEW;
            } else if (nNumber == 3)
            {
                nConfiguration = NES;
            } else if (nNumber == 4)
            {
                nConfiguration = NSW;
            } else if (nNumber == 5)
            {
                nConfiguration = ESW;
            } else if (nNumber == 6)
            {
                nConfiguration = NE;
            } else if (nNumber == 7)
            {
                nConfiguration = NW;
            } else if (nNumber == 8)
            {
                nConfiguration = EW;
            } else if (nNumber == 9)
            {
                nConfiguration = NS;
            } else if (nNumber == 10)
            {
                nConfiguration = ES;
            } else if (nNumber == 11)
            {
                nConfiguration = SW;
            } else if (nNumber == 12)
            {
                nConfiguration = N;
            } else if (nNumber == 13)
            {
                nConfiguration = E;
            } else if (nNumber == 14)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == NSW) // NSW
        {
            if (nNumber == 1)
            {
                nConfiguration = NESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NSW;
            } else if (nNumber == 3)
            {
                nConfiguration = NES;
            } else if (nNumber == 4)
            {
                nConfiguration = NEW;
            } else if (nNumber == 5)
            {
                nConfiguration = ESW;
            } else if (nNumber == 6)
            {
                nConfiguration = NS;
            } else if (nNumber == 7)
            {
                nConfiguration = NW;
            } else if (nNumber == 8)
            {
                nConfiguration = SW;
            } else if (nNumber == 9)
            {
                nConfiguration = NE;
            } else if (nNumber == 10)
            {
                nConfiguration = ES;
            } else if (nNumber == 11)
            {
                nConfiguration = EW;
            } else if (nNumber == 12)
            {
                nConfiguration = N;
            } else if (nNumber == 13)
            {
                nConfiguration = S;
            } else if (nNumber == 14)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == ESW) // ESW
        {
            if (nNumber == 1)
            {
                nConfiguration = NESW;
            } else if (nNumber == 2)
            {
                nConfiguration = ESW;
            } else if (nNumber == 3)
            {
                nConfiguration = NES;
            } else if (nNumber == 4)
            {
                nConfiguration = NEW;
            } else if (nNumber == 5)
            {
                nConfiguration = NSW;
            } else if (nNumber == 6)
            {
                nConfiguration = ES;
            } else if (nNumber == 7)
            {
                nConfiguration = EW;
            } else if (nNumber == 8)
            {
                nConfiguration = SW;
            } else if (nNumber == 9)
            {
                nConfiguration = NE;
            } else if (nNumber == 10)
            {
                nConfiguration = NS;
            } else if (nNumber == 11)
            {
                nConfiguration = NW;
            } else if (nNumber == 12)
            {
                nConfiguration = E;
            } else if (nNumber == 13)
            {
                nConfiguration = S;
            } else if (nNumber == 14)
            {
                nConfiguration = W;
            }
        } else if (nMandatoryConfiguration == NESW) // NESW
        {
            if (nNumber == 1)
            {
                nConfiguration = NESW;
            } else if (nNumber == 2)
            {
                nConfiguration = NES;
            } else if (nNumber == 3)
            {
                nConfiguration = NEW;
            } else if (nNumber == 4)
            {
                nConfiguration = NSW;
            } else if (nNumber == 5)
            {
                nConfiguration = ESW;
            } else if (nNumber == 6)
            {
                nConfiguration = NE;
            } else if (nNumber == 7)
            {
                nConfiguration = NS;
            } else if (nNumber == 8)
            {
                nConfiguration = NW;
            } else if (nNumber == 9)
            {
                nConfiguration = ES;
            } else if (nNumber == 10)
            {
                nConfiguration = EW;
            } else if (nNumber == 11)
            {
                nConfiguration = SW;
            } else if (nNumber == 12)
            {
                nConfiguration = N;
            } else if (nNumber == 13)
            {
                nConfiguration = E;
            } else if (nNumber == 14)
            {
                nConfiguration = S;
            } else if (nNumber == 15)
            {
                nConfiguration = W;
            }
        }
    }

    DebugMessage("nIdealConfiguration is " + IntToString(nIdealConfiguration));
    DebugMessage("nMandatoryConfiguration is " + IntToString(nMandatoryConfiguration));
    DebugMessage("nNumber is " + IntToString(nNumber));
    DebugMessage("nConfiguration is " + IntToString(nConfiguration));

    return nConfiguration;
}

string GetTilesetArea(int nTileset, int nConfiguration)
{
    string sArea;

    // get tileset area name
    if (nTileset == BEHOLDER_CAVES)
    {
        if (nConfiguration == N)
        {
            sArea = "Area041";
        } else if (nConfiguration == E)
        {
            sArea = "Area118";
        } else if (nConfiguration == S)
        {
            sArea = "Area082";
        } else if (nConfiguration == W)
        {
            sArea = "Area040";
        } else if (nConfiguration == NE)
        {
            sArea = "Area091";
        } else if (nConfiguration == NS)
        {
            sArea = "Area150";
        } else if (nConfiguration == NW)
        {
            sArea = "Area128";
        } else if (nConfiguration == ES)
        {
            sArea = "Area116";
        } else if (nConfiguration == EW)
        {
            sArea = "Area148";
        } else if (nConfiguration == SW)
        {
            sArea = "Area015";
        } else if (nConfiguration == NES)
        {
            sArea = "";
        } else if (nConfiguration == NEW)
        {
            sArea = "";
        } else if (nConfiguration == NSW)
        {
            sArea = "";
        } else if (nConfiguration == ESW)
        {
            sArea = "";
        } else if (nConfiguration == NESW)
        {
            sArea = "";
        }
    } else if (nTileset == CASTLE_INTERIOR)
    {
        if (nConfiguration == N)
        {
            sArea = "Area148";
        } else if (nConfiguration == E)
        {
            sArea = "Area084";
        } else if (nConfiguration == S)
        {
            sArea = "Area042";
        } else if (nConfiguration == W)
        {
            sArea = "Area121";
        } else if (nConfiguration == NE)
        {
            sArea = "Area232";
        } else if (nConfiguration == NS)
        {
            sArea = "Area111";
        } else if (nConfiguration == NW)
        {
            sArea = "Area189";
        } else if (nConfiguration == ES)
        {
            sArea = "Area271";
        } else if (nConfiguration == EW)
        {
            sArea = "Area269";
        } else if (nConfiguration == SW)
        {
            sArea = "Area163";
        } else if (nConfiguration == NES)
        {
            sArea = "Area016";
        } else if (nConfiguration == NEW)
        {
            sArea = "Area074";
        } else if (nConfiguration == NSW)
        {
            sArea = "Area211";
        } else if (nConfiguration == ESW)
        {
            sArea = "Area227";
        } else if (nConfiguration == NESW)
        {
            sArea = "Area134";
        }
    } else if (nTileset == CRYPT)
    {
        if (nConfiguration == N)
        {
            sArea = "Area114";
        } else if (nConfiguration == E)
        {
            sArea = "Area244";
        } else if (nConfiguration == S)
        {
            sArea = "Area222";
        } else if (nConfiguration == W)
        {
            sArea = "Area161";
        } else if (nConfiguration == NE)
        {
            sArea = "Area073";
        } else if (nConfiguration == NS)
        {
            sArea = "Area090";
        } else if (nConfiguration == NW)
        {
            sArea = "Area149";
        } else if (nConfiguration == ES)
        {
            sArea = "Area125";
        } else if (nConfiguration == EW)
        {
            sArea = "Area245";
        } else if (nConfiguration == SW)
        {
            sArea = "Area043";
        } else if (nConfiguration == NES)
        {
            sArea = "Area174";
        } else if (nConfiguration == NEW)
        {
            sArea = "Area193";
        } else if (nConfiguration == NSW)
        {
            sArea = "Area018";
        } else if (nConfiguration == ESW)
        {
            sArea = "Area273";
        } else if (nConfiguration == NESW)
        {
            sArea = "Area215";
        }
    } else if (nTileset == DESERT)
    {
        if (nConfiguration == N)
        {
            sArea = "Area188";
        } else if (nConfiguration == E)
        {
            sArea = "Area044";
        } else if (nConfiguration == S)
        {
            sArea = "Area122";
        } else if (nConfiguration == W)
        {
            sArea = "Area181";
        } else if (nConfiguration == NE)
        {
            sArea = "Area152";
        } else if (nConfiguration == NS)
        {
            sArea = "Area230";
        } else if (nConfiguration == NW)
        {
            sArea = "Area209";
        } else if (nConfiguration == ES)
        {
            sArea = "Area272";
        } else if (nConfiguration == EW)
        {
            sArea = "Area165";
        } else if (nConfiguration == SW)
        {
            sArea = "Area119";
        } else if (nConfiguration == NES)
        {
            sArea = "Area254";
        } else if (nConfiguration == NEW)
        {
            sArea = "Area233";
        } else if (nConfiguration == NSW)
        {
            sArea = "Area072";
        } else if (nConfiguration == ESW)
        {
            sArea = "Area019";
        } else if (nConfiguration == NESW)
        {
            sArea = "Area285";
        }
    } else if (nTileset == DROW_INTERIOR)
    {
        if (nConfiguration == N)
        {
            sArea = "Area006";
        } else if (nConfiguration == E)
        {
            sArea = "Area123";
        } else if (nConfiguration == S)
        {
            sArea = "Area263";
        } else if (nConfiguration == W)
        {
            sArea = "Area241";
        } else if (nConfiguration == NE)
        {
            sArea = "Area109";
        } else if (nConfiguration == NS)
        {
            sArea = "Area071";
        } else if (nConfiguration == NW)
        {
            sArea = "Area276";
        } else if (nConfiguration == ES)
        {
            sArea = "Area166";
        } else if (nConfiguration == EW)
        {
            sArea = "Area045";
        } else if (nConfiguration == SW)
        {
            sArea = "Area243";
        } else if (nConfiguration == NES)
        {
            sArea = "Area194";
        } else if (nConfiguration == NEW)
        {
            sArea = "Area283";
        } else if (nConfiguration == NSW)
        {
            sArea = "Area151";
        } else if (nConfiguration == ESW)
        {
            sArea = "Area207";
        } else if (nConfiguration == NESW)
        {
            sArea = "Area020";
        }
    } else if (nTileset == DUNGEON)
    {
        if (nConfiguration == N)
        {
            sArea = "Area208";
        } else if (nConfiguration == E)
        {
            sArea = "Area007";
        } else if (nConfiguration == S)
        {
            sArea = "Area182";
        } else if (nConfiguration == W)
        {
            sArea = "Area261";
        } else if (nConfiguration == NE)
        {
            sArea = "Area281";
        } else if (nConfiguration == NS)
        {
            sArea = "Area190";
        } else if (nConfiguration == NW)
        {
            sArea = "Area070";
        } else if (nConfiguration == ES)
        {
            sArea = "Area046";
        } else if (nConfiguration == EW)
        {
            sArea = "Area124";
        } else if (nConfiguration == SW)
        {
            sArea = "Area223";
        } else if (nConfiguration == NES)
        {
            sArea = "Area107";
        } else if (nConfiguration == NEW)
        {
            sArea = "Area153";
        } else if (nConfiguration == NSW)
        {
            sArea = "Area231";
        } else if (nConfiguration == ESW)
        {
            sArea = "Area167";
        } else if (nConfiguration == NESW)
        {
            sArea = "Area255";
        }
    } else if (nTileset == FOREST)
    {
        if (nConfiguration == N)
        {
            sArea = "Area069";
        } else if (nConfiguration == E)
        {
            sArea = "Area164";
        } else if (nConfiguration == S)
        {
            sArea = "Area008";
        } else if (nConfiguration == W)
        {
            sArea = "Area081";
        } else if (nConfiguration == NE)
        {
            sArea = "Area192";
        } else if (nConfiguration == NS)
        {
            sArea = "Area129";
        } else if (nConfiguration == NW)
        {
            sArea = "Area089";
        } else if (nConfiguration == ES)
        {
            sArea = "Area226";
        } else if (nConfiguration == EW)
        {
            sArea = "Area185";
        } else if (nConfiguration == SW)
        {
            sArea = "Area140";
        } else if (nConfiguration == NES)
        {
            sArea = "Area214";
        } else if (nConfiguration == NEW)
        {
            sArea = "Area108";
        } else if (nConfiguration == NSW)
        {
            sArea = "Area092";
        } else if (nConfiguration == ESW)
        {
            sArea = "Area047";
        } else if (nConfiguration == NESW)
        {
            sArea = "Area155";
        }
    } else if (nTileset == FROZEN_WASTES)
    {
        if (nConfiguration == N)
        {
            sArea = "Area127";
        } else if (nConfiguration == E)
        {
            sArea = "Area224";
        } else if (nConfiguration == S)
        {
            sArea = "Area264";
        } else if (nConfiguration == W)
        {
            sArea = "Area009";
        } else if (nConfiguration == NE)
        {
            sArea = "Area252";
        } else if (nConfiguration == NS)
        {
            sArea = "Area170";
        } else if (nConfiguration == NW)
        {
            sArea = "Area048";
        } else if (nConfiguration == ES)
        {
            sArea = "Area206";
        } else if (nConfiguration == EW)
        {
            sArea = "Area117";
        } else if (nConfiguration == SW)
        {
            sArea = "Area265";
        } else if (nConfiguration == NES)
        {
            sArea = "Area075";
        } else if (nConfiguration == NEW)
        {
            sArea = "Area213";
        } else if (nConfiguration == NSW)
        {
            sArea = "Area191";
        } else if (nConfiguration == ESW)
        {
            sArea = "Area068";
        } else if (nConfiguration == NESW)
        {
            sArea = "Area095";
        }
    } else if (nTileset == ILLITHID_INTERIOR)
    {
        if (nConfiguration == N)
        {
            sArea = "Area228";
        } else if (nConfiguration == E)
        {
            sArea = "Area267";
        } else if (nConfiguration == S)
        {
            sArea = "Area202";
        } else if (nConfiguration == W)
        {
            sArea = "Area141";
        } else if (nConfiguration == NE)
        {
            sArea = "Area010";
        } else if (nConfiguration == NS)
        {
            sArea = "Area049";
        } else if (nConfiguration == NW)
        {
            sArea = "Area169";
        } else if (nConfiguration == ES)
        {
            sArea = "Area067";
        } else if (nConfiguration == EW)
        {
            sArea = "Area270";
        } else if (nConfiguration == SW)
        {
            sArea = "Area266";
        } else if (nConfiguration == NES)
        {
            sArea = "Area154";
        } else if (nConfiguration == NEW)
        {
            sArea = "Area093";
        } else if (nConfiguration == NSW)
        {
            sArea = "Area110";
        } else if (nConfiguration == ESW)
        {
            sArea = "Area087";
        } else if (nConfiguration == NESW)
        {
            sArea = "Area059";
        }
    } else if (nTileset == MINES_AND_CAVERNS)
    {
        if (nConfiguration == N)
        {
            sArea = "Area168";
        } else if (nConfiguration == E)
        {
            sArea = "Area268";
        } else if (nConfiguration == S)
        {
            sArea = "Area142";
        } else if (nConfiguration == W)
        {
            sArea = "Area262";
        } else if (nConfiguration == NE)
        {
            sArea = "Area212";
        } else if (nConfiguration == NS)
        {
            sArea = "Area011";
        } else if (nConfiguration == NW)
        {
            sArea = "Area113";
        } else if (nConfiguration == ES)
        {
            sArea = "Area086";
        } else if (nConfiguration == EW)
        {
            sArea = "Area066";
        } else if (nConfiguration == SW)
        {
            sArea = "Area183";
        } else if (nConfiguration == NES)
        {
            sArea = "Area234";
        } else if (nConfiguration == NEW)
        {
            sArea = "Area253";
        } else if (nConfiguration == NSW)
        {
            sArea = "Area050";
        } else if (nConfiguration == ESW)
        {
            sArea = "Area126";
        } else if (nConfiguration == NESW)
        {
            sArea = "Area195";
        }
    } else if (nTileset == RUINS)
    {
        if (nConfiguration == N)
        {
            sArea = "Area248";
        } else if (nConfiguration == E)
        {
            sArea = "Area065";
        } else if (nConfiguration == S)
        {
            sArea = "Area120";
        } else if (nConfiguration == W)
        {
            sArea = "Area221";
        } else if (nConfiguration == NE)
        {
            sArea = "Area051";
        } else if (nConfiguration == NS)
        {
            sArea = "Area250";
        } else if (nConfiguration == NW)
        {
            sArea = "Area012";
        } else if (nConfiguration == ES)
        {
            sArea = "Area186";
        } else if (nConfiguration == EW)
        {
            sArea = "Area205";
        } else if (nConfiguration == SW)
        {
            sArea = "Area083";
        } else if (nConfiguration == NES)
        {
            sArea = "Area284";
        } else if (nConfiguration == NEW)
        {
            sArea = "Area173";
        } else if (nConfiguration == NSW)
        {
            sArea = "Area130";
        } else if (nConfiguration == ESW)
        {
            sArea = "Area147";
        } else if (nConfiguration == NESW)
        {
            sArea = "Area235";
        }
    } else if (nTileset == SEWERS)
    {
        if (nConfiguration == N)
        {
            sArea = "Area274";
        } else if (nConfiguration == E)
        {
            sArea = "Area144";
        } else if (nConfiguration == S)
        {
            sArea = "Area242";
        } else if (nConfiguration == W)
        {
            sArea = "Area201";
        } else if (nConfiguration == NE)
        {
            sArea = "Area282";
        } else if (nConfiguration == NS)
        {
            sArea = "Area278";
        } else if (nConfiguration == NW)
        {
            sArea = "Area229";
        } else if (nConfiguration == ES)
        {
            sArea = "Area013";
        } else if (nConfiguration == EW)
        {
            sArea = "Area085";
        } else if (nConfiguration == SW)
        {
            sArea = "Area064";
        } else if (nConfiguration == NES)
        {
            sArea = "Area133";
        } else if (nConfiguration == NEW)
        {
            sArea = "Area052";
        } else if (nConfiguration == NSW)
        {
            sArea = "Area171";
        } else if (nConfiguration == ESW)
        {
            sArea = "Area187";
        } else if (nConfiguration == NESW)
        {
            sArea = "Area106";
        }
    } else if (nTileset == UNDERDARK)
    {
        if (nConfiguration == N)
        {
            sArea = "Area275";
        } else if (nConfiguration == E)
        {
            sArea = "Area184";
        } else if (nConfiguration == S)
        {
            sArea = "Area162";
        } else if (nConfiguration == W)
        {
            sArea = "Area062";
        } else if (nConfiguration == NE)
        {
            sArea = "Area172";
        } else if (nConfiguration == NS)
        {
            sArea = "Area210";
        } else if (nConfiguration == NW)
        {
            sArea = "Area249";
        } else if (nConfiguration == ES)
        {
            sArea = "Area146";
        } else if (nConfiguration == EW)
        {
            sArea = "Area014";
        } else if (nConfiguration == SW)
        {
            sArea = "Area203";
        } else if (nConfiguration == NES)
        {
            sArea = "Area094";
        } else if (nConfiguration == NEW)
        {
            sArea = "Area132";
        } else if (nConfiguration == NSW)
        {
            sArea = "Area280";
        } else if (nConfiguration == ESW)
        {
            sArea = "Area115";
        } else if (nConfiguration == NESW)
        {
            sArea = "Area054";
        }
    } else if (nTileset == STEAMWORKS)
    {
        if (nConfiguration == N)
        {
            sArea = "Area088";
        } else if (nConfiguration == E)
        {
            sArea = "Area204";
        } else if (nConfiguration == S)
        {
            sArea = "Area063";
        } else if (nConfiguration == W)
        {
            sArea = "Area112";
        } else if (nConfiguration == NE)
        {
            sArea = "Area131";
        } else if (nConfiguration == NS)
        {
            sArea = "Area279";
        } else if (nConfiguration == NW)
        {
            sArea = "Area277";
        } else if (nConfiguration == ES)
        {
            sArea = "Area246";
        } else if (nConfiguration == EW)
        {
            sArea = "Area225";
        } else if (nConfiguration == SW)
        {
            sArea = "Area143";
        } else if (nConfiguration == NES)
        {
            sArea = "Area053";
        } else if (nConfiguration == NEW)
        {
            sArea = "Area017";
        } else if (nConfiguration == NSW)
        {
            sArea = "Area251";
        } else if (nConfiguration == ESW)
        {
            sArea = "Area247";
        } else if (nConfiguration == NESW)
        {
            sArea = "Area175";
        }
    } else if (nTileset == KEEP_INTERIOR_STONE)
    {
        if (nConfiguration == N)
        {
            sArea = "Area025";
        } else if (nConfiguration == E)
        {
            sArea = "Area026";
        } else if (nConfiguration == S)
        {
            sArea = "Area027";
        } else if (nConfiguration == W)
        {
            sArea = "Area028";
        } else if (nConfiguration == NE)
        {
            sArea = "Area029";
        } else if (nConfiguration == NS)
        {
            sArea = "Area030";
        } else if (nConfiguration == NW)
        {
            sArea = "Area031";
        } else if (nConfiguration == ES)
        {
            sArea = "Area032";
        } else if (nConfiguration == EW)
        {
            sArea = "Area033";
        } else if (nConfiguration == SW)
        {
            sArea = "Area034";
        } else if (nConfiguration == NES)
        {
            sArea = "Area035";
        } else if (nConfiguration == NEW)
        {
            sArea = "Area036";
        } else if (nConfiguration == NSW)
        {
            sArea = "Area037";
        } else if (nConfiguration == ESW)
        {
            sArea = "Area038";
        } else if (nConfiguration == NESW)
        {
            sArea = "Area039";
        }
    }

    return sArea;
}

int GetStairsUpArea(int nLevel, object oDungeon)
{
    object oTempHolder = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "StairsUpHolder");
    int nTilesetNum = GetLocalInt(GetModule(), "nTileset");
    int nTileset = 1;
    int nAreaListNum;
    int bPresent;
    while (nTileset <= nTilesetNum)
    {
        bPresent = GetLocalInt(oDungeon, "bTileset" + IntToString(nTileset) + "Present");
        DebugMessage("  bTileset" + IntToString(nTileset) + "Present is " + IntToString(bPresent));
        if (bPresent == TRUE)
        {
            // if a valid tileset
            if ((nTileset == CASTLE_INTERIOR) ||
                (nTileset == CRYPT) ||
                (nTileset == DESERT) ||
                (nTileset == DROW_INTERIOR) ||
                (nTileset == DUNGEON) ||
                (nTileset == FROZEN_WASTES) ||
                (nTileset == ILLITHID_INTERIOR) ||
                (nTileset == MINES_AND_CAVERNS) ||
                (nTileset == RUINS) ||
                (nTileset == SEWERS) ||
                (nTileset == UNDERDARK) ||
                (nTileset == STEAMWORKS) ||
                (nTileset == KEEP_INTERIOR_STONE))
            {
                // add to queue on temporary object
                nAreaListNum = GetLocalInt(oTempHolder, "nAreaListNum");
                nAreaListNum++;
                SetLocalInt(oTempHolder, "nAreaListNum", nAreaListNum);
                SetLocalInt(oTempHolder, "nAreaList" + IntToString(nAreaListNum), nTileset);
                DebugMessage("  Added tileset " + IntToString(nTileset) + " to nAreaList" + IntToString(nAreaListNum));
            }
        }

        nTileset++;
    }

    int nArea = -1;
    nAreaListNum = GetLocalInt(oTempHolder, "nAreaListNum");
    if (nAreaListNum > 0)
    {
        int nAreaList = Random(nAreaListNum) + 1;
        nTileset = GetLocalInt(oTempHolder, "nAreaList" + IntToString(nAreaList));
        DebugMessage("  nAreaList" + IntToString(nAreaList) + " is " + IntToString(nTileset));

        string sArea;
        if (nTileset == CASTLE_INTERIOR)
        {
            sArea = "Area260";
        } else if (nTileset == CRYPT)
        {
            sArea = "Area101";
        } else if (nTileset == DESERT)
        {
            sArea = "Area240";
        } else if (nTileset == DROW_INTERIOR)
        {
            sArea = "Area100";
        } else if (nTileset == DUNGEON)
        {
            sArea = "Area060";
        } else if (nTileset == FROZEN_WASTES)
        {
            sArea = "Area139";
        } else if (nTileset == ILLITHID_INTERIOR)
        {
            sArea = "Area180";
        } else if (nTileset == MINES_AND_CAVERNS)
        {
            sArea = "Area220";
        } else if (nTileset == RUINS)
        {
            sArea = "Area160";
        } else if (nTileset == SEWERS)
        {
            sArea = "Area200";
        } else if (nTileset == UNDERDARK)
        {
            sArea = "Area001";
        } else if (nTileset == STEAMWORKS)
        {
            sArea = "Area080";
        } else if (nTileset == KEEP_INTERIOR_STONE)
        {
            sArea = "Area021";
        }
        DebugMessage("  sArea is " + sArea);

        object oArea = GetObjectByTag(sArea);
        if (oArea != OBJECT_INVALID)
        {
            DebugMessage("  Area object is valid.");
            nArea = GetLocalInt(oArea, "nAreaIdentifier");
        }
    }

    DestroyObject(oTempHolder);

    return nArea;
}

int GetTilesetNumber(int nAreaIdentifier)
{
    object oArea = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nAreaIdentifier));
    string sTileset = GetTilesetResRef(oArea);
    int nTileset = GetLocalInt(GetModule(), "nTileset_" + sTileset);

    return nTileset;
}

//void main() {}

