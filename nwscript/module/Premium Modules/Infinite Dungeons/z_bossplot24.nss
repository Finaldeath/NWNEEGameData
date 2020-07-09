void main()
{
    if (GetLocalInt(GetModule(), "bHagathaQuestItemFound") == FALSE)
    {
        SetLocalInt(GetModule(), "bHagathaQuestItemFound", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bHagathaQuestItemFound", FALSE);
    }
}
