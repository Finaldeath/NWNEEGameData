//::///////////////////////////////////////////////
//:: con_pcis_male
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the PC Speaker Male?
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

    if (iGender == GENDER_MALE)
    {
        iResult = TRUE;
    }

    return iResult;
}
