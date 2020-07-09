int StartingConditional()
{
    // if harat is dead
    if (GetLocalInt(GetModule(), "bHaratQuestCompleted") == TRUE)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
