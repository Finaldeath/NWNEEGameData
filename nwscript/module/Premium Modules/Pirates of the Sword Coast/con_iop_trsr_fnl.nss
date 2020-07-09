//::///////////////////////////////////////////////
//:: con_iop_trsr_fnl
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has this map been completed?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
#include "inc_map_system"

int StartingConditional()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();
    object oMap = GetLocalObject(oPC, "PLC_CONVOBJ");
    string sMap = GetLocalString(oMap, "HUNT_NAME");

    int iStepNumber = GetLocalInt(oModule, sMap+"_STEP");
    int iResult = FALSE;

    // if the Map is complete return true
    if (iStepNumber == 100)
    {
        iResult = TRUE;
    }

    return iResult;
}

