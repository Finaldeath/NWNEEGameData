//::///////////////////////////////////////////////
//:: con_a3_riddle1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Which riddle should the pillar ask?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    string sTag = "A3_RIDDLE1";
    int iResult = FALSE;

    if (GetTag(oSelf) == sTag)
    {
        iResult = TRUE;
    }

    return iResult;
}
