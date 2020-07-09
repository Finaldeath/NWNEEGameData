//:://////////////////////////////////////////////////////////////
//:: exe_id1_trans                                              //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: August 2005                                    //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Include Files                                                //
//////////////////////////////////////////////////////////////////

#include "inc_id1_debug"
#include "inc_id1_gen"
//#include "inc_id1_trans"
#include "inc_id1_utility"


//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    DebugMessage("Transporting player.");

    object oPC = GetLocalObject(GetModule(), "oGenerator");
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");

    // get the current dungeon
    object oDungeon = GetCurrentDungeon();

    // EDIT: stairs number 1? wtf? read in the stair number that was activated before and go to that one
    // get the first door on the current level and transport the player there
    string sStair = "nLevel" + IntToString(nCurrentLevel) + "StairsUp1";
    int nDestination = GetLocalInt(oDungeon, sStair);
    int nDestinationIdentifier = GetLocalInt(oDungeon, "nArea" + IntToString(nDestination) + "Identifier");

    DebugMessage(sStair + " is identifier " + IntToString(nDestinationIdentifier));

    object oArea = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nDestinationIdentifier));
    if (oArea == OBJECT_INVALID)
    {
        DebugMessage("  Invalid area for transit.");
    } else
    {
        DebugMessage("  Valid area for transit.");
    }
    object oDoor = GetLocalObject(oArea, "oStairsUp");

    SetLocalObject(GetModule(), "oTempPC", oPC);
    SetLocalObject(GetModule(), "oTempDestinationDoor", oDoor);
    SetLocalObject(GetModule(), "oTempDungeon", oDungeon);

    SetLocalInt(GetModule(), "nActivationProcess", 0);
    DelayCommand(0.01, ExecuteScript("exe_id1_active", GetNextCPU()));
}
