//::///////////////////////////////////////////////
//:: con_a1firehigh
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script checks if the fire pits flame is
    currently burning at a high level.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    int iFire = GetLocalInt(oSelf, "iFIREHEIGHT");
    int iResult = FALSE;

    //15-20 high, 5-15 med, 1-5 low, 0 off
    if (iFire > 15)
    {
        iResult = TRUE;
    }

    return iResult;
}
