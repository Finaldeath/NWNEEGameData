int StartingConditional()
{
    int bActive = GetLocalInt(GetModule(), "bHagathaQuestActive");
    int bComplete = GetLocalInt(GetModule(), "bHagathaQuestComplete");
    int bFound = GetLocalInt(GetModule(), "bHagathaQuestItemFound");

    if ((bActive == TRUE) && (bComplete == FALSE) && (bFound == FALSE))
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
