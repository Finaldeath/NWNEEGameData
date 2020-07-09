int StartingConditional()
{
    if (GetLocalObject(GetModule(), "oCurrentDungeon") != OBJECT_INVALID)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
