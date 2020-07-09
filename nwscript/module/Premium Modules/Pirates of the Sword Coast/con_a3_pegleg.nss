//::///////////////////////////////////////////////
//:: con_a3_pegleg
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the NPC Speaker Pegleg Paulson?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    int iResult = FALSE;

    if (GetTag(oSelf) == "a3_pegleg")
    {
        iResult = TRUE;
    }

    return iResult;
}
