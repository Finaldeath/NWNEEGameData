int StartingConditional()
{
    // if gzhorb is dead
    if (GetLocalInt(GetModule(), "bGzhorbQuestCompleted") == TRUE)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
