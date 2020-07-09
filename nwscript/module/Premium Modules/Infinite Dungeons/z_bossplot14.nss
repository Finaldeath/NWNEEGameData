void main()
{
    if (GetLocalInt(GetModule(), "bBacchaQuestItemFound") == FALSE)
    {
        SetLocalInt(GetModule(), "bBacchaQuestItemFound", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bBacchaQuestItemFound", FALSE);
    }
}
