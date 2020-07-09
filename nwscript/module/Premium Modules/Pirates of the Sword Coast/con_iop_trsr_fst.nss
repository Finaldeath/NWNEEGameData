//::///////////////////////////////////////////////
//:: con_iop_trsr_fst
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the player on the first leg of the
    treasure hunt?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
#include "inc_map_system"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oMap = GetLocalObject(oPC, "PLC_CONVOBJ");
    object oModule = GetModule();
    int iResult = FALSE;

    object oTarget = OBJECT_INVALID;
    object oPLCObject = OBJECT_INVALID;

    string sMap = GetLocalString(oMap, "HUNT_NAME");

    string sDirection, sDistance, sObject, sResRef;
    float fDirection, fDistance;
    int iDistance, iObjPlaced, iStepNumber;
    location lTarget;

    iStepNumber = GetLocalInt(oModule, sMap+"_STEP");
    oTarget = GetObjectByTag("WP_" + sMap + IntToString(iStepNumber));

    if ((iStepNumber < 1) && (GetIsObjectValid(oTarget) == TRUE))
    {
        oPLCObject = GetLocalObject(oTarget, "OBJ_PLACED");
        lTarget = GetLocation(oTarget);

        if (GetIsObjectValid(oPLCObject) == FALSE)
        {
            sResRef = GetLocalString(oTarget, "OBJ_RESREF");
            oPLCObject = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lTarget);
            SetLocalObject(oTarget, "OBJ_PLACED", oPLCObject);
        }

        sObject = GetName(oPLCObject);

        fDistance = GetDistanceBetween(oPC, oTarget);
        iDistance = FloatToInt(fDistance);
        sDistance = IntToString(iDistance);

        sDirection = GetDirection(oPC, oTarget);

        SetCustomToken(100, sObject);
        SetCustomToken(101, sDistance);
        SetCustomToken(102, sDirection);

        iResult = TRUE;
    }

    return iResult;
}

