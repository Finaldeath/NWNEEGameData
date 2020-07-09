void main()
{
    if (GetLocalInt(GetModule(), "bGzhorbQuestActive") == FALSE)
    {
        SetLocalInt(GetModule(), "bGzhorbQuestActive", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bGzhorbQuestActive", FALSE);
    }
}
