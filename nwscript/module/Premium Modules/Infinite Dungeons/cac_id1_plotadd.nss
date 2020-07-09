#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_score"
#include "x0_i0_henchman"

void main()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
    DebugMessage("sVariable is " + sVariable);
    int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
    DebugMessage("nPlot is " + IntToString(nPlot));

    string sPlot = "Plot" + IntToString(nPlot);
    DebugMessage("sPlot is " + sPlot);

    // set the plot as activated
    SetLocalInt(oDungeon, "b" + sPlot + "Activated", TRUE);

    string sIdentifier;
    int nPlayerNum;

    object oPC = GetPCSpeaker();
    object oPlayer = GetFirstFactionMember(oPC, TRUE);
    while (oPlayer != OBJECT_INVALID)
    {
        sIdentifier = GetPCIdentifier(oPlayer);

        nPlayerNum = GetLocalInt(oDungeon, "n" + sPlot + "PlayerNum");
        nPlayerNum++;
        SetLocalInt(oDungeon, "n" + sPlot + "PlayerNum", nPlayerNum);
        SetLocalString(oDungeon, "s" + sPlot + "Player" + IntToString(nPlayerNum), sIdentifier);
        SetLocalInt(oDungeon, "b" + sPlot + "Player_" + sIdentifier, TRUE);
        DebugMessage("  Set s" + sPlot + "Player" + IntToString(nPlayerNum) + " to " + sIdentifier);

        oPlayer = GetNextFactionMember(oPC);
    }

    // determine if plotgiver should accompany the player
    int bAccompany = GetLocalInt(oDungeon, "b" + sPlot + "GiverAccompany");

    if (bAccompany == TRUE)
    {
        AddHenchman(oPC, OBJECT_SELF);
        SetAssociateState(NW_ASC_DISTANCE_2_METERS);
        SetLocalInt(OBJECT_SELF, "bFollower", TRUE);
        SetLocalInt(oDungeon, "b" + sVariable + "Gone", TRUE);
    }

    int nCurrentLevel = GetCurrentLevel();
    object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU30");
    SetLocalInt(oMicroCPU, "nPlot", nPlot);
    SetLocalInt(oMicroCPU, "nLevel", nCurrentLevel);
    DelayCommand(0.01, ExecuteScript("exe_id1_micplot6", oMicroCPU));
}
