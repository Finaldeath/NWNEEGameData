void main()
{
    if (GetLocalInt(GetModule(), "bHaratQuestItemFound") == FALSE)
    {
        SetLocalInt(GetModule(), "bHaratQuestItemFound", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bHaratQuestItemFound", FALSE);
    }
}
