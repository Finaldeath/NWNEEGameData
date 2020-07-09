void main()
{
    if (GetLocalInt(GetModule(), "bBacchaQuestActive") == FALSE)
    {
        SetLocalInt(GetModule(), "bBacchaQuestActive", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bBacchaQuestActive", FALSE);
    }
}
