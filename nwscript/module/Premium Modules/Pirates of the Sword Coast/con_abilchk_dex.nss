//::///////////////////////////////////////////////
//:: con_abilchk_dex
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script does a dexterity check on the PC
    speakers. It returns true if the PC has a
    +2 to dex or higher.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oSelf = OBJECT_SELF;

    int iStrength = GetAbilityModifier(ABILITY_DEXTERITY, oPC);
    int iResult = FALSE;

    if (iStrength > 1)
    {
        iResult = TRUE;
    }

    return iResult;
}
