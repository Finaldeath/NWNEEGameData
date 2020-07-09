//::///////////////////////////////////////////////
//:: potsc_trsr_high
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Create a High level treasure on the chest.

    Note: This script is called on open and
    destruction of a placable. However, it will
    only fire once per object.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////
#include "inc_bootysystem"

const int iMaxGold = 500;

void main()
{
    object oChest = OBJECT_SELF;
    int iGold = Random(iMaxGold) + 1;
    int iDoOnce = GetLocalInt(oChest, "potsc_trsr_high");

    // if this is the first time create some random treasure
    if (iDoOnce == FALSE)
    {
        SetLocalInt(oChest, "potsc_trsr_high", TRUE);
        CreateItemOnObject("potsc_goldpiece", oChest, iGold);
        CreateBootyOnObject(oChest, BOOTY_UNIQUE);
    }
}
