//:://////////////////////////////////////////////
//:: con_a0_bsymaster
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If the PC speaker is not the NPC's master
    return true.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oSelf = OBJECT_SELF;
    int iResult = FALSE;

    if (GetMaster(oSelf) != oPC)
    {
        iResult = TRUE;
    }

    return iResult;
}
