int StartingConditional()
{
     if(GetLocalInt(OBJECT_SELF, "nBribed") == 1)
     {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
