int StartingConditional()
{
    // if maggris is dead
    if (GetLocalInt(GetModule(), "bMaggrisQuestCompleted") == TRUE)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
