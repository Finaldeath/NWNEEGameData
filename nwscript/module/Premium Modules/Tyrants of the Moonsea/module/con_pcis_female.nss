//::///////////////////////////////////////////////
//:: con_pcis_female
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the PC Speaker female?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iGender = GetGender(oPC);
    int iResult = FALSE;

    if (iGender == GENDER_FEMALE)
    {
        iResult = TRUE;
    }

    return iResult;
}
