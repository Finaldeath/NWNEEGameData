//::///////////////////////////////////////////////
//:: con_chk_clerical
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the Primary class of the PC is
    a Preist type (Cleric, Monk, or Paladin).
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

    if ((iClass == CLASS_TYPE_CLERIC) || (iClass == CLASS_TYPE_MONK)
        || (iClass == CLASS_TYPE_PALADIN))
    {
        iResult = TRUE;
    }

    return iResult;
}
