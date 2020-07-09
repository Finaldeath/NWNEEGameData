void main()
{
    if (GetLocalInt(GetModule(), "bHaratOpened") == FALSE)
    {
        SetLocalInt(GetModule(), "bHaratOpened", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bHaratOpened", FALSE);
    }
}
