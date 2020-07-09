//::///////////////////////////////////////////////
//:: con_pcis_hmale
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the PC Speaker Male and handsom?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iGender = GetGender(oPC);
    int iCharisma = GetAbilityModifier(ABILITY_CHARISMA, oPC);
    int iResult = FALSE;

    if ((iGender == GENDER_MALE) && (iCharisma > 2))
    {
        iResult = TRUE;
    }

    return iResult;
}
