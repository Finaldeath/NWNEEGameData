int StartingConditional()
{
    if(GetNearestObjectByTag("Elf") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
