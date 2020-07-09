int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF, "iFavourable") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
