//:://////////////////////////////////////////////
//:: con_a0_nomaster
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If the NPC doesn't currently have a master
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

    if (GetMaster(oSelf) == OBJECT_INVALID)
    {
        iResult = TRUE;
    }

    return iResult;
}
