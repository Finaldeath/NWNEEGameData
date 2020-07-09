void main()
{
    if (GetLocalInt(GetModule(), "bHaratQuestActive") == FALSE)
    {
        SetLocalInt(GetModule(), "bHaratQuestActive", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bHaratQuestActive", FALSE);
    }
}
