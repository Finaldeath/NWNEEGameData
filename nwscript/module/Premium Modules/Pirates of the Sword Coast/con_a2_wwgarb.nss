//::///////////////////////////////////////////////
//:: con_a2_wwgarb
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have Willigans Garb?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oWWGarb = GetItemPossessedBy(oPC, "a2_wwgarb");
    int iResult = FALSE;

    if (GetIsObjectValid(oWWGarb) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
