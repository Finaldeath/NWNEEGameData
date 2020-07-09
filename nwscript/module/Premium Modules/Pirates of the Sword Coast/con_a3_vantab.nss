//::///////////////////////////////////////////////
//:: con_a3_vantab
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the NPC Speaker Vantabular?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    int iResult = FALSE;

    if (GetTag(oSelf) == "a3_vantab")
    {
        iResult = TRUE;
    }

    return iResult;
}
