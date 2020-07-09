//::///////////////////////////////////////////////
//:: con_a1_fighton
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if anyone is currently fighting in the
    Troglodyte Arena
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oArea = GetObjectByTag("a1_trogarena");
    object oFighter = GetLocalObject(oArea, "A1_CURRFIGHTER");
    int iResult = FALSE;

    if (GetIsObjectValid(oFighter) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
