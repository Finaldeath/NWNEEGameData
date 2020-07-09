int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF, "nTakenSword") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
