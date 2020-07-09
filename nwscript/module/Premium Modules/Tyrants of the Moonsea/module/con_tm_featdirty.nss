int StartingConditional()
{
    if(GetHasFeat(FEAT_DIRTY_FIGHTING, GetPCSpeaker()))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
