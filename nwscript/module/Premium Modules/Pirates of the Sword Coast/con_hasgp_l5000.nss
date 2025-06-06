//::///////////////////////////////////////////////
//:: con_hasgp_l5000
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have less then 5000 gp?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iResult = FALSE;

    if (GetGold(oPC) < 5000)
    {
        iResult = TRUE;
    }

    return iResult;
}
