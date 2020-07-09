//:://////////////////////////////////////////////
//:: con_rand_1_5
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    A five to one random chance the the dialog wiil
    be displayed. This is for use on random line
    spewing NPCs.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Aug, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iResult;
    int iRand = Random(5);

    // If the fvalue is 0 return true
    iResult = (iRand == 0);

    return iResult;
}
