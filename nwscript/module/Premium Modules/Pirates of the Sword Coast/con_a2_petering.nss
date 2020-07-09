//::///////////////////////////////////////////////
//:: con_a2_petering
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have Rascally Pete's ring in
    their inventory?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oRing = GetItemPossessedBy(oPC, "a2_petering");
    int iResult = FALSE;

    if (GetIsObjectValid(oRing) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
