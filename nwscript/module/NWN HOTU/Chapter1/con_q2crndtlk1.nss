//::///////////////////////////////////////////////
//:: con_q2crndtlk1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks if ambient random talk variable is at 1
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////


int StartingConditional()
{
    int iResult;

    iResult = GetLocalInt(GetModule(),"RandomTalk")==1;
    return iResult;
}
