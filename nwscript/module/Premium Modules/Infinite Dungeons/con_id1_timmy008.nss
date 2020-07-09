int StartingConditional()
{
    int bActive = GetLocalInt(GetModule(), "bBacchaQuestActive");
    int bComplete = GetLocalInt(GetModule(), "bBacchaQuestComplete");
    int bFound = GetLocalInt(GetModule(), "bBacchaQuestItemFound");

    if ((bActive == TRUE) && (bComplete == FALSE) && (bFound == FALSE))
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
