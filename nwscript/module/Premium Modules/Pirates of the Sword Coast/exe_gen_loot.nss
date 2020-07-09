//::///////////////////////////////////////////////
//:: Name exe_gen_loot
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates lootable inventory on object based
    on their local variables.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
#include "inc_bootysystem"

const string S_GENERIC_DROP = "POTSC_BOOTYGENERIC_DROP_COUNT";
const string S_GENERIC_PICK = "POTSC_BOOTYGENERIC_PPOCKET_COUNT";
const string S_UNIQUE_DROP = "POTSC_BOOTYUNIQUE_DROP_COUNT";
const string S_UNIQUE_PICK = "POTSC_BOOTYUNIQUE_PPOCKET_COUNT";
const string S_DEFAULT_GOLD = "POTSC_MAXIMUM_GOLD_COUNT";

void main()
{
    object oTarget = OBJECT_SELF;
    object oItemCursor = OBJECT_INVALID;

    int iGDropCount = GetLocalInt(oTarget, S_GENERIC_DROP);
    int iGPickPCount = GetLocalInt(oTarget, S_GENERIC_PICK);
    int iUDropCount = GetLocalInt(oTarget, S_UNIQUE_DROP);
    int iUPickPCount = GetLocalInt(oTarget, S_UNIQUE_PICK);
    int iMaxGold = GetLocalInt(oTarget, S_DEFAULT_GOLD);
    int iRandGold = Random(iMaxGold) + 1;
    int iCursor = 0;

    // Create Droppable Generic goodies on the target
    for(iCursor = 0; iCursor < iGDropCount; iCursor++)
    {
        oItemCursor = CreateBootyOnObject(oTarget, BOOTY_GENERIC);
        SetDroppableFlag(oItemCursor, TRUE);
        SetPickpocketableFlag(oItemCursor, FALSE);
    }

    // Create Droppable Unique goodies on the target
    for(iCursor = 0; iCursor < iUDropCount; iCursor++)
    {
        oItemCursor = CreateBootyOnObject(oTarget, BOOTY_UNIQUE);
        SetDroppableFlag(oItemCursor, TRUE);
        SetPickpocketableFlag(oItemCursor, FALSE);
    }

    // Create Pick Pocketable Generic goodies on the target
    for(iCursor = 0; iCursor < iGPickPCount; iCursor++)
    {
        oItemCursor = CreateBootyOnObject(oTarget, BOOTY_GENERIC);
        SetDroppableFlag(oItemCursor, FALSE);
        SetPickpocketableFlag(oItemCursor, TRUE);
    }

    // Create Pick Pocketable Unique goodies on the target
    for(iCursor = 0; iCursor < iUPickPCount; iCursor++)
    {
        oItemCursor = CreateBootyOnObject(oTarget, BOOTY_UNIQUE);
        SetDroppableFlag(oItemCursor, FALSE);
        SetPickpocketableFlag(oItemCursor, TRUE);
    }

    // Generate some gold on the target.
    if (iMaxGold > 0)
    {
        CreateItemOnObject("potsc_goldpiece", oTarget, iRandGold);
    }
}
