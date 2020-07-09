//Does the PC have the Use Poison feat?
int StartingConditional()
{
    if(GetHasFeat(FEAT_USE_POISON, GetPCSpeaker()))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
