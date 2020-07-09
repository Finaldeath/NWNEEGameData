//::///////////////////////////////////////////////
//:: con_a2_nwscepter
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have the Umberline Scepter?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oScepter = GetItemPossessedBy(oPC, "a2_nwscepter");
    int iResult = FALSE;

    if (GetIsObjectValid(oScepter) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
