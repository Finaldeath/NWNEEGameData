//::///////////////////////////////////////////////
//:: MALLRANDOM.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Returns true 50% of the time.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: January 2002
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iResult;

    iResult = Random(100) < 50;
    return iResult;
}