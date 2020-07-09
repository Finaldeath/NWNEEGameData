#include "inc_id1_utility"
#include "inc_id1_score"
#include "inc_id1_text"

int StartingConditional()
{
    int nCurrent = 8;
    int nOffset = GetLocalInt(OBJECT_SELF, "nQuestLogOffset");
    int nPlotTypeNum = GetLocalInt(OBJECT_SELF, "nPlotTypeNum");

    if ((nOffset + nCurrent) <= nPlotTypeNum)
    {
        // 1 = all quests, 2 = activated quests, 3 = completed quests, 4 = failed quests
        object oDungeon = GetCurrentDungeon();

        object oPC = GetPCSpeaker();
        string sPC = GetPCIdentifier(oPC);
        DebugMessage("Player is " + sPC);

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

        int nOffset = GetLocalInt(OBJECT_SELF, "nQuestLogOffset");
        DebugMessage("Offset is " + IntToString(nOffset));

        int nPlotTypeNum = GetLocalInt(OBJECT_SELF, "nPlotTypeNum");
        DebugMessage("There are " + IntToString(nPlotTypeNum) + " quests of this type.");

        int nToken;
        int nPlot;
        int nPlotType;
        int bFailed;
        int bCompleted;
        int bActivated;
        string sPlot;
        string sToken;
        int nTemp;
        int nTemp2;
        int nTemp3;
        string sTemp;

        // get the dungeon plot number
        nPlot = GetLocalInt(OBJECT_SELF, sVariable + IntToString(nCurrent + nOffset));
        sPlot = "Plot" + IntToString(nPlot);
        DebugMessage("Plot " + sVariable + IntToString(nCurrent + nOffset) + " is " + IntToString(nPlot));

        // get plot type
        nPlotType = GetLocalInt(oDungeon, "n" + sPlot + "GameplayType");
        DebugMessage("  Gameplay type is " + IntToString(nPlotType));
        sToken = "";
        if (nPlotType == 1)
        {
            sToken += "Kill ";

            // get creatures name plural
            nTemp = GetLocalInt(oDungeon, "n" + sPlot + "Creature");
            DebugMessage("  Dungeon creature number is " + IntToString(nTemp));
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
            DebugMessage("  There are " + IntToString(nTemp) + " levels.");
            if (nTemp > 1)
            {
                sToken += "s";
            }
            sToken += " ";
            nTemp2 = 1;
            while (nTemp2 < nTemp)
            {
                nTemp3 = GetLocalInt(oDungeon, "n" + sPlot + "Level" + IntToString(nTemp2));
                DebugMessage("  n" + sPlot + "Level" + IntToString(nTemp2) + " is " + IntToString(nTemp3));
                sToken += IntToString(nTemp3);
                if (nTemp2 < nTemp - 1)
                {
                    sToken += ", ";
                } else
                {
                    sToken += " and ";
                }
                nTemp2++;
            }
            nTemp3 = GetLocalInt(oDungeon, "n" + sPlot + "Level" + IntToString(nTemp2));
            sToken += IntToString(nTemp3) + ".";
        } else if ((nPlotType == 3) || (nPlotType == 4))
        {
            sToken += "Find ";

            nTemp = GetLocalInt(oDungeon, "n" + sPlot + "Item");
            DebugMessage("  Dungeon item number is " + IntToString(nTemp));
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
                DebugMessage("  Dungeon creature number is " + IntToString(nTemp));
                sTemp = GetLocalString(oDungeon, "sListCreature" + IntToString(nTemp) + "NameSingular");
                sToken += sTemp + " named ";
                sTemp = GetLocalString(oDungeon, "s" + sPlot + "CreatureName");
            } else
            {
                nTemp = GetLocalInt(oDungeon, "n" + sPlot + "Placeable");
                DebugMessage("  Dungeon placeable number is " + IntToString(nTemp));
                sTemp = GetLocalString(oDungeon, "sListPlotContainer" + IntToString(nTemp) + "Name");
            }
            sToken += sTemp + " on level ";
            nTemp = GetLocalInt(oDungeon, "n" + sPlot + "Level1");
            sToken += IntToString(nTemp) + ".";
        }

        // get plot status
        bFailed = GetLocalInt(oDungeon, "b" + sPlot + "Failed");
        bCompleted = GetLocalInt(oDungeon, "b" + sPlot + "Completed");
        bActivated = GetLocalInt(oDungeon, "b" + sPlot + "Activated");
        if (bFailed == TRUE)
        {
            sToken += MakeTextRed(" [Failed]");
        } else if (bCompleted == TRUE)
        {
            sToken += MakeTextGreen(" [Complete]");
        } else if (bActivated == TRUE)
        {
            sToken += MakeTextYellow(" [Active]");
        }

        // set the appropriate token number
        nToken = 5100 + nCurrent;

        SetCustomToken(nToken, sToken);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
