int StartingConditional()
{
    int bActive = GetLocalInt(GetModule(), "bMaggrisQuestActive");
    int bComplete = GetLocalInt(GetModule(), "bMaggrisQuestComplete");
    int bFound = GetLocalInt(GetModule(), "bMaggrisQuestItemFound");

    if ((bActive == TRUE) && (bComplete == FALSE) && (bFound == FALSE))
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
