int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iRace = GetRacialType(oPC);
    int iResult = FALSE;

    if (iRace != IP_CONST_RACIALTYPE_HALFORC)
    {
        iResult = TRUE;
    }

    return iResult;
}
