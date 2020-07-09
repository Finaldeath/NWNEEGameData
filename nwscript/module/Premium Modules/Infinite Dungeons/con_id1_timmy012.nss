int StartingConditional()
{
    int bActive = GetLocalInt(GetModule(), "bMasteriusQuestActive");
    int bComplete = GetLocalInt(GetModule(), "bMasteriusQuestComplete");
    int bFound = GetLocalInt(GetModule(), "bMasteriusQuestItemFound");

    if ((bActive == TRUE) && (bComplete == FALSE) && (bFound == FALSE))
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
