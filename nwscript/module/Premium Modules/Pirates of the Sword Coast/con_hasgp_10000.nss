//::///////////////////////////////////////////////
//:: con_hasgp_10000
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have 10,000 gp or more?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iResult = FALSE;

    if (GetGold(oPC) >= 10000)
    {
        iResult = TRUE;
    }

    return iResult;
}
