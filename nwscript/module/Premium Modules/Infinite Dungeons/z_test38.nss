#include "inc_id1_score"
#include "inc_id1_utility"

void main()
{
    // if quest is not activated
    int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
    object oDungeon = GetCurrentDungeon();
    SetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Completed", TRUE);

    string sName = GetLocalString(oDungeon, "sPlot" + IntToString(nPlot) + "CreatureName");

    int nReward = GetLocalInt(oDungeon, "nPlot" + IntToString(nPlot) + "Reward");

    // create reward microprocess
    object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU125");
    SetLocalInt(oMicroCPU, "nPlot", nPlot);
    SetLocalInt(oMicroCPU, "nGold", nReward);
    SetLocalInt(oMicroCPU, "nXP", nReward);
    SetLocalString(oMicroCPU, "sMessage", "Plot reward for finding " + sName + ".");

    DelayCommand(0.01, ExecuteScript("exe_id1_micplot3", oMicroCPU));

//    DelayCommand(0.02, DestroyObject(OBJECT_SELF));
}
