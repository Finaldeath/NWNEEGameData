int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF, "amberlynwaiting") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
