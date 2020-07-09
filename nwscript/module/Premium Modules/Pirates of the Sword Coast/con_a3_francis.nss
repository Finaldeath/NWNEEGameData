//::///////////////////////////////////////////////
//:: con_a3_francis
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the NPC Speaker Sir Francis?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    int iResult = FALSE;

    if (GetTag(oSelf) == "a3_francis")
    {
        iResult = TRUE;
    }

    return iResult;
}
