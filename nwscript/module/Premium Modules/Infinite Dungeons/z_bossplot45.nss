void main()
{
    if (GetLocalInt(GetModule(), "bHaratCompleted") == FALSE)
    {
        SetLocalInt(GetModule(), "bHaratCompleted", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bHaratCompleted", FALSE);
    }
}
