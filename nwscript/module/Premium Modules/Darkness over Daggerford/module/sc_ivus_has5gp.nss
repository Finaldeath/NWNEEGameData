int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetGold(oPC)>=5)
    return TRUE;
    return FALSE;
}
