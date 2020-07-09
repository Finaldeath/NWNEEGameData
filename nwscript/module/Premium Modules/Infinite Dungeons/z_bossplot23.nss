void main()
{
    if (GetLocalInt(GetModule(), "bHagathaQuestActive") == FALSE)
    {
        SetLocalInt(GetModule(), "bHagathaQuestActive", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bHagathaQuestActive", FALSE);
    }
}
