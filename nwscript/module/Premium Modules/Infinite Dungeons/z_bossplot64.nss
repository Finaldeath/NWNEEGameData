void main()
{
    if (GetLocalInt(GetModule(), "bMasteriusQuestItemFound") == FALSE)
    {
        SetLocalInt(GetModule(), "bMasteriusQuestItemFound", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bMasteriusQuestItemFound", FALSE);
    }
}
