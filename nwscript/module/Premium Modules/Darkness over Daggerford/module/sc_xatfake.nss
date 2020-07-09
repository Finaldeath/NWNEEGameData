int StartingConditional()
{
    if(GetLocalInt(GetModule(), "iTookFakeHeart") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
