int StartingConditional()
{
    int bActive = GetLocalInt(GetModule(), "bHaratQuestActive");
    int bComplete = GetLocalInt(GetModule(), "bHaratQuestComplete");
    int bFound = GetLocalInt(GetModule(), "bHaratQuestItemFound");

    if ((bActive == TRUE) && (bComplete == FALSE) && (bFound == FALSE))
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
