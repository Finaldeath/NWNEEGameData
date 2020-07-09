int StartingConditional()
{
    int bActive = GetLocalInt(GetModule(), "bGzhorbQuestActive");
    int bComplete = GetLocalInt(GetModule(), "bGzhorbQuestComplete");
    int bFound = GetLocalInt(GetModule(), "bGzhorbQuestItemFound");

    if ((bActive == TRUE) && (bComplete == FALSE) && (bFound == FALSE))
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
