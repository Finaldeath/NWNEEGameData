//::///////////////////////////////////////////////
//:: con_q2crndtlk2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks if ambient random talk variable is at 2
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////


int StartingConditional()
{
    int iResult;

    iResult = GetLocalInt(GetModule(),"RandomTalk")==2;
    return iResult;
}

