//::///////////////////////////////////////////////
//:: con_talkto0
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Checks if Cavallas has been talked to 0 times
*/
//:://////////////////////////////////////////////
//:: Created By: Drew Karpyshyn
//:: Created On: July 2, 2003
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iResult;

    iResult = GetLocalInt(GetModule(),"Cavallas_Talk")==0;
    return iResult;
}
