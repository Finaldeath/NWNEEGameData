int StartingConditional()
{
    // if maggris is dead
    if ((GetLocalInt(GetModule(), "bMaggrisQuestCompleted") == FALSE) &&(GetLocalInt(GetModule(), "bMaggrisQuestActive") == TRUE))
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
