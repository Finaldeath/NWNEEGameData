//::///////////////////////////////////////////////
//:: con_iop_trsrstep
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the player has found the destination
    for the current map step.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
#include "inc_map_system"

int StartingConditional()
{
    object oModule = GetModule();
    object oTarget = OBJECT_INVALID;
    object oPC = GetPCSpeaker();
    object oMap = GetLocalObject(oPC, "PLC_CONVOBJ");
    object oPLCObject;

    string sMap = GetLocalString(oMap, "HUNT_NAME");
    string sObject;
    int iStepNumber = GetLocalInt(oModule, sMap+"_STEP");
    float fDistance;

    int iResult = FALSE;

    oTarget = GetObjectByTag("WP_" + sMap + IntToString(iStepNumber));
    oPLCObject = GetLocalObject(oTarget, "OBJ_PLACED");
    fDistance = GetDistanceBetween(oTarget, oPC);

    if ((fDistance < 3.0f) && (iStepNumber != 99)
        && (GetIsObjectValid(oPLCObject) == TRUE))
    {

        oTarget = GetObjectByTag("WP_" + sMap + IntToString(iStepNumber+1));
        if (GetIsObjectValid(oTarget) == TRUE)
        {
            SetLocalInt(oModule, sMap+"_STEP", (iStepNumber+1));
        }
        else
        {
            oTarget = GetObjectByTag("WP_" + sMap + IntToString(99));

            if (GetIsObjectValid(oTarget) == TRUE)
            {
                SetLocalInt(oModule, sMap+"_STEP", 99);
            }
        }

        sObject = GetName(oPLCObject);
        SetCustomToken(100, sObject);

        iResult = TRUE;
    }

    return iResult;
}

