int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF, "no_banter") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
