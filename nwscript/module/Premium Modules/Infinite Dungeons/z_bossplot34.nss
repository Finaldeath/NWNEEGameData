void main()
{
    if (GetLocalInt(GetModule(), "bMaggrisQuestItemFound") == FALSE)
    {
        SetLocalInt(GetModule(), "bMaggrisQuestItemFound", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bMaggrisQuestItemFound", FALSE);
    }
}
