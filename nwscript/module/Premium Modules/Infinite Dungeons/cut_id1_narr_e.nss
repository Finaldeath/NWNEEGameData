//::///////////////////////////////////////////////
//:: cut_id1_narr_e
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    End script for the 2nd through 5th
    narrator cutscenes.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 9, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"

const string TELEPORT_WAYPOINT = "TeleportWP";

void JumpOut(location lWP);

void main()
{
    object oWP = GetLocalObject(OBJECT_SELF, TELEPORT_WAYPOINT);
    // defaults to start location
    location lWP = GetStartingLocation();

    if(GetIsObjectValid(oWP))
    {
        // make sure the waypoint is in the same area as the start location
        // (warehouse) - if so, set lWP to that waypoint's location
        if (GetArea(oWP) == GetAreaFromLocation(lWP))
        {
            lWP = GetLocation(oWP);
        }
    }

    JumpOut(lWP);

    // fail-safe, since things always seem to screw up sooner or later
    DelayCommand(5.0, JumpOut(lWP));
    DelayCommand(10.0, JumpOut(lWP));

    int nTriggerPlot = GetLocalInt(GetModule(), "nTriggerPlot");
    nTriggerPlot++;
    SetLocalInt(GetModule(), "nTriggerPlot", nTriggerPlot);

    DebugMessage("End cutscene triggering. nTriggerPlot = " + IntToString(nTriggerPlot));

    // EDIT: to try to fix end credits bug
    if (nTriggerPlot == 5)
    {
        SetLocalInt(GetModule(), "ID_MODULE_CREDITS", 1);

//        object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "CreditsCPU");
//        DelayCommand(0.01, ExecuteScript("exe_id1_endhalas", oMicroCPU));
    }
}

void JumpOut(location lWP)
{
    int nPC = 0;
    object oPC = GetPCInArea(OBJECT_SELF, 0);
    while(GetIsObjectValid(oPC))
    {
        DelayCommand(0.1, JumpPCsToLocation (lWP, 0, oPC));
        nPC++;
        oPC = GetPCInArea(OBJECT_SELF, nPC);
    }
}

