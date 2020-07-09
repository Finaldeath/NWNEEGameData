int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF, "iGhostSmithComplete") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
