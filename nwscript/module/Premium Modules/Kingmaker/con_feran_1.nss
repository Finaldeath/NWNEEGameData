//::///////////////////////////////////////////////
//:: Name
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Check if Feran is in the Mossy Tree.
*/
//:://////////////////////////////////////////////
//:: Created By: Dan Whiteside
//:: Created On: Sept. 2003
//:://////////////////////////////////////////////
int StartingConditional()
{
    if (GetLocalInt(OBJECT_SELF,"OS_FERANATBAR")==1)
        return TRUE;
    return FALSE;
}