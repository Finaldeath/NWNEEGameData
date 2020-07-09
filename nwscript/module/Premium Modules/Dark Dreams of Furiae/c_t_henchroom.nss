int StartingConditional()
{

    object oPC = GetPCSpeaker();

    int iHenchmanCounter = 0;
    int i;
    for(i = 1; i < 3; i++)
    {
        if(GetIsObjectValid(GetHenchman(oPC, i)) == TRUE) iHenchmanCounter += 1;
    }

    if(iHenchmanCounter >= 2) return TRUE;

    return FALSE;
}
