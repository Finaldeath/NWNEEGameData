//::///////////////////////////////////////////////
//:: con_a1_drakfear
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC has successfully intimidated Drak?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oDrak = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    int iResult, iFear;

    iFear = GetLocalInt(oDrak, "A1_DRAKAFRAID");

    if (iFear == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
