//::///////////////////////////////////////////////
//:: con_chk_fighter
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the Primary class of the PC is
    a Fighter type (Fighter or Barbarian).
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

    if ((iClass == CLASS_TYPE_BARBARIAN) || (iClass == CLASS_TYPE_FIGHTER))
    {
        iResult = TRUE;
    }

    return iResult;
}
