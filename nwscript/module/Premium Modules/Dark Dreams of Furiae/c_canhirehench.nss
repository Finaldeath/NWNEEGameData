int StartingConditional()
{
    object oPC = GetPCSpeaker();

    int iGold = GetGold(oPC);

    if(iGold < 50) return FALSE;

    int iHenchmanCounter = 0;
    int i;
    for(i = 1; i < 3; i++)
    {
        if(GetIsObjectValid(GetHenchman(oPC, i)) == TRUE) iHenchmanCounter += 1;
    }

    if(iHenchmanCounter >= 2) return FALSE;

    return TRUE;
}
