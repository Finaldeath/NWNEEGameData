#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_text"

void main()
{
    // get the current quest number
    int nCurrent = GetLocalInt(OBJECT_SELF, "nQuestLogCurrent");
    int nOffset = GetLocalInt(OBJECT_SELF, "nQuestLogOffset");

    int nDisplay = GetLocalInt(OBJECT_SELF, "nQuestLogDisplay");
    DebugMessage("Quest type is " + IntToString(nDisplay));
    string sVariable;
    if (nDisplay == 1) // all
    {
        sVariable = "nPlotTotal";
    } else if (nDisplay == 2) // activated
    {
        sVariable = "nPlotActivated";
    } else if (nDisplay == 3) // completed
    {
        sVariable = "nPlotCompleted";
    } else if (nDisplay == 4) // failed
    {
        sVariable = "nPlotFailed";
    }

    // get the dungeon plot number
    int nPlot = GetLocalInt(OBJECT_SELF, sVariable + IntToString(nCurrent + nOffset));
    string sPlot = "Plot" + IntToString(nPlot);
    DebugMessage("Plot " + sVariable + IntToString(nCurrent + nOffset) + " is " + IntToString(nPlot));

    object oDungeon = GetCurrentDungeon();

    // get plot status
    int bFailed = GetLocalInt(oDungeon, "b" + sPlot + "Failed");
    int bCompleted = GetLocalInt(oDungeon, "b" + sPlot + "Completed");
    int bActivated = GetLocalInt(oDungeon, "b" + sPlot + "Activated");
    string sToken = "";
    if (bFailed == TRUE)
    {
        sToken += "This quest has been " + MakeTextRed("Failed") + ".";
    } else if (bCompleted == TRUE)
    {
        sToken += "This quest has been " + MakeTextGreen("Completed") + ".";
    } else if (bActivated == TRUE)
    {
        sToken += "This quest is " + MakeTextYellow("Active") + ".";
    }
    sToken = AddLineBreak(sToken);
    sToken = AddLineBreak(sToken);

    // find data path on dungeon
    int nLevel = GetLocalInt(oDungeon, "n" + sPlot + "StartLevel");
    int nArea = GetLocalInt(oDungeon, "n" + sPlot + "StartArea");
    int nWaypoint = GetLocalInt(oDungeon, "n" + sPlot + "StartWaypoint");
    string sLevel = "Area" + IntToString(nArea) + "WaypointPlot" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
    int nPlotWaypointNum = GetLocalInt(oDungeon, "n" + sLevel + "PlotNum");
    int nPlotWaypoint = 1;
    int nPlotWaypointPlot =GetLocalInt(oDungeon, "n" + sLevel + "Plot" + IntToString(nPlotWaypoint));
    while ((nPlotWaypoint <= nPlotWaypointNum) && (nPlotWaypointPlot != nPlot))
    {
        nPlotWaypoint++;
        nPlotWaypointPlot =GetLocalInt(oDungeon, "n" + sLevel + "Plot" + IntToString(nPlotWaypoint));
    }
    string sPlotLevel = sLevel + "Plot" + IntToString(nPlotWaypoint);

    // plot giver info
    sToken += "This quest was given by the ";
    int nCreature = GetLocalInt(oDungeon, "n" + sPlotLevel + "Object");
    string sCreature = GetLocalString(oDungeon, "sListCreature" + IntToString(nCreature) + "NameSingular");
    sToken += sCreature + " named ";
    sCreature = GetLocalString(oDungeon, "s" + sPlotLevel + "ObjectName");
    sToken += sCreature + " on level " + IntToString(nLevel);

    int bAccompany = GetLocalInt(oDungeon, "b" + sPlot + "GiverAccompany");
    if (bAccompany == TRUE)
    {
        if ((bFailed == TRUE) || (bCompleted == TRUE))
        {
            sToken += " who accompanied your group";
        } else
        {
            sToken += " who is accompanying your group";
        }
    }
    sToken += ".";
    sToken = AddLineBreak(sToken);

    // get plot type
    int nPlotType = GetLocalInt(oDungeon, "n" + sPlot + "GameplayType");
    DebugMessage("Plot type is " + IntToString(nPlotType));

    int nTemp;
    int nTemp2;
    int nTemp3;
    string sTemp;
    if (nPlotType == 1)
    {
        sToken += "Kill ";

        // get creatures name plural
        nTemp = GetLocalInt(oDungeon, "n" + sPlot + "Creature");
        sTemp = GetLocalString(oDungeon, "sListCreature" + IntToString(nTemp) + "NamePlural");
        sToken += sTemp + ".";
    } else if ((nPlotType == 2) || (nPlotType == 5))
    {
        if (nPlotType == 2)
        {
            sToken += "Clear areas on level";
        } else
        {
            sToken += "Explore areas on level";
        }

        // level information
        nTemp = GetLocalInt(oDungeon, "n" + sPlot + "LevelNum");
        if (nTemp > 1)
        {
            sToken += "s";
        }
        sToken += " ";
        nTemp2 = 1;
        while (nTemp2 < nTemp)
        {
            nTemp3 = GetLocalInt(oDungeon, "n" + sPlot + "Level" + IntToString(nTemp2));
            sToken += IntToString(nTemp3);
            if (nTemp2 < nTemp - 1)
            {
                sToken += ", ";
            } else
            {
                sToken += " and ";
            }
            nTemp++;
        }
        nTemp3 = GetLocalInt(oDungeon, "n" + sPlot + "Level" + IntToString(nTemp2));
        sToken += IntToString(nTemp3) + ".";

        // area breakdown
        nTemp2 = 1;
        nTemp3 = GetLocalInt(oDungeon, "n" + sPlot + "Level" + IntToString(nTemp2));
        int nMaxLevel = GetLocalInt(oDungeon, "nMaxLevel");
        int nTemp4;
        int nTemp5;
        int nTemp6;
        int nTemp7;
        while ((nMaxLevel >= nTemp3) && (nTemp2 <= nTemp))
        {
            // add the areas in this level
            sToken = AddLineBreak(sToken);
            sToken += "Level " + IntToString(nTemp3) + " -";
            nTemp4 = GetLocalInt(oDungeon, "n" + sPlot + "Level" + IntToString(nTemp2) + "AreaNum");
            nTemp5 = 1;
            while (nTemp5 <= nTemp4)
            {
                nTemp6 = GetLocalInt(oDungeon, "n" + sPlot + "Level" + IntToString(nTemp2) + "Area" + IntToString(nTemp5));
                sToken += " (";
                nTemp7 = GetLocalInt(oDungeon, "nArea" + IntToString(nTemp6) + "Level" + IntToString(nTemp3) + "X");
                sToken += IntToString(nTemp7) + ",";
                nTemp7 = GetLocalInt(oDungeon, "nArea" + IntToString(nTemp6) + "Level" + IntToString(nTemp3) + "Y");
                sToken += IntToString(nTemp7) + ")";
                nTemp5++;
            }

            nTemp2++;
            nTemp3 = GetLocalInt(oDungeon, "n" + sPlot + "Level" + IntToString(nTemp2));
        }
    } else if ((nPlotType == 3) || (nPlotType == 4))
    {
        sToken += "Find ";

        nTemp = GetLocalInt(oDungeon, "n" + sPlot + "Item");
        sTemp = GetLocalString(oDungeon, "sListItem" + IntToString(nTemp) + "Name");
        sToken += sTemp;
        if (nPlotType == 3)
        {
            sToken += " on creatures.";
        } else
        {
            sToken += " in containers.";
        }
    } else if ((nPlotType == 6) || (nPlotType == 7))
    {
        sToken += "Find the ";
        if (nPlotType == 6)
        {
            nTemp = GetLocalInt(oDungeon, "n" + sPlot + "Creature");
            sTemp = GetLocalString(oDungeon, "sListCreature" + IntToString(nTemp) + "NameSingular");
            sToken += sTemp + " named ";
            sTemp = GetLocalString(oDungeon, "s" + sPlot + "CreatureName");
        } else
        {
            nTemp = GetLocalInt(oDungeon, "n" + sPlot + "Placeable");
            sTemp = GetLocalString(oDungeon, "sListPlotContainer" + IntToString(nTemp) + "Name");
        }
        sToken += sTemp + " on level ";
        nTemp = GetLocalInt(oDungeon, "n" + sPlot + "Level1");
        sToken += IntToString(nTemp) + ".";
    }

    SetCustomToken(5100, sToken);
}
