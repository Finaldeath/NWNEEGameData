//::///////////////////////////////////////////////
//:: con_pcis_smale
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the PC Speaker Male and strong?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iGender = GetGender(oPC);
    int iStrength = GetAbilityModifier(ABILITY_STRENGTH, oPC);
    int iResult = FALSE;

    if ((iGender == GENDER_MALE) && (iStrength > 2))
    {
        iResult = TRUE;
    }

    return iResult;
}
