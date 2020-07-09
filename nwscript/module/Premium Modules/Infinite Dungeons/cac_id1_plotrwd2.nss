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

    if ((nGameplayType == 2) || (nGameplayType == 5))
    {
        // create reward microprocess
        object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU34");
        SetLocalInt(oMicroCPU, "nPlot", nPlot);
        SetLocalInt(oMicroCPU, "nGold", nReward);
        SetLocalInt(oMicroCPU, "nXP", nReward);

        if (nGameplayType == 2)
        {
            SetLocalString(oMicroCPU, "sMessage", "Plot reward for clearing areas.");
        } else
        {
            SetLocalString(oMicroCPU, "sMessage", "Plot reward for exploring areas.");
        }

        DelayCommand(0.01, ExecuteScript("exe_id1_micplot3", oMicroCPU));
    }

    object oMaster = GetMaster();
    if (oMaster != OBJECT_INVALID)
    {
        RemoveHenchman(oMaster);
    }
    DestroyObject(OBJECT_SELF);
}

