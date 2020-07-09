#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_text"

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
    int nAttitude = GetLocalInt(oDungeon, "n" + sPlot + "GiverAttitude");
    int bPlural = GetLocalInt(oDungeon, "b" + sPlot + "GiverPlural");

    // reward
    int nReward = GetLocalInt(oDungeon, "n" + sPlot + "Reward");

    string sToken = "";

    // temporary variable holders
    int nNum;
    string sString;

    if (nGameplayType == 1)
    {
        int nKilled = GetLocalInt(oDungeon, "n" + sPlot + "CreaturesKilled");

        if (nKilled > 0)
        {
            int nCreatureType = GetLocalInt(oDungeon, "n" + sPlot + "Creature");
            string sCreatureName = GetLocalString(oDungeon, "sListCreature" + IntToString(nCreatureType) + "NamePlural");

            // create reward microprocess
            object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU32");
            SetLocalInt(oMicroCPU, "nPlot", nPlot);
            SetLocalInt(oMicroCPU, "nGold", nReward * nKilled);
            SetLocalInt(oMicroCPU, "nXP", nReward * nKilled);
            SetLocalString(oMicroCPU, "sMessage", "Plot reward for killing " + sCreatureName + ".");

            DelayCommand(0.01, ExecuteScript("exe_id1_micplot3", oMicroCPU));

            // reset number killed
            SetLocalInt(oDungeon, "n" + sPlot + "CreaturesKilled", 0);
        }
    } else if ((nGameplayType == 3) || (nGameplayType == 4))
    {
        // search player's inventory for the item
        int nItemType = GetLocalInt(oDungeon, "n" + sPlot + "Item");
        string sItemTag = GetLocalString(oDungeon, "sListItem" + IntToString(nItemType) + "ResRef");
        DebugMessage("sItemTag is " + sItemTag);

        object oPC = GetPCSpeaker();

        int nItemNum = 0;
        int nStackSize;
        string sResRef;
        object oObject = GetFirstItemInInventory(oPC);
        while (oObject != OBJECT_INVALID)
        {
            sResRef = GetResRef(oObject);
            DebugMessage("Item resref is " + sResRef);
            if (sResRef == sItemTag)
            {
                nStackSize = GetItemStackSize(oObject);
                nItemNum += nStackSize;
                DebugMessage("  This item is stack size " + IntToString(nStackSize) + " bringing the total to " + IntToString(nItemNum));

                DestroyObject(oObject);
            }

            // get next object
            oObject = GetNextItemInInventory(oPC);
        }

        if (nItemNum > 0)
        {
            string sItemName = GetLocalString(oDungeon, "sListItem" + IntToString(nItemType) + "Name");

            // create reward microprocess
            object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU33");
            SetLocalInt(oMicroCPU, "nPlot", nPlot);
            SetLocalInt(oMicroCPU, "nGold", nReward * nItemNum);
            SetLocalInt(oMicroCPU, "nXP", nReward * nItemNum);
            SetLocalString(oMicroCPU, "sMessage", "Plot reward for finding " + sItemName + ".");

            DelayCommand(0.01, ExecuteScript("exe_id1_micplot3", oMicroCPU));
        }
    }
}

