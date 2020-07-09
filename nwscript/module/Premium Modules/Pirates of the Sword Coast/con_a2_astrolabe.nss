//::///////////////////////////////////////////////
//:: con_a2_astrolabe
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have Vantabular's astrolabe in
    their inventory?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oAstrolabe = GetItemPossessedBy(oPC, "a2_astrolabe");
    int iResult = FALSE;

    if (GetIsObjectValid(oAstrolabe) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
