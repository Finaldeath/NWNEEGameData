//::///////////////////////////////////////////////
//:: con_a3_honey
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the NPC Speaker Honey Pea?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    int iResult = FALSE;

    if (GetTag(oSelf) == "a3_honey")
    {
        iResult = TRUE;
    }

    return iResult;
}
