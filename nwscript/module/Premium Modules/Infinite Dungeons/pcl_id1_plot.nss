#include "inc_id1_utility"
#include "inc_id1_score"

int GOLD_REWARD = 500;
int XP_REWARD = 500;

void main()
{
    int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
    DebugMessage("Plot for item " + GetTag(OBJECT_SELF) + " is " + IntToString(nPlot));
    object oDungeon = GetCurrentDungeon();

    // if the plot is active
    if (GetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Activated") == TRUE)
    {
        // if not completed already
        if (GetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Completed") == FALSE)
        {
            // if not failed already
            if (GetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Failed") == FALSE)
            {
                // if the player is a member of the quest
                object oPC = GetPlaceableLastClickedBy();
                AssignCommand(oPC, ActionMoveToObject(OBJECT_SELF));
                string sIdentifier = GetPCIdentifier(oPC);
                DebugMessage("Player identifier is " + sIdentifier);
                if (GetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Player_" + sIdentifier) > 0)
                {
                    SetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Completed", TRUE);

                    // April 4, 2006 - GM: Award points for plot completion.
                    AwardPlotCompletedPoints();

                    // create reward microprocess
                    object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU116");
                    SetLocalInt(oMicroCPU, "nPlot", nPlot);
                    SetLocalInt(oMicroCPU, "nGold", GOLD_REWARD);
                    SetLocalInt(oMicroCPU, "nXP", XP_REWARD);
                    int nPlaceableType = GetLocalInt(oDungeon, "nPlot" + IntToString(nPlot) + "Placeable");
                    string sName = GetLocalString(GetModule(), "sPlotContainer" + IntToString(nPlaceableType) + "Name");
                    SetLocalString(oMicroCPU, "sMessage", "Plot reward for using the " + GetName(OBJECT_SELF) + ".");

                    DelayCommand(0.01, ExecuteScript("exe_id1_micplot3", oMicroCPU));
                } else
                {
                    SpeakString("Somebody must be looking for this object already.");
                }
            } else
            {
                SpeakString("The quest to find this object has already failed.");
            }
        } else
        {
            SpeakString("The quest to find this object has already been completed.");
        }
    } else
    {
        SpeakString("This object must be of some use to somebody.");
    }
}
