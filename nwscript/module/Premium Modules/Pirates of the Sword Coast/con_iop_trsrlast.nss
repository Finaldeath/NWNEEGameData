//::///////////////////////////////////////////////
//:: con_iop_trsrlast
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the Player found the final step
    in the map?
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
    object oTarget = OBJECT_INVALID;
    object oDestroy = OBJECT_INVALID;
    string sMap = GetLocalString(oMap, "HUNT_NAME");
    string sTreasure = GetLocalString(oMap, "TREASURE_RESREF");
    int iStepNumber = GetLocalInt(oModule, sMap+"_STEP");
    float fDistance;
    int iResult = FALSE;
    int iTrsrCount = 0;

    oTarget = GetObjectByTag("WP_" + sMap + IntToString(iStepNumber));
    oDestroy = GetLocalObject(oTarget, "OBJ_PLACED");
    fDistance = GetDistanceBetween(oTarget, oPC);

    // If the player is close enough, create the treasure
    if ((fDistance < 3.0f) && (iStepNumber == 99)
        && (GetIsObjectValid(oTarget) == TRUE))
    {
        SetLocalInt(oModule, sMap+"_STEP", 100);
        CreateObject(OBJECT_TYPE_PLACEABLE, sTreasure, GetLocation(oTarget));
        DestroyObject(oDestroy);
        DestroyObject(oMap);

        if (GetTag(oMap) != "a2_flowers")
        {
            iTrsrCount = GetLocalInt(oModule, "POTSC_TREASURECOUNT");
            SetLocalInt(oModule, "POTSC_TREASURECOUNT", iTrsrCount + 1);
        }

        iResult = TRUE;
    }

    return iResult;
}

