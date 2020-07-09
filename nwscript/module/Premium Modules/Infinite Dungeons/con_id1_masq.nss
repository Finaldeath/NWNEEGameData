int StartingConditional()
{
    // if masterius is dead
    if (GetLocalInt(GetModule(), "bMasteriusQuestCompleted") == TRUE)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
