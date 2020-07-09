int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF, "iBurnedCommunique") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
