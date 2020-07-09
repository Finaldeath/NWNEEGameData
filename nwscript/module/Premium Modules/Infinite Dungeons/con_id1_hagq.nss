int StartingConditional()
{
    // if hagatha is dead
    if (GetLocalInt(GetModule(), "bHagathaQuestCompleted") == TRUE)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
