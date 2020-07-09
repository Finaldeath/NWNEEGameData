void main()
{
    if (GetLocalInt(GetModule(), "bGzhorbQuestItemFound") == FALSE)
    {
        SetLocalInt(GetModule(), "bGzhorbQuestItemFound", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bGzhorbQuestItemFound", FALSE);
    }
}
