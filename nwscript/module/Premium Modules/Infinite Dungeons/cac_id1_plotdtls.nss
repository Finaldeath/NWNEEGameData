#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_text"

string GetLocationString(string sPlot, int nGameplayType = 0, object oDungeon = OBJECT_INVALID);

void main()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
    DebugMessage("sVariable is " + sVariable);
    int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
    DebugMessage("nPlot is " + IntToString(nPlot));

    string sPlot = "Plot" + IntToString(nPlot);
    DebugMessage("sPlot is " + sPlot);

    // gameplay type
    int nGameplayType = GetLocalInt(oDungeon, "n" + sPlot + "GameplayType");
    DebugMessage("Plot gameplay type is " + IntToString(nGameplayType));

    // plot giver specifics
    int bPlural = GetLocalInt(oDungeon, "b" + sPlot + "GiverPlural");

    string sToken = "";

    // temporary variable holders
    int nNum;
    string sString;

    // construct string
    if (nGameplayType == 1) // kill creatures
    {
        // prep phrase
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverPrepPhrase");
        sString = GetLocalString(GetModule(), "sLinesPlotPrepPhrase" + IntToString(nNum));
        sToken += sString + " ";

        // plural monster type
        int nCreatureType = GetLocalInt(oDungeon, "n" + sPlot + "Creature");
        string sCreatureType = GetLocalString(oDungeon, "sListCreature" + IntToString(nCreatureType) + "NamePlural");
        if (sCreatureType == "")
        {
            sCreatureType = "Penguins";
        }
        sToken += sCreatureType + " ";

        // verb living
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbLiving");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbLiving" + IntToString(nNum));
        sToken += sString + " on ";

        // location
        sToken += GetLocationString(sPlot, nGameplayType, oDungeon) + ". ";

        // personal reference
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverPersonalReference");
        if (bPlural == FALSE)
        {
            sString = GetLocalString(GetModule(), "sLinesPlotPersonalReferenceSingular" + IntToString(nNum));
        } else
        {
            sString = GetLocalString(GetModule(), "sLinesPlotPersonalReferencePlural" + IntToString(nNum));
        }
        sToken += sString + " ";

        // verb want
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbWant");
        if (bPlural == FALSE)
        {
            sString = GetLocalString(GetModule(), "sLinesPlotVerbWantSingular" + IntToString(nNum));
        } else
        {
            sString = GetLocalString(GetModule(), "sLinesPlotVerbWantPlural" + IntToString(nNum));
        }
        sToken += sString + " for you to ";

        // verb kill
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbKill");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbKill" + IntToString(nNum));
        sToken += sString + " them and I will ";

        // verb reward
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbReward");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbReward" + IntToString(nNum));
        sToken += sString + " you for each one.";
    } else if (nGameplayType == 2) // clear areas
    {
        // personal reference
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverPersonalReference");
        if (bPlural == FALSE)
        {
            sString = GetLocalString(GetModule(), "sLinesPlotPersonalReferenceSingular" + IntToString(nNum));
        } else
        {
            sString = GetLocalString(GetModule(), "sLinesPlotPersonalReferencePlural" + IntToString(nNum));
        }
        sToken += sString + " ";

        // verb want
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbWant");
        if (bPlural == FALSE)
        {
            sString = GetLocalString(GetModule(), "sLinesPlotVerbWantSingular" + IntToString(nNum));
        } else
        {
            sString = GetLocalString(GetModule(), "sLinesPlotVerbWantPlural" + IntToString(nNum));
        }
        sToken += sString + " for you to ";

        // verb kill
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbKill");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbKill" + IntToString(nNum));
        sToken += sString + " all enemies in certain areas on ";

        // location
        sToken += GetLocationString(sPlot, nGameplayType, oDungeon) + ". When you reach a level, I'll update the areas you'll need in your dungeon journal.";
    } else if (nGameplayType == 3) // items on creatures
    {
        // personal reference
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverPersonalReference");
        if (bPlural == FALSE)
        {
            sString = GetLocalString(GetModule(), "sLinesPlotPersonalReferenceSingular" + IntToString(nNum));
        } else
        {
            sString = GetLocalString(GetModule(), "sLinesPlotPersonalReferencePlural" + IntToString(nNum));
        }
        sToken += sString + " ";

        // verb want
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbWant");
        if (bPlural == FALSE)
        {
            sString = GetLocalString(GetModule(), "sLinesPlotVerbWantSingular" + IntToString(nNum));
        } else
        {
            sString = GetLocalString(GetModule(), "sLinesPlotVerbWantPlural" + IntToString(nNum));
        }
        sToken += sString + " for you to ";

        // verb fetch
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbFetch");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbFetch" + IntToString(nNum));
        sToken += sString + " ";

        // item name
        int nPlaceableType = GetLocalInt(oDungeon, "n" + sPlot + "Item");
        string sPlaceableType = GetLocalString(oDungeon, "sListItem" + IntToString(nPlaceableType) + "Name");
        sToken += sPlaceableType + ". Some are found on creatures on ";

        // location
        sToken += GetLocationString(sPlot, nGameplayType, oDungeon) + " and I will ";

        // verb reward
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbReward");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbReward" + IntToString(nNum));
        sToken += sString + " you for each one you ";

        // verb fetch
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbFetch");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbFetch" + IntToString(nNum));
        sToken += sString + ".";
    } else if (nGameplayType == 4) // items on placeables
    {
        // personal reference
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverPersonalReference");
        if (bPlural == FALSE)
        {
            sString = GetLocalString(GetModule(), "sLinesPlotPersonalReferenceSingular" + IntToString(nNum));
        } else
        {
            sString = GetLocalString(GetModule(), "sLinesPlotPersonalReferencePlural" + IntToString(nNum));
        }
        sToken += sString + " ";

        // verb want
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbWant");
        if (bPlural == FALSE)
        {
            sString = GetLocalString(GetModule(), "sLinesPlotVerbWantSingular" + IntToString(nNum));
        } else
        {
            sString = GetLocalString(GetModule(), "sLinesPlotVerbWantPlural" + IntToString(nNum));
        }
        sToken += sString + " for you to ";

        // verb fetch
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbFetch");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbFetch" + IntToString(nNum));
        sToken += sString + " ";

        // item name
        int nPlaceableType = GetLocalInt(oDungeon, "n" + sPlot + "Item");
        string sPlaceableType = GetLocalString(oDungeon, "sListItem" + IntToString(nPlaceableType) + "Name");
        sToken += sPlaceableType + ". Some are found in containers on ";

        // location
        sToken += GetLocationString(sPlot, nGameplayType, oDungeon) + " and I will ";

        // verb reward
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbReward");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbReward" + IntToString(nNum));
        sToken += sString + " you for each one you ";

        // verb fetch
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbFetch");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbFetch" + IntToString(nNum));
        sToken += sString + ".";
    } else if (nGameplayType == 5) // explore areas
    {
        // personal reference
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverPersonalReference");
        if (bPlural == FALSE)
        {
            sString = GetLocalString(GetModule(), "sLinesPlotPersonalReferenceSingular" + IntToString(nNum));
        } else
        {
            sString = GetLocalString(GetModule(), "sLinesPlotPersonalReferencePlural" + IntToString(nNum));
        }
        sToken += sString + " ";

        // verb want
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbWant");
        if (bPlural == FALSE)
        {
            sString = GetLocalString(GetModule(), "sLinesPlotVerbWantSingular" + IntToString(nNum));
        } else
        {
            sString = GetLocalString(GetModule(), "sLinesPlotVerbWantPlural" + IntToString(nNum));
        }
        sToken += sString + " for you to ";

        // verb explore
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbExplore");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbExplore" + IntToString(nNum));
        sToken += sString + " certain areas on ";

        // location
        sToken += GetLocationString(sPlot, nGameplayType, oDungeon) + " and ";

        // verb see
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbSee");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbSee" + IntToString(nNum));
        sToken += sString + " ";

        // noun there
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverNounThere");
        sString = GetLocalString(GetModule(), "sLinesPlotNounThere" + IntToString(nNum));
        sToken += sString + " When you reach a level, I'll update the areas you'll need in your dungeon journal.";
    } else if (nGameplayType == 6) // find creature
    {
        // personal reference
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverPersonalReference");
        if (bPlural == FALSE)
        {
            sString = GetLocalString(GetModule(), "sLinesPlotPersonalReferenceSingular" + IntToString(nNum));
        } else
        {
            sString = GetLocalString(GetModule(), "sLinesPlotPersonalReferencePlural" + IntToString(nNum));
        }
        sToken += sString + " ";

        // adverb
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverAdverb");
        sString = GetLocalString(GetModule(), "sLinesPlotAdverb" + IntToString(nNum));
        sToken += sString + " ";

        // verb want
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbWant");
        if (bPlural == FALSE)
        {
            sString = GetLocalString(GetModule(), "sLinesPlotVerbWantSingular" + IntToString(nNum));
        } else
        {
            sString = GetLocalString(GetModule(), "sLinesPlotVerbWantPlural" + IntToString(nNum));
        }
        sToken += sString + " for you to ";

        // verb speakto
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbSpeakTo");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbSpeakTo" + IntToString(nNum));
        sToken += sString + " ";

        // singular monster type
        int nCreatureType = GetLocalInt(oDungeon, "n" + sPlot + "Creature");
        string sCreatureType = GetLocalString(oDungeon, "sListCreature" + IntToString(nCreatureType) + "NameSingular");
        if (sCreatureType == "")
        {
            sCreatureType = "Penguin";
        }
        sString = GetSubString(sCreatureType, 0, 1);
        if ((sString == "A") || (sString == "E") || (sString == "I") || (sString == "O") || (sString == "U"))
        {
            sToken += "an ";
        } else
        {
            sToken += "a ";
        }
        sToken += sCreatureType + " named ";

        // destination name
        string sCreatureName = GetLocalString(oDungeon, "s" + sPlot + "CreatureName");
        sToken += sCreatureName + ". " + sCreatureName + " can be found on ";

        // location
        sToken += GetLocationString(sPlot, nGameplayType, oDungeon) + ".";
    } else if (nGameplayType == 7) // find object
    {
        // personal reference
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverPersonalReference");
        if (bPlural == FALSE)
        {
            sString = GetLocalString(GetModule(), "sLinesPlotPersonalReferenceSingular" + IntToString(nNum));
        } else
        {
            sString = GetLocalString(GetModule(), "sLinesPlotPersonalReferencePlural" + IntToString(nNum));
        }
        sToken += sString + " ";

        // adverb
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverAdverb");
        sString = GetLocalString(GetModule(), "sLinesPlotAdverb" + IntToString(nNum));
        sToken += sString + " ";

        // verb want
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbWant");
        if (bPlural == FALSE)
        {
            sString = GetLocalString(GetModule(), "sLinesPlotVerbWantSingular" + IntToString(nNum));
        } else
        {
            sString = GetLocalString(GetModule(), "sLinesPlotVerbWantPlural" + IntToString(nNum));
        }
        sToken += sString + " for you to ";

        // verb use
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbUse");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbUse" + IntToString(nNum));
        sToken += sString + " ";

        // singular monster type
        int nPlaceableType = GetLocalInt(oDungeon, "n" + sPlot + "Placeable");
        string sPlaceableType = GetLocalString(oDungeon, "sListPlotContainer" + IntToString(nPlaceableType) + "Name");
        DebugMessage("Plot placeable is " + IntToString(nPlaceableType) + " and name " + sPlaceableType);
        sString = GetSubString(sPlaceableType, 0, 1);
        if ((sString == "A") || (sString == "E") || (sString == "I") || (sString == "O") || (sString == "U"))
        {
            sToken += "an ";
        } else
        {
            sToken += "a ";
        }
        sToken += sPlaceableType + " on ";

        // location
        sToken += GetLocationString(sPlot, nGameplayType, oDungeon) + ". It is a very specific " + sPlaceableType + ".";
    }

    // set the custom token
    SetCustomToken(5001, sToken);
}

string GetLocationString(string sPlot, int nGameplayType = 0, object oDungeon = OBJECT_INVALID)
{
    if (oDungeon == OBJECT_INVALID)
    {
        oDungeon = GetCurrentDungeon();
    }

    // level details
    int nLevelNum = GetLocalInt(oDungeon, "n" + sPlot + "LevelNum");
    DebugMessage("Plot has " + IntToString(nLevelNum) + " levels.");
    int nLevel = 1;
    int nTargetLevel;
    int nMaxLevel = GetLocalInt(oDungeon, "nMaxLevel");
    string sLevel;
    int nAreaNum;
    int nArea;
    int nX;
    int nY;
    string sArea;
    int nTargetArea;
    int bExplored;
    int bCleared;
    string sToken = "";
    while (nLevel <= nLevelNum)
    {
        DebugMessage("On level " + IntToString(nLevel) + " of " + IntToString(nLevelNum));

        // determine level
        nTargetLevel = GetLocalInt(oDungeon, "n" + sPlot + "Level" + IntToString(nLevel));
        sToken += "Level " + IntToString(nTargetLevel);

        if (nLevel < nLevelNum)
        {
            sToken += ", ";
        }

        nLevel++;
    }

    return sToken;
}

