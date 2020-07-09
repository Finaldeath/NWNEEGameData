int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(!GetLocalInt(oPC,"nDummyChamp") && GetLocalInt(oPC,"nHasPlayedDummyOnce"))
    {
        return TRUE;
    }
    return FALSE;
}
