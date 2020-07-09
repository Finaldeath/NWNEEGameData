int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetGold(oPC)>=2)
    return TRUE;
    return FALSE;
}
