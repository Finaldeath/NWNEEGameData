void main()
{
    if (GetLocalInt(GetModule(), "bMaggrisQuestActive") == FALSE)
    {
        SetLocalInt(GetModule(), "bMaggrisQuestActive", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bMaggrisQuestActive", FALSE);
    }
}
