// have less then 2 henchpersons
// BUT don't have the 50 gp.

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    int iGold = GetGold(oPC);

    if(iGold >= 50) return FALSE;

    int iC = 0;
    int i;
    for(i = 1; i < 3; i++)
    {
        if(GetIsObjectValid(GetHenchman(oPC, i)) == TRUE) iC += 1;
    }

    if(iC >= 2) return FALSE;

    return TRUE;
}
