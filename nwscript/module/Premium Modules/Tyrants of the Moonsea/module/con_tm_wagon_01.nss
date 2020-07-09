int StartingConditional()
{
    if (GetHitDice(GetPCSpeaker()) < 12)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
