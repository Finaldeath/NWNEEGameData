int StartingConditional()
{
    if(GetLevelByClass(CLASS_TYPE_MONK, GetPCSpeaker()) > 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
