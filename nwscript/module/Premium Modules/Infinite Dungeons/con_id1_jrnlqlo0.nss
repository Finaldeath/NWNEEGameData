int StartingConditional()
{
    int nOffset = GetLocalInt(OBJECT_SELF, "nQuestLogOffset");

    if (nOffset > 0)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
