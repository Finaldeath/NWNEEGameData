int StartingConditional()
{
    // if baccha is dead
    if (GetLocalInt(GetModule(), "bBacchaQuestCompleted") == TRUE)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
