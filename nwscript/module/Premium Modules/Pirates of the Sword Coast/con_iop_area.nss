//::///////////////////////////////////////////////
//:: con_iop_area
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the player in the right area?
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
    object oTarget, oAreaSelf, oAreaTarget;

    string sMap = GetLocalString(oMap, "HUNT_NAME");

    int iStepNumber = GetLocalInt(oModule, sMap+"_STEP");
    int iResult = FALSE;

    oTarget = GetObjectByTag("WP_" + sMap + IntToString(iStepNumber));
    oAreaSelf = GetArea(oPC);
    oAreaTarget = GetArea(oTarget);

    // if the target is in the wrong area return the target area.
    if ((GetIsObjectValid(oTarget) == TRUE) && (oAreaSelf != oAreaTarget))
    {
        SetCustomToken(103, GetName(oAreaTarget));
        iResult = TRUE;
    }

    return iResult;
}

