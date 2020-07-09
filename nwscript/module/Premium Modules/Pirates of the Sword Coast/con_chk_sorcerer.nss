//::///////////////////////////////////////////////
//:: con_chk_sorcerer
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the Primary class of the PC is
    Arcane.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iClass  = GetClassByPosition(1, oPC);
    int iResult = FALSE;

    if ((iClass == CLASS_TYPE_SORCERER) || (iClass == CLASS_TYPE_WIZARD))
    {
        iResult = TRUE;
    }

    return iResult;
}
