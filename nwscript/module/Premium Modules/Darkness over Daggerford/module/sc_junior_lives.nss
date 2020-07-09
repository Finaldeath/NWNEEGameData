int StartingConditional()
{
    if(GetLocalInt(GetModule(), "iJuniorDead") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
