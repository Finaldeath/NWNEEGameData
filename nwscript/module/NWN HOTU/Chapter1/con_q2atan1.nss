//::///////////////////////////////////////////////
//:: Name
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Check if Tanarell is happy.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
int StartingConditional()
{
    int iResult;

    iResult = GetLocalInt(GetModule(),"XP_TANARELLSPEAK")==20;
    return iResult;
}