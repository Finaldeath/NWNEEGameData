//::///////////////////////////////////////////////
//:: con_hasgpl_750
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have less then 750 gp?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iResult = FALSE;

    if (GetGold(oPC) < 750)
    {
        iResult = TRUE;
    }

    return iResult;
}
