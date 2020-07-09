int StartingConditional()
{
     if(GetLocalInt(OBJECT_SELF, "nSurrendered") == 1)
     {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
