void main()
{
    if (GetLocalInt(GetModule(), "bMasteriusQuestActive") == FALSE)
    {
        SetLocalInt(GetModule(), "bMasteriusQuestActive", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bMasteriusQuestActive", FALSE);
    }
}
